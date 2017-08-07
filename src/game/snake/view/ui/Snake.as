package game.snake.view.ui
{
	import game.snake.model.LuanMath;
	import game.snake.model.SnakeConfig;
	
	import laya.ui.Image;
	import laya.ui.Label;
	import laya.utils.Handler;
	import laya.utils.Pool;

	public class Snake extends SnakeAI
	{
		private var _isDie:Boolean = false;
		private var _wudi:Boolean = true;//3秒无敌
		private var _isAI: Boolean = false;
		
		//多少血增加一节身体
		private var oneBodyBlood: Number = SnakeConfig.oneBodyBlood;
		//蛇最大长度
		private var bodyMaxNum: Number = SnakeConfig.bodyMaxNum;
		//默认尺寸
		public var snakeInitScale: Number = SnakeConfig.snakeInitScale;
		//最大尺寸
		public var snakeMaxScale: Number = SnakeConfig.snakeMaxScale;
		//速度配置
		public var speedObj: Object = SnakeConfig.speedObj;
		//蛇的尺寸
		public var snakeScale: Number;
		
		//蛇身体的长度
		private var _snakeLen:int = 0;
		//蛇身体的血量
		private var _snakeBlood:int = 0;
		//临时加血量
		private var tempblood:int = 0;
		
		//所有蛇包含头存储
		public var bodyArr: Array = [];
		//当前速度类型
		private var _speedNow: String = SnakeConfig.slow;
		//蛇速度
		private var _speed: Number = 0;
		
		//杀死蛇数量
		private var _kill: Number = 0;
		//蛇的颜色
		public var colorNum: Number = 0;
		//身体间距
		private var bodySpace: Number = 20;
		//旋转角度
		private var rotationTemp: Number = 0;
		//路径
		public var pathArr: Array = [];
		//初始宽
		private var initWidth: Number = 40;
		//移除画面回调
		public var moveOutHandler:Handler;
		
		private var _snakeid:int = 0;
		
		private var nnTxt:Label;
		private var killImg:Image;
		
		//主角
		private var _isHero:Boolean = false;
		
		public function Snake(isHero:Boolean=false,isAI:Boolean = false)
		{
			this._isHero = isHero;
			this._isAI = isAI;
			
			_snakeid = SnakeConfig.snakeid++;
			
			shetou = Pool.getItemByClass(SnakeConfig.SNAKEBODY,She);
			addChild(shetou);
			
			nnTxt = new Label();
			addChild(nnTxt);
			
			killImg = new Image();
			addChild(killImg);
			
			this.zOrder = 11000;
		
			this.init();
			if(!this._isAI)
			{
				this.wudi = true;
			}
		}
		
		public function get kill():Number
		{
			return _kill;
		}

		public function set kill(value:Number):void
		{
			_kill = value;
			setKillNum();
		}

		public function get speedNow():String
		{
			return _speedNow;
		}

		public function set speedNow(value:String):void
		{
			_speedNow = value;
			if(_speedNow == SnakeConfig.fast)
			{
				shetou.jiasu.visible = true;
			}
			else
			{
				shetou.jiasu.visible = false;
			}
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

		public function get isHero():Boolean
		{
			return _isHero;
		}

		public function get isAI():Boolean
		{
			return _isAI;
		}

		public function get snakeBlood():Number
		{
			return _snakeBlood;
		}

		public function get wudi():Boolean
		{
			return _wudi;
		}

		public function set wudi(value:Boolean):void
		{
			_wudi = value;
			for(var i:int=0;i<this.bodyArr.length;i++)
			{
				this.bodyArr[i].wudi = _wudi;
			}
			
			if(_wudi==true)
			{
				Laya.timer.once(SnakeConfig.wudiTime,this,wudiEnd);
			}
		}

		private function wudiEnd():void
		{
			wudi = false;
		}
		
		public function get snakeid():int
		{
			return _snakeid;
		}

		private function setName():void
		{
			this.nnTxt.text = "snake"+snakeid;
			this.nnTxt.pivot(this.nnTxt.width/2,this.nnTxt.height/2);
			this.nnTxt.zOrder = this.zOrder+1;
		}
		
		private function setKillNum():void
		{
			if(_kill==0)
			{
				this.killImg.skin = "";
			}
			else
			{
				var k:int = _kill>10?10:_kill;
				this.killImg.skin = "snake/杀"+k+".png";
				this.killImg.pivot(this.killImg.width/2,this.killImg.height/2);
				this.killImg.zOrder = this.zOrder+2;	
			}
		}
		
		private function init():void
		{
			this.setName();
			
			this.isDie = false;
			this.wudi = false;
			this.rotation = 0;
			this.kill = 0;
			this.targetR = 0; 
			this.bodyArr = [];
			this.pathArr = [];
			this.speedNow = SnakeConfig.slow;
			
			this.speed = this.speedObj[this.speedNow]
			this.targetR = this.rotation;
			this.snakeScale = this.snakeInitScale;
			
			setBodySpace();
			
			this.rotationTemp = this.rotation;
			
			this._snakeLen = SnakeConfig.snakeInitLen;
			var _x:Number = SnakeConfig.mapW / 2;
			var _y:Number = SnakeConfig.mapH / 2;
			
			//设置AI
			if(this._isAI)
			{
				this.colorNum = SnakeConfig.snakeColor();
				
				this._snakeLen = SnakeConfig.randomSnakeLen();
				var initX:Number = 100+bodySpace*_snakeLen;
				_x = SnakeConfig.getRandom(initX,SnakeConfig.mapW-initX);
				_y = SnakeConfig.getRandom(30,SnakeConfig.mapH-30);
				
				snakeAIRotation();
				Laya.timer.loop(SnakeConfig.getRandom(3000,5000),this,snakeAIRotation);
//				_x = _x+10;
//				_y = _y+50;
			}
			else
			{
				//如果联网的 蛇的颜色需要修改
				if(this.colorNum<=0)
				{
					this.colorNum = SnakeConfig.snakeColor();
				}
			}
			
			this._snakeBlood = this._snakeLen*SnakeConfig.oneBodyBlood;
			
			this.visible = true;
			loaded(_x,_y);
		}
		
		//复活
		public function reLife():void
		{
			isDie = false;
			this.init();
			this.wudi = true;
		}

		public function get isDie():Boolean
		{
			return _isDie;
		}

		public function set isDie(value:Boolean):void
		{
			_isDie = value;
			
			this.visible = !_isDie;
			if(_isDie)
			{
				Laya.timer.clearAll(this);
				
				for(var i:int=1;i<bodyArr.length;i++)
				{
					this.removeChild(bodyArr[i]);
					//回收到对象池
					Pool.recover(SnakeConfig.SNAKEBODY, bodyArr[i]);
				}
				bodyArr = [];
			}
		}

		//从 0 到 180 的值表示顺时针方向旋转；
		//从 0 到 -180 的值表示逆时针方向旋转。
		//对于此范围之外的值，可以通过加上或减去 360 获得该范围内的值
		private function snakeAIRotation(): void 
		{
			this.targetR = 180 - Math.random() * 360;
			this.speedNow = Math.random() > 0.9 ? "fast" : "slow";
		}
		
		private function loaded(x: Number, y: Number): void 
		{
			for (var i:int = 0; i <= this._snakeLen ; i++) 
			{
				this.addShe(i,-bodySpace*i + x,y,this.rotation)
			}
			this.sizeCheck();
			for (i = 0; i < this.bodySpace * this._snakeLen; i++) 
			{
				this.pathArr.push({x:shetou.x - i, y: this.shetou.y});
			}
			
			//算出蛇的长度 长度-默认长度
			_snakeLen = _snakeLen - SnakeConfig.snakeInitLen;
		}
		
		private function setBodySpace():void
		{
			this.bodySpace = Math.floor(this.shetou.radius / 10 * 5);
		}

		public function update():void 
		{
			if(this.isDie==false)
			{
				setBodySpace();
//				if(this._isAI)
//				{
//					this.AIMove();
//				}
				move();
			}
		}
		
		private function move():void
		{
			this.headMove();
			this.bodyMove();
			
			this.speedChange();
			this.rotationChange();
		}

		private function moveOut(): void 
		{
			if(moveOutHandler!=null)
			{
				moveOutHandler.runWith(this);
			}
			
			this.isDie = true;
			//trace("碰到边界了isAI=>"+isAI);
			this.reLife();
		}
		
		private var space:int = 40;
		private function headMove(): void 
		{
			//x,y移动的距离
			var arr:Array = LuanMath.getVbackSpeed(shetou.rotation,this.speed);
			var x:Number = arr[0];
			var y:Number = arr[1];
			shetou.rotation = this.rotationTemp;
			
			var pos = { x: shetou.x, y: shetou.y }
			var posBefore = { x: shetou.x, y: shetou.y }
			
			//判断是否快碰撞到边界
			if (!(shetou.x + x >= SnakeConfig.mapW - shetou.radius / 2 || shetou.x + x <= shetou.radius / 2)
				&&!(shetou.y + y >= SnakeConfig.mapH - shetou.radius / 2 || shetou.y + y <= shetou.radius / 2))
			{
				shetou.x += x;
				shetou.y += y;
				
				//名字位置
				this.nnTxt.pos(shetou.x,shetou.y-shetou.radius);
				this.killImg.pos(shetou.x,shetou.y-shetou.radius-25);
				
				pos.x = shetou.x;
				pos.y = shetou.y;
				
				for (var index = 1; index <= this.speed; index++) 
				{
					var arr1:Array = LuanMath.Vspeed(posBefore.x,posBefore.y,pos.x,pos.y,index);
					this.pathArr.unshift({x: arr1[0] + posBefore.x, y: arr1[1] + posBefore.y});
				}
			} 
			else 
			{
				this.moveOut();
			}
		}
		
		private function bodyMove(): void
		{
			for (var index = 1; index < this.bodyArr.length; index++) 
			{
				var element = this.bodyArr[index];
				if (this.pathArr[(index) * this.bodySpace]) 
				{
					var i:int = index * this.bodySpace;
					element.rotation = LuanMath.getV(element.x,element.y, this.pathArr[i].x,this.pathArr[i].y);
					element.pos(this.pathArr[i].x,this.pathArr[i].y);
				}
				if (this.pathArr.length > this.bodyArr.length * (1 + this.bodySpace))
				{
					this.pathArr.pop();
				}
			}
		}
		
		private function speedChange(): void 
		{
			this.speed = this.speedNow == SnakeConfig.slow ?
				(this.speed > this.speedObj[this.speedNow] ? this.speed - 1 : this.speedObj[this.speedNow])
				: (this.speed < this.speedObj[this.speedNow] ? this.speed + 1 : this.speedObj[this.speedNow])
		}
	
		private function rotationChange(): void 
		{
			var zhuan = Math.abs(this.targetR - this.rotationTemp);
			var minR = this.speedObj[SnakeConfig.rotation];
			var perRotation = zhuan < minR ? zhuan : minR;
			if (this.targetR < -0 && this.rotationTemp > 0 && Math.abs(this.targetR) + this.rotationTemp > 180) 
			{
				perRotation = (180 - this.rotationTemp) + (180 + this.targetR) < this.speedObj[SnakeConfig.rotation] ? (180 - this.rotationTemp) + (180 + this.targetR) : this.speedObj[SnakeConfig.rotation];
				this.rotationTemp += perRotation;
			} 
			else 
			{
				this.rotationTemp += this.targetR > this.rotationTemp && zhuan <= 180 ? perRotation : -perRotation;
			}
			this.rotationTemp = Math.abs(this.rotationTemp) > 180 ? (this.rotationTemp > 0 ? this.rotationTemp - 360 : this.rotationTemp + 360) : this.rotationTemp;
		}
		
		private function addShe(i:int,x: Number, y: Number, r: Number): void 
		{
			var isHead:Boolean = false;
			var body: *;
			if(i==0)
			{
				body = shetou;
				isHead = true;
			}
			else
			{
				body = Pool.getItemByClass(SnakeConfig.SNAKEBODY,She);
			}
			
			body.name = SnakeConfig.SNAKE+snakeid;
			body.snake = this;
			
			var zOrder = this.zOrder - this.bodyArr.length - 1
			body.visible = false;
			body.alpha = 0
			body.zOrder = zOrder
			body.skin(isHead,this.bodyArr.length,this.colorNum,this.snakeScale);
			if(this._wudi)
			{
				body.wudi = true;
			}
			else
			{
				body.wudi = false;
			}
			body.pos(x, y);
			body.rotation = r;
			addChild(body);
			body.visible = true;
			body.alpha = 1;
			
//			if(_wudi)
//			{
//				SnakeConfig.addGlowFilter(body,true);
//			}
//			else
//			{
//				SnakeConfig.addGlowFilter(body,false);
//			}
			
			this.bodyArr.push(body);
		}
	
		private function bodyCheck():void
		{
			//超长之后身体不增长
			if (this.tempblood >= this.oneBodyBlood && this._snakeLen < this.bodyMaxNum) 
			{
				var addBodyNum = Math.floor(this.tempblood / this.oneBodyBlood);
				var x = this.bodyArr[this.bodyArr.length - 1].x;
				var y = this.bodyArr[this.bodyArr.length - 1].y;
				var r = this.bodyArr[this.bodyArr.length - 1].rotation;
				
				for (var index = 0; index < addBodyNum; index++) 
				{
					this.addShe(this.bodyArr.length+index,x,y,r);
				}
				if(this._isHero)
				{
					_snakeLen += addBodyNum;
					if(_snakeLen>SnakeConfig.selfMaxLen)
					{
						SnakeConfig.selfMaxLen = _snakeLen;
					}
				}
				this.tempblood = this.tempblood % this.oneBodyBlood;
				
				this.sizeCheck();
			}
		}
		
		private function sizeCheck():void
		{
			if (this.snakeScale < snakeMaxScale) 
			{
				//this.snakeScale += 0.1;
				//默认0.8缩放 0.2*SnakeConfig.bodyMaxNum后变成1 需要100个
				this.snakeScale = this.snakeInitScale + this._snakeLen/SnakeConfig.bodyMaxNum;
				if(snakeScale>snakeMaxScale)
				{
					snakeScale = snakeMaxScale;
				}
				for (var i = 0; i < bodyArr.length; i++) 
				{
					bodyArr[i].scaleSnake(this.snakeScale);
				}
				this.speedObj[SnakeConfig.rotation] = 4 / this.snakeScale;
			}
		}
	
		//蛇的长度计算 减去蛇的默认长度
		public function get snakeLen(): Number
		{
			//return Math.floor(this._snakeBlood / this.oneBodyBlood) - SnakeConfig.snakeInitLen;
			return _snakeLen;
		}
	
		public function reverseRotation(): void 
		{
			this.targetR = this.shetou.rotation > 0 ? this.shetou.rotation - 180 : this.shetou.rotation + 180;
		}
		
		//吃食物
		public function eatFood(num:int):void
		{
			//血量增加
			this._snakeBlood+=num;
			//临时存储血量增加
			this.tempblood+=num;
			this.bodyCheck();
			
			//如果是自己 蛇的总血量
			if(this._isHero)
			{
				SnakeConfig.bloodNum += num;
			}
		}
		
		public function clearAll():void
		{
			Laya.timer.clearAll(this);
			while (this.bodyArr.length!=0) 
			{
				removeChild(this.bodyArr[0]);
				this.bodyArr.splice(0,1);
			}
			bodyArr = [];
		}
	}
}