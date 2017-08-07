package game.snake.view.ui
{
	import game.snake.model.SnakeConfig;
	
	import laya.utils.Handler;
	import laya.utils.Pool;
	
	import ui.snake.SheUI;

	public class She extends SheUI
	{
		public var snake:Snake;
		
		public var type:String = "snake";
		
		private var _colorNum:Number = -1;
		
		public var isHead:Boolean = false;
		
		private var initWidth:Number = 0;
		
		private var _radius:Number = 0;
		
		private var _wudi:Boolean = false;
		
		public function She()
		{
			//img在编辑器中 已经加入了赋值了
			initWidth = this.img.width;
		}
		
		//设置实物的图片

		public function get wudi():Boolean
		{
			return _wudi;
		}

		public function set wudi(value:Boolean):void
		{
			_wudi = value;
			
			this.wudiImg.visible = _wudi;
		}

		public function get colorNum():Number
		{
			return _colorNum;
		}

		/**
		 * 
		 * @param _isHead 是否是头
		 * @param index   身体的第几节
		 * @param i		  身体皮肤类型	
		 * @param scale   身体缩放
		 * @param handler 回调
		 * 
		 */		
		public function skin(_isHead:Boolean,index:int,skinType:int = -1,scale:Number = 1,handler:Handler=null):void
		{
			isHead = _isHead;
			if(skinType==-1)
			{
				skinType = SnakeConfig.snakeColor();
			}
			_colorNum = skinType;
			if(isHead)
			{
				this.img.skin = "snake/head"+skinType+".png";
			}
			else
			{
				this.img.skin = "snake/body"+skinType+"_"+((index+1)%2)+".png";
			}
			scaleSnake(scale);
		}
		
		public function scaleSnake(scale:Number = 1):void
		{
			_radius = this.initWidth * scale;
			this.scale(scale,scale);
//			this.img.scale(scale,scale);
//			this.wudiImg.scale(scale,scale);
//			if(isHead)
//			{
//				this.jiasu.scale(scale,scale);
//			}
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
			Pool.recover(SnakeConfig.SNAKE, this);
		}
	}
}