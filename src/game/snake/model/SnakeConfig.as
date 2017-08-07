package game.snake.model
{
	import game.snake.view.ui.Snake;
	
	import laya.filters.ColorFilter;
	import laya.filters.GlowFilter;
	import laya.maths.Point;

	/**
	 * ...
	 * @author luan
	 */
	public class SnakeConfig 
	{
		//地图大小
		public static const mapW:Number = 3000;
		public static const mapH:Number = 2000;
		
		//游戏时间 300秒
		public static const gameMaxTime:int = 5*60;
		
		//速度快慢
		public static const slow:String = "slow";
		public static const fast:String = "fast";
		//旋转角度
		public static const rotation:String = "rotation";
		//蛇的速度
		public static const speedObj:Object = {"slow": 4, "fast": 6, "rotation": 10};
		//食物等级
		public static const food_small:String = "1";
		public static const food_big:String = "2";
		//小食物血量1 大食物血量2 key食物等级 value吃掉后加的血量
		public static const foodLvObj:Object = {"1": 1, "2": 2};
		//食物吸附移动速度 速度比蛇速度快点。。
		public static const foodSpeed:int = 7;
		
		//初始大小
		public static const snakeInitScale:Number = 0.8;
		//蛇最大缩放
		public static const snakeMaxScale:Number = 1.2;
		//初始蛇的长度
		public static const snakeInitLen:int = 5;
		//身体间距
		public static const bodySpace:int = 30;
		
		//成长速度：多少血 加一节身体 5血加1身体
		public static const oneBodyBlood: Number = 5;
		
		//蛇的最大身体长度
		public static const bodyMaxNum: Number = 500;
		//机器蛇
		public static const SnakeAINum:int = 10;
		//食物初始数量
		public static const foodInitNum:int = 200;
		//食物最大数量
		public static const foodMaxNum:int = 200;
		//所有蛇 3秒无敌
		public static const wudiTime:int = 3000;
		//缓存分类
		public static const SNAKE:String = "SNAKE";
		public static const FOOD:String = "FOOD";
		public static const SNAKEBODY:String = "SNAKEBODY";

		
		//需要初始化的参数
		//画面大小
		public static var stageW:Number = 1136;
		public static var stageH:Number = 640;
		//所有食物
		public static var foodArr:Array = [];
		//自己的蛇
		public static var snakeSelf:Snake;
		//自己是否死掉
		public static var selfDie:Boolean = false;
		//蛇id
		public static var snakeid:Number = -1;
		//食物id
		public static var foodid:Number = -1;
		//蛇的总血量 目前没啥用
		public static var bloodNum:int = 0;
		//蛇的历史最长
		public static var selfMaxLen:int = 0;
		//杀蛇的数量
		public static var killNum:int = 0;
		//死亡次数
		public static var dieNum:int = 0;
		
		
		public static function clear():void
		{
			foodArr = [];
			snakeSelf = null;
			selfDie = false;
			snakeid = -1;
			foodid = -1;
			bloodNum = 0;
			selfMaxLen = 0;
			killNum = 0;
			dieNum = 0;
		}
		
		//获取随机
		public static function getRandom(min:int=0, max:int=100):int
		{
			var result:int = Math.floor(Math.random() * (max - min + 1) + min);
			return result;
		}
		
		//蛇的颜色
		public static function snakeColor():int
		{
			var result:int = getRandom(1,6);
			return result;
		}
		
		//食物的颜色
		public static function foodColor():int
		{
			var result:int = getRandom(1,7);
			return result;
		}
		
		
		public static function foodScale():Number
		{
			var result:int = getRandom(5,10);
			return result/10;
		}
		
		public static function randomFoodPos():Point
		{
			var x:Number = Math.random() * SnakeConfig.mapW;
			var y:Number = Math.random() * SnakeConfig.mapH;
			return new Point(x,y);
		}
		
		public static function randomSnakeLen():int
		{
			var result:int = getRandom(4,25);
			return result;
		}
		
		public static function addGlowFilter(target:*, isDark:Boolean = true):void 
		{
			if (isDark) 
			{
				target.filters=[new GlowFilter("#ff0000",2,0,0)];
			}
			else 
			{
				target.filters=[];
			}
		}
		
		public function SnakeConfig() 
		{
			
		}
		
	}

}