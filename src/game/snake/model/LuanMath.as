package game.snake.model 
{
	public class LuanMath 
	{
//		弧度角度换算公式：
//		弧度转为角度：
//		degree = radians * 180 / Math.PI
//		角度转为弧度：
//		radians = degree * Math.PI / 180
		//计算距离
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number): Number 
		{
			return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
		}
		
		private static function _V(myx:Number,myy:Number,mdx:Number,mdy:Number):Number
		{
			//圆半径绕圆心旋转的//弧度 。
			return Math.atan2(mdy - myy,mdx - myx);
		}
		
		/**
		 * 
		 * @param myx  当前
		 * @param myy
		 * @param mdx  目标
		 * @param mdy
		 * @return 
		 * 
		 */		
		public static function getV(myx:Number,myy:Number,mdx:Number,mdy:Number):Number 
		{
			//圆半径绕圆心旋转的角度。 //弧度 * 180 / Math.PI;
			return _V(myx,myy,mdx,mdy) * 180 / Math.PI;
		}
		
		public static function Vspeed(myx:Number,myy:Number,mdx:Number,mdy:Number,speed:Number = 1):Array 
		{
			var arr:Array = [];
			//X是圆半径绕圆心旋转的//弧度 。
			var X:Number = _V(myx,myy,mdx,mdy);
			arr[0] = Math.cos(X)*speed;
			arr[1] = Math.sin(X)*speed;
			return arr;
		}
		public static function VspeedObj(a:Object,b:Object,speed:Number = 0):Array 
		{
			return Vspeed(a.x,a.y,b.x,b.y,speed);
		}
		//通过角度(180-180)获得x和y的速度
		public static function getVbackSpeed(v:Number,speed:Number = 1):Array 
		{
			var arr:Array = new Array();
			var hu:Number = v*Math.PI/180;
			arr[0] = Math.cos(hu)*speed;
			arr[1] = Math.sin(hu)*speed;
			return arr;
		}
	}
}