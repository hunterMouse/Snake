package game.snake.model 
{
	import laya.display.Graphics;
	import laya.display.Sprite;
	import laya.events.EventDispatcher;

	public class CollisionGrid extends EventDispatcher 
	{
		private var _grid:Array;//网格(注：这里用“一维数组套一维数组”的方法替代了原来的二维数组)
		private var _gridSize:Number;
		private var _height:Number;
		private var _width:Number;
		private var _numCells:int;
		private var _numCols:int;
		private var _numRows:int;
		
		public function CollisionGrid(width:Number, height:Number, gridSize:Number) {
			_width=width;
			_height=height;
			_gridSize=gridSize;
			
			_numCols=Math.ceil(_width/_gridSize);//计算总列数            
			_numRows=Math.ceil(_height/_gridSize);//计算总行数 向上取
			_numCells=_numCols*_numRows;//单元格总数
		}
		
		//画格子
		public function drawGrid(graphics:Graphics):void 
		{
			graphics.drawRect(0,0,_width,_height,"#CCCCCC");
			for (var i:int = 0; i <= _width; i += _gridSize) {
				graphics.drawLine(i,0,i, _height,"#999999");
			}
			for (i = 0; i <= _height; i += _gridSize) {
				graphics.drawLine(0,i,_width, i,"#999999");
			}
		}
		
		public function getIndex(obj:Object):int
		{
			//向下取
			var index:int = Math.floor(obj.y/_gridSize)*_numCols+Math.floor(obj.x/_gridSize);
			return index;
		}
		
		//"单元格"检测
		private function checkGrid(index:int):Array 
		{
			var x:int = (index%_numCols);
			var y:int = Math.floor(index/_numCols);
			var cell:Array = [];
			//本格子
			if(_grid[index])
			{
				cell = _grid[index];
			}
			
			//左上 
			index = (y-1)*_numCols+(x-1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//上
			index = (y-1)*_numCols+x;
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//右上
			index = (y-1)*_numCols+(x+1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//左
			index = y*_numCols+(x-1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//右
			index = y*_numCols+(x+1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//左下
			index = (y+1)*_numCols+(x-1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//下
			index = (y+1)*_numCols+x;
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			//右下
			index = (y+1)*_numCols+(x+1);
			if(_grid[index])
			{
				cell = cell.concat(_grid[index]);
			}
			
			return cell;
		}
		public function checkHeroGrid(hero:Object):Array 
		{
			var checks:Array = [];
			var index:int = getIndex(hero);
			var cell:Array = checkGrid(index);
			if (cell==null) 
			{
				return checks;
			}
			var cellLength:int = cell.length;
			for (var i:int = 0; i < cellLength; i++) 
			{
				var objA:Sprite=cell[i];
				checks.push(hero,objA);
			}
			return checks;
		}
		
		//将需要检测的对象(泛型)数组objects分配到网络
		public function assign(objects:Array):void 
		{
			var numObjects:int=objects.length;
			_grid = [];//new Vector.<Array>(_numCells);
			for (var i:int = 0; i < numObjects; i++) 
			{
				var obj:Sprite=objects[i];
				//注意：这里用“Grid.[索引]”（定位）的方式，替换了原来的“Grid.[列][行]”（单元格的定位）方式
				var index:int=Math.floor(obj.y/_gridSize)*_numCols+Math.floor(obj.x/_gridSize);//向下取
				//“单元格”--延时实例化"
				if (_grid[index]==null) 
				{
					_grid[index] = [];
				}
				//将对象推入"单元格"
				_grid[index].push(obj);
			}
		}
	}
}