package game.snake.view.ui
{
	import game.snake.model.SnakeConfig;
	
	import laya.display.Sprite;
	import laya.maths.Point;

	public class SnakeAI extends Sprite
	{
		//正常模式 漫游
		private const NORMAL:String = "NORMAL";
		//生成目标点
		private const SEEK_0:String = "SEEK_0";
		//移动到目标点
		private const SEEK_1:String = "SEEK_1";
		//躲避模式
		private const EVADE:String = "EVADE";
		
		
		//目标角度
		public var targetR: Number = 0;
		//蛇头
		public var shetou:She;
		
		//ai模式
		private var AIMode:String = NORMAL;
		//目标食物
		private var mbFood:Food = null;
		//目标食物坐标
		private var foodPoint:Point = new Point();
		
		public function SnakeAI(isHero:Boolean=false,isAI:Boolean = false)
		{
			
		}
		
		public function AIMove():void
		{
			switch(AIMode)
			{
				case NORMAL:
					break;
				case SEEK_0:
					//方向移动判断 //在地图随机一个食物目标
					var max:Number = SnakeConfig.foodArr.length;
					if (max > 0)
					{
						var rd:Number = Math.floor(Math.random() * max);
						mbFood = SnakeConfig.foodArr[rd];	
						foodPoint.x = mbFood.x;
						foodPoint.y = mbFood.y;
						AIMode = SEEK_1;
					}
					break;
				
				case SEEK_1:
					if(mbFood)
					{
						//弧度 * 180 / Math.PI;
						var r:Number = Math.atan2(this.shetou.y - foodPoint.y, this.shetou.x - foodPoint.x) * 180 / Math.PI;
						this.targetR = r;
						//如果吃到目标食物：切换为1
						if (foodPoint.x != mbFood.x || foodPoint.y != mbFood.y)
						{
							AIMode = SEEK_0;
						}
					}
					else
					{
						AIMode = SEEK_0;
					}
					break;
				
				case EVADE:
					//躲避障碍AI：暂无
					break;
			}
		}
		
	}
}