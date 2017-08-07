package game.snake.context
{
	import common.tools.SoundPlay;
	
	import game.snake.view.SnakeView;
	
	import laya.media.SoundManager;
	
	import rb.framework.mvc.GameContext;
	import rb.framework.mvc.Module;
	
	public class SnakeContext extends GameContext
	{
		protected var _ddzView:SnakeView;

		public function SnakeContext(key:String="", module:Module=null, parentNode:GameContext=null)
		{
			super(key, module, parentNode);
		}
		
		override public function open():void
		{
			super.open();
			
			initUI();
			trace("addView(_ddzView)////////////////");
			this.addView(_ddzView);
			SoundPlay.swithMusic("game");
			QuickTween.main_ui_reset();
		}
		
		protected function initUI():void
		{
			if(_ddzView == null)
			{
				_ddzView = new SnakeView();
			}
		}
		
		override public function close():void
		{
			super.close();
			SoundManager.stopMusic();
		}
		
	}
}