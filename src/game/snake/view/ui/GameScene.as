package game.snake.view.ui
{
	
	import common.tools.StringUtils;
	
	import game.snake.model.CollisionGrid;
	import game.snake.model.LuanMath;
	import game.snake.model.SnakeConfig;
	
	import laya.display.Sprite;
	import laya.events.Event;
	import laya.maths.Point;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Pool;
	import laya.utils.Tween;
	

	/**
	 * Game
	 * 游戏入口类
	 */
	
	public class GameScene extends Sprite
	{
		private var stageW:Number;
		private var stageH:Number;
		
		private var gameMainUI: GameMain;
		
		private var gameMode: Number//0单人模式，1多人模式
		
		private var foodInitNum: Number = SnakeConfig.foodInitNum;
		private var foodMaxNum: Number = SnakeConfig.foodMaxNum;
		private var foodNum: Number = 0
		private var foodArr: Array = [];
		private var snakeSelf: Snake;
		
		private var SnakeAINum: Number = SnakeConfig.SnakeAINum;
		private var snakeArr: Array = [];
		
		private const GRID_SIZE1:Number=80;
		private const GRID_SIZE2:Number=40;
		private var _grid1:CollisionGrid;
		private var _grid2:CollisionGrid;

		private var foodLayer:Sprite;
		private var snakeLayer:Sprite;
		
		private var map:SnakeMap;
		
		//游戏计时
		private var gameTime:int = 0;
		
		//游戏结算
		private var gameOver:GameOver;
		
		private var timeBoxPos:Point = new Point(512,36);
		private var timeBoxWarnPos:Point = new Point(700,40);
		
		public function GameScene()
		{
			stageW = SnakeConfig.stageW; 
			stageH = SnakeConfig.stageH;
			
			Laya.stage.bgColor = "#8cbdd0";
			Laya.stage.frameRate=laya.display.Stage.FRAME_FAST;
			
			//Stat.show(350, 10);

			this.gameMain();
			this.gameMainUI.btn_out.on(Event.CLICK,this,this.btnOutClick);
		}
		//进行游戏
		private function gameMain(): void 
		{
			this.gameMainUI = new GameMain()
			this.addChild(this.gameMainUI);
			SnakeConfig.selfDie = false;
			gameMainUI.liquanBox.visible = false;
			
			map = new SnakeMap();
			addChild(map);
			
			foodLayer = new Sprite();
			this.map.addChild(foodLayer);
			_grid1=new CollisionGrid(SnakeConfig.mapW,SnakeConfig.mapH,GRID_SIZE1);
//			_grid1.drawGrid(foodLayer.graphics);
//			foodLayer.alpha = 1;
			
			snakeLayer = new Sprite();
			this.map.addChild(snakeLayer);
			_grid2=new CollisionGrid(SnakeConfig.mapW,SnakeConfig.mapH,GRID_SIZE2);
//			_grid2.drawGrid(snakeLayer.graphics);
//			snakeLayer.alpha = 0.5;
			
			this.map.pos(this.stageW - SnakeConfig.mapW / 2,this.stageH - SnakeConfig.mapH / 2);
			
			initGame();
		}
		
		private function initGame():void
		{
			initTimeBox();
			gameTime = SnakeConfig.gameMaxTime;
			
			creatFood();
			creatSnake();
			
			Laya.timer.frameLoop(1, this, this.gameLoop);
			Laya.timer.loop(1000,this,updateTime);
			updateTime();
		}
		
		private function initTimeBox():void
		{
			this.gameMainUI.timeBox.alpha = 1;
			this.gameMainUI.timeBox.scale(1,1);
			this.gameMainUI.timeBox.pos(timeBoxPos.x,timeBoxPos.y);
		}
		
		private function creatFood():void
		{
			//创建食物
			for (var _bean_i:int = 0; _bean_i < this.foodInitNum; _bean_i++)
			{
				this.addFood();
			}
			Laya.timer.loop(5000,this,addFoodRandom);
		}
		
		private function creatSnake():void
		{
			//创建蛇
			for (var index = 0; index < this.SnakeAINum + 1; index++) 
			{
				var isAI:Boolean = (index==0?false:true);//联网的话 不是ai也可能是别的玩家
				var isHero:Boolean = (index==0?true:false);//主角只是自己控制的蛇
				var snake: Snake = new Snake(isHero,isAI);
				snake.moveOutHandler = new Handler(this,snakeMoveOut);
				snakeArr.push(snake);
				snakeLayer.addChild(snake);
				
				//自己控制的蛇
				if(index==0)
				{
					this.snakeSelf = snake;
					SnakeConfig.snakeSelf = this.snakeSelf;
					
					map.setFollow(this.snakeSelf);
				}
			}
		}
		
		private function onReplayClick():void
		{
			replay();
		}
		
		
		
		private function replay():void
		{
			if(gameOver!=null)
			{
				gameOver.clear();
				gameOver.removeSelf();
			}
			//数据重置
			SnakeConfig.clear();
			//清楚缓动
			tweenOk();
			//清空地图
			resetMap();
			//游戏初始化
			initGame();
		}
		
		private function updateTime():void
		{
			var fen:int = Math.floor(gameTime/60);
			var fenStr:String = StringUtils.padLeft(fen+"","0",2);
			var miao:int = gameTime-fen*60;
			var miaoStr:String = StringUtils.padLeft(miao+"","0",2);
			this.gameMainUI.timeTxt.text = fenStr+":"+miaoStr;
			
			if(gameTime <= 0)
			{
				initTimeBox();
				//清空时间
				Laya.timer.clearAll(this);
				//时间到
				//QuickUtils.PopAlert("时间到了","提示",this,outGame);
				if(gameOver==null)
				{
					gameOver = new GameOver();
					gameOver.btn_replay.on(Event.CLICK,this,onReplayClick);
					gameOver.btn_out.on(Event.CLICK,this,outGame);
				}
				gameOver.setResult(SnakeConfig.selfMaxLen,SnakeConfig.killNum,SnakeConfig.dieNum);
				addChild(gameOver);
				var obj:Object  ={"ret":0,"ticket_num":3552}
				//获取奖励
				onRewardOk(JSON.stringify(obj));
			}
			else
			{
				if(gameTime <= 10)
				{
					showWarn();
				}
			}
			gameTime--;	
		}
		
		private function showWarn():void
		{
			this.gameMainUI.timeBox.scale(1,1);
			this.gameMainUI.timeBox.alpha = 1;
			this.gameMainUI.timeBox.pos(timeBoxPos.x,timeBoxPos.y);
			Tween.to(this.gameMainUI.timeBox,{x:timeBoxWarnPos.x,y:timeBoxWarnPos.y,scaleX:5,scaleY:5,alpha:0.5},400,Ease.bounceOut,null,500);
		}
		
		private var soreSpr:Sprite;
		private function onRewardOk(str:String):void
		{
			var obj:Object = JSON.parse(str);
			trace("str==>"+str);
			//{"ret":0,"ticket_num":3552}
			gameMainUI.liquanBox.visible = true;
			if(soreSpr)
			{
				soreSpr.removeSelf();
				soreSpr = null;
			}
			soreSpr = QuickUtils.createNumberSprite("ddz/result/yellow/","yellow_",22,obj.ticket_num,"+");
			gameMainUI.liquanBox.addChild(soreSpr);
			Laya.stage.addChild(gameMainUI.liquanBox);
			if(gameOver!=null)
			{
				gameOver.setLiQuan(obj.ticket_num);
			}
			Laya.timer.once(1000,this,showTween);
		}
		
		private function showTween():void
		{
			if(gameMainUI.liquanBox)
			{
				Tween.to(gameMainUI.liquanBox,{y:400},1500,Ease.strongOut,Handler.create(this,tweenOk));
			}
		}
		
		private function tweenOk():void
		{
			trace("tweenOktweenOk");
			if(gameMainUI.liquanBox)
			{
				Tween.clearTween(gameMainUI.liquanBox);
				gameMainUI.liquanBox.visible = false;
				gameMainUI.addChild(gameMainUI.liquanBox);
			}
		}
		private function btnOutClick():void
		{
			if(gameTime>0)
			{
				initTimeBox();
				Laya.timer.clear(this, this.gameLoop);
				Laya.timer.clear(this,updateTime);
			}
		}
		private function btnOutClickOk(ok:int):void
		{
			if(ok==0)
			{
				outGame();	
			}
			else
			{
				Laya.timer.frameLoop(1, this, this.gameLoop);
				Laya.timer.loop(1000,this,updateTime);
			}
		}
		private function outGame():void
		{
			Laya.stage.frameRate=laya.display.Stage.FRAME_SLOW;
		}
		
		//游戏主循环
		private function gameLoop(): void 
		{
//			SnakeConfig.snakeSelf.update();
			this.snakeMove();
			this.map.update();
			this.gameMainUI.text_length.text = SnakeConfig.selfMaxLen + "m";
			//this.gameMainUI.text_kill.text = "击杀:"+SnakeConfig.killNum;
			
			//蛇检查
			sheHit();
			//蛇食物
			sheEat();
			
			snakeAIMove();
		}
		
		//ai移动避开墙壁。。
		private function snakeAIMove(): void 
		{
			for (var index:int = 1; index < this.snakeArr.length; index++)
			{
				var snakeAI:Snake = this.snakeArr[index];
				var shetou:She = snakeAI.shetou;
				var radius:Number = shetou.radius;
				//满足一个条件 就需要转向
				if (shetou.x + 4*radius > SnakeConfig.mapW || shetou.x - 4*radius < 0
					||shetou.y + 4*radius > SnakeConfig.mapH || shetou.y - 4*radius < 0)
				{
					var hitDis: Number = 90 / snakeAI.speedObj[SnakeConfig.rotation] * snakeAI.speed + radius / 2;
					var hitPos: Point = new Point();
					var arr:Array = LuanMath.getVbackSpeed(shetou.rotation,hitDis);
					hitPos.x = arr[0]+ shetou.x;
					hitPos.y = arr[1]+ shetou.y;
					//边界碰撞判断 判断蛇头是否快碰撞到
					if (hitPos.x+radius >= SnakeConfig.mapW || hitPos.x-radius <= 0
						|| hitPos.y+radius >= SnakeConfig.mapH || hitPos.y-radius <= 0)
					{
						snakeAI.reverseRotation();
					}
				}
			}
		}
		
		private function sheEat(): void 
		{
			_grid1.assign(this.foodArr);
			
			var shet:*;
			for (var i = 0; i < this.snakeArr.length; i++)
			{
				shet = this.snakeArr[i].shetou;
				var checks:Array = _grid1.checkHeroGrid(shet);
				
				var numChecks:int = checks.length;
				for (var j:int = 0; j < numChecks; j += 2) 
				{
					checkCollision1(checks[j],checks[j + 1]);
				}
			}
		}
		/**
		 * 
		 * @param ballA  肯定是蛇头
		 * @param ballB  肯定是食物
		 * 
		 */		
		private function checkCollision1(ballA:*, ballB:*):void 
		{
			var snake:Snake = ballA.snake;
			var shetou:* = ballA;
			var bean:Food = ballB;

			var dist:Number = LuanMath.distance(bean.x, bean.y, shetou.x, shetou.y);
			var radius:Number = ballA.radius+ballB.radius;
			if (dist< radius/2)
			{
				var i:int=foodArr.indexOf(bean);
				if(i!=-1)
				{
					snake.eatFood(bean.addBlood);
					removeFood(bean,i);
				}
			}
			else if(dist <= radius) 
			{
				var arr:Array = LuanMath.Vspeed(bean.x,bean.y,shetou.x,shetou.y,bean.speed);
				bean.x += arr[0];
				bean.y += arr[1];
			}
		}
		
		private function sheHit(): void 
		{
			var _balls:Array = [];
			var tempArr:Array = [];
			var shet:*;
			//所有蛇
			for (var j = 0; j < this.snakeArr.length; j++)
			{
				tempArr = this.snakeArr[j].bodyArr;
				_balls = _balls.concat(tempArr);	
			}
			if(_balls.length!=0)
			{
				_grid2.assign(_balls);
			}
			
			for (var i = 0; i < this.snakeArr.length; i++)
			{
				shet = this.snakeArr[i].shetou;
				
				var checks:Array = _grid2.checkHeroGrid(shet);
				var numChecks:int = checks.length;
				for (var j:int = 0; j < numChecks; j += 2) 
				{
					checkCollision(checks[j],checks[j + 1]);
				}
			}
		}
		
		/**
		 * 
		 * @param ballA  肯定是蛇头
		 * @param ballB	 可能是蛇头 可能是蛇身体
		 * 
		 */		
		private function checkCollision(ballA:*, ballB:*):void 
		{
			//不是同一条蛇
			if(ballA.name!=ballB.name)
			{
				//蛇头撞别人 死。。
				var snake:Snake = ballA.snake;
				var snakeKiller:Snake = ballB.snake;

				var dist:Number = LuanMath.distance(ballA.x, ballA.y, ballB.x, ballB.y);
				var radius:Number = ballA.radius+ballB.radius;
				if (dist< radius/2)
				{
					if(!snake.wudi && !snakeKiller.wudi)
					{
						snakeDie(snake,snakeKiller);	
					}
				} 
				else 
				{
					if(dist< 2*radius)
					{
						//如果会相撞 
						if(snake==this.snakeSelf)
						{
							//是玩家 另一条蛇如果是头那么蛇转向
							if(snakeKiller.isAI && ballB.isHead)
							{
								snakeKiller.reverseRotation();
							}
						}
						else
						{
							if(snake.isAI)
							{
								//不是玩家 那么蛇提前转向 
								snake.reverseRotation();	
							}
						}
					}
				}
			}
		}

		private function removeFood(food:Food,i:int): void 
		{
			//蛇死掉生成的食物移除掉
			if (this.foodNum > this.foodMaxNum) 
			{
				food.setPos();
				this.foodArr.splice(i,1);
				food.remove();
				this.foodNum--;
			}
			else
			{
				food.skin();
				food.setPos();	
			}
			SnakeConfig.foodArr = this.foodArr;
		}
			
		/**
		 * 食物等级 
		 * @return 
		 */		
		private function addFood(foodLv:String=SnakeConfig.food_small,p:Point=null,colorNum:int=-1): void 
		{
			var food:Food = Pool.getItemByClass(SnakeConfig.FOOD,Food);
			//有固定点 说明是蛇死掉的
			if(p!=null)
			{
				food.skin(foodLv,colorNum);
				food.setPos(p.x,p.y);
			}
			else
			{
				food.skin();
				food.setPos();
			}
			this.foodArr.push(food);
			foodLayer.addChild(food);
			this.foodNum++;
			SnakeConfig.foodArr = this.foodArr;
		}
		
		//小于foodMaxNum就创建20个食物
		private function addFoodRandom(): void 
		{
			if (this.foodNum < this.foodMaxNum) 
			{
				for (var index = 0; index < 20; index++) 
				{
					this.addFood();
				}
			}
		}
		
		private function snakeMove(): void 
		{
			for (var i = 0; i < this.snakeArr.length; i++) 
			{
				var snake:Snake = this.snakeArr[i] as Snake;
				snake.update();
			}
		}
		
		/**
		 * 
		 * @param snake //死亡处理 snake被杀的蛇  
		 * @param killer //killer杀手
		 * 
		 */		
		private function snakeDie(snake:Snake,killer:Snake):void
		{
			killer.kill++;
			if(SnakeConfig.snakeSelf == snake)
			{
				//自己死亡次数
				SnakeConfig.dieNum++;
				//SnakeConfig.selfDie = true;
				//Laya.timer.clearAll(this);
				trace("自己死亡 游戏结束");				
				//死蛇转化成食物
				snakeDieToFood(snake);
				snake.isDie = true;
				snake.reLife();
			}
			else
			{
				//自己杀蛇总数量
				if(SnakeConfig.snakeSelf == killer)
				{
					SnakeConfig.killNum++;
				}
				
				//死蛇转化成食物
				snakeDieToFood(snake);
				
				snake.isDie = true;
//				trace("AI死亡 游戏继续");
				snake.reLife();
			}
		}
		
		private function snakeMoveOut(snake:Snake):void
		{
			snakeDieToFood(snake);
		}
		
		private function snakeDieToFood(snake:Snake):void
		{
			var len:int = snake.bodyArr.length;//蛇的血量
			for(var i:int=0;i<len;i++)
			{
				var x:Number = snake.bodyArr[i].x + SnakeConfig.getRandom(-20,20);
				var y:Number = snake.bodyArr[i].y + SnakeConfig.getRandom(-20,20);
				var p:Point = new Point(x,y);
				addFood(SnakeConfig.food_big,p);//snake.colorNum);
			}
//				trace("死蛇转化成食物");
//			var len:int = snake.bodyArr.length*5;//蛇的血量
//			len = Math.floor(len/2);//食物数量
//			var plen:int = snake.pathArr.length;
//			len = Math.floor(plen/len);
//			if(len <= 0)len=1;
//			for(var i:int=0;i<plen;i+=len)
//			{
//				var x:Number = snake.pathArr[i].x + SnakeConfig.getRandom(-20,20);
//				var y:Number = snake.pathArr[i].y + SnakeConfig.getRandom(-20,20);
//				var p:Point = new Point(x,y);
//				addFood(SnakeConfig.food_big,p);//snake.colorNum);
//			}
		}
		
		private function resetMap():void
		{
			//清空时间
			Laya.timer.clearAll(this);
			//清空蛇
			while (this.snakeArr.length!=0) 
			{
				this.snakeArr[0].removeSelf();
				this.snakeArr[0].clearAll();
				this.snakeArr.splice(0,1);
			}
			this.snakeArr = []
			//清食物
			while (this.foodArr.length!=0) 
			{
				this.foodArr[0].removeSelf();
				this.foodArr.splice(0,1);
			}
			this.foodArr = [];
		}
		//清空所有
		public function clearAll():void
		{
			if(gameOver!=null)
			{
				gameOver.clear();
				gameOver.offAll();
				gameOver.removeSelf();
				gameOver = null;
			}
			this.gameMainUI.clearAll();
			this.gameMainUI.btn_out.off(Event.CLICK,this,this.outGame);
			
			tweenOk();
			
			clearMap();
			
			//情况缓存
			Pool.clearBySign(SnakeConfig.SNAKE);
			Pool.clearBySign(SnakeConfig.SNAKEBODY);
			Pool.clearBySign(SnakeConfig.FOOD);
		}
		
		private function clearMap():void
		{
			//清空时间
			Laya.timer.clearAll(this);
			//清空蛇
			while (this.snakeArr.length!=0) 
			{
				this.snakeArr[0].removeSelf();
				this.snakeArr[0].clearAll();
				this.snakeArr[0] = null;
				this.snakeArr.splice(0,1);
			}
			this.snakeArr = []
			//清食物
			while (this.foodArr.length!=0) 
			{
				this.foodArr[0].removeSelf();
				this.foodArr[0] = null;
				this.foodArr.splice(0,1);
			}
			this.foodArr = [];
		}
		
	}
}

