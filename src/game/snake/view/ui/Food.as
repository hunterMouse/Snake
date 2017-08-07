package game.snake.view.ui
{
	import game.snake.model.SnakeConfig;
	
	import laya.maths.Point;
	import laya.utils.Handler;
	import laya.utils.Pool;
	
	import ui.snake.FoodUI;

	public class Food extends FoodUI
	{
		//食物吸附时候的速度
		public var speed: Number = SnakeConfig.foodSpeed;
		//食物类型
		private var _colorNum:Number = -1;
		//食物默认宽度
		private var initWidth:Number = 0;
		//食物的直径
		private var _radius:Number = 0;
		//缓存池用的
		public var type:String = SnakeConfig.FOOD;
		//食物id
		private var _foodid:int = 0;
		
		//吃掉食物 +血 根据类型加不同 加的血不同
		private var _addBlood:int = 1;
		
		//2种食物 一种血量加1一种血量加2 每个7种食物
		
		public function Food()
		{
			_foodid = SnakeConfig.foodid;
			
			//img在编辑器中 已经加入了赋值了
			initWidth = this.img.width;
		}
		
		public function get addBlood():int
		{
			return _addBlood;
		}

		public function get foodid():int
		{
			return _foodid;
		}

		public function get colorNum():Number
		{
			return _colorNum;
		}

		public function skin(foodLv:String=SnakeConfig.food_small,i:int=-1,scale:Number = 1,handler:Handler=null):void
		{
			_addBlood = SnakeConfig.foodLvObj[foodLv];
			if(i==-1)
			{
				i = SnakeConfig.foodColor();
			}
			_colorNum = i;
			this.img.skin = "snake/food"+foodLv+"_"+i+".png";
			this.zOrder = 0;
			
			scale = SnakeConfig.foodScale();
			
			scaleFood(scale);
		}
		
		public function setPos(_x:Number=-1,_y:Number=-1):void
		{
			if(_x==-1 && _y==-1)
			{
				var p:Point = SnakeConfig.randomFoodPos();
				_x = p.x;
				_y = p.y;
			}
			this.pos(_x,_y);
		}
			
		
		public function scaleFood(scale:Number = 1):void
		{
			_radius = this.initWidth * scale;
			this.img.scale(scale,scale);
//			_radius = this.img.width * scale;
//			this.img.size(_radius,_radius);
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function remove():void
		{
			this.removeSelf();
			//回收到对象池
			Pool.recover(SnakeConfig.FOOD, this);
		}
	}
}