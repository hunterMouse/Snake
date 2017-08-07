package game.snake.view.ui
{
	import laya.events.Event;
	import laya.utils.Tween;
	
	
	import ui.snake.GameOverUI;

	public class GameOver extends GameOverUI
	{
		public function GameOver()
		{
			this.liquantxt.visible = false;
			this.btn_fenxiang.on(Event.CLICK,this,onFengXiangClick);
		}
		
		private function onFengXiangClick():void
		{
			
		}
		
		public function setResult(snakeLen:int,beisha:int,sha:int):void
		{
			var str:String = "最长长度： {0}m\n被杀次数： {1}次\n杀蛇次数： {2}次"
			this.jieguoTxt.text ="";// StringUtils.format(str,snakeLen,beisha,sha);
		}
		
		
		public function setLiQuan(liquan:int):void
		{
			this.liquantxt.visible = true;
			this.liquantxt.alpha = 0;
			this.liquantxt.text = "恭喜您获得"+liquan+"礼券";
			Tween.to(this.liquantxt,{alpha:1},500);
		}
		
		public function clear():void
		{
			Tween.clearAll(this.liquantxt);
		}
		
	}
}