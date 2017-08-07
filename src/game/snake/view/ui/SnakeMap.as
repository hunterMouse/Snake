package game.snake.view.ui
{
	import game.snake.model.SnakeConfig;
	
	import laya.display.Sprite;

	public class SnakeMap extends Sprite
	{
		//画背景的格子大小
		private var _gridSize:Number = 50;

		public var bgColor:String = "#d3e9f4";
		public var gridColor:String = "#c2d8e3";
	
		//镜头跟随的蛇
		public var cameraFollow:Snake = null;
		
		public function SnakeMap()
		{
			this.zOrder = -1;
			
			_width = SnakeConfig.mapW;
			_height = SnakeConfig.mapH;
			
			drawGrid();
		}
		
		//画格子
		public function drawGrid():void 
		{
			graphics.drawRect(0,0,_width,_height,bgColor);
			for (var i:int = 0; i <= _width; i += _gridSize) 
			{
				graphics.drawLine(i,0,i, _height,gridColor);
			}
			for (i = 0; i <= _height; i += _gridSize) 
			{
				graphics.drawLine(0,i,_width, i,gridColor);
			}
		}
	
		//设置镜头跟随的蛇 主角玩家。。
		public function setFollow(sk:Snake):void
		{
			this.cameraFollow = sk;
		}
		
		public function update():void
		{
			//做地图相对移动，以便能让玩家的蛇始终居中//镜头跟随
			if (this.cameraFollow != null)
			{
				var mapScale:Number = 1;//this.cameraFollow.snakeInitScale / this.cameraFollow.snakeScale;
				//mapScale = mapScale < 0.7 ? 0.7 : mapScale;
				//跟随的蛇对象不为Null,就开始让镜头跟随蛇头移动
				this.x = -this.cameraFollow.shetou.x * mapScale + SnakeConfig.stageW / 2;
				this.y = -this.cameraFollow.shetou.y * mapScale + SnakeConfig.stageH / 2;
			}
		}
		
	}
}