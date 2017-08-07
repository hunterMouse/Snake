package common.tools
{
	import laya.display.BitmapFont;
	import laya.display.Text;
	import laya.utils.Handler;

	public class TextManager
	{
		
		private static var _instance:TextManager;
		
		public static function get instance():TextManager
		{
			if(!_instance)
			{
				_instance = new TextManager(new singleForce());
			}
			
			return _instance;
		}
		
		public function TextManager(force:singleForce)
		{
			init();
			
		}
		
		
		
		/**蓝色的战绩数字*/
		public static var BlueNumberFont:String = "BlueNumber";
		/**红色的战绩数字*/
		public static var YellowNumberFont:String = "YellowNumber";
		/**白色的战绩数字*/
		public static var WhiteNumberFont:String = "WhiteNumber";
		/**小结算*/
		public static var ScoreAddFont:String = "ScoreAddNumber";
		public static var ScoreReduceFont:String = "ScoreReduceNumber";
		
		public static var timeFont:String = "timeFont";
		
		
		protected var fontArray:Array = [];
		protected var fontLoadedNum:int = 0;
		protected var completeFun:Function;
		
		protected var haveLoad:Boolean = false;
		
		protected function init():void
		{
			fontArray.push(BlueNumberFont,YellowNumberFont,WhiteNumberFont,ScoreAddFont, ScoreReduceFont
				,timeFont);
		}
		
		public function loadFont(onComplete:Function):void
		{
			if(haveLoad)
			{
				return;
			}
//			var bitmapFontB:BitmapFont = new BitmapFont();
//			bitmapFontB.loadFont("res/bitmapFont/BlueNumber.fnt",new Handler(this,onFontLoaded, [bitmapFontB,"BlueNumber"]));
//			var bitmapFontR:BitmapFont = new BitmapFont();
//			bitmapFontR.loadFont("res/bitmapFont/RedNumber.fnt",new Handler(this,onFontLoaded, [bitmapFontR,"RedNumber"]));
//			var bitmapFontW:BitmapFont = new BitmapFont();
//			bitmapFontW.loadFont("res/bitmapFont/WhiteNumber.fnt",new Handler(this,onFontLoaded, [bitmapFontW,"WhiteNumber"]));
			
			completeFun = onComplete;
			
			var bitmapFont:BitmapFont = new BitmapFont();
			var i:int;
			var len:int = fontArray.length;
			for(i=0;i<len;i++)
			{
				bitmapFont = new BitmapFont();
				bitmapFont.loadFont("res/bitmapFont/" + fontArray[i] +".fnt",new Handler(this,onFontLoaded, [bitmapFont,fontArray[i]]));
			}	
			
			haveLoad = true;
		}
		
		private function onFontLoaded(bitmapFont:BitmapFont,fontName:String):void
		{
			bitmapFont.setSpaceWidth(10);
			
			Text.registerBitmapFont(fontName, bitmapFont);
			
			fontLoadedNum ++ ;
			if(fontLoadedNum == fontArray.length)
			{
				if(completeFun)
				{
					completeFun();
				}
			}
			
		}
	}
}

class singleForce{}