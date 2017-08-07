package game.snake.view
{
	import game.snake.view.ui.GameScene;
	
	import rb.framework.mvc.AbstractLayer;
	import rb.framework.mvc.Message;
	import rb.framework.mvc.core.LayerTypes;
	
	import utils.MsgNames;

	public class SnakeView extends AbstractLayer
	{
		private var gameScene:GameScene;
		public function SnakeView()
		{
			super();
			super.setType(LayerTypes.VIEW);
		}
		
		override public function onAdd():void
		{
			onAddUI();
			onAddListener();
		}
		
		override public function onRemove():void
		{
			onRemoveUI();
			onRemoveListener();
		}
		
		protected function onAddUI():void
		{
			if(gameScene==null)
			{
				gameScene = new GameScene();
			}
			Main.ui.addChild(gameScene);
		}
		protected function onRemoveUI():void
		{
			if(gameScene!=null)
			{
				gameScene.clearAll();
				gameScene.removeSelf();
				gameScene = null;
			}
		}
		
		protected function onAddListener():void
		{
			this.addHandler(MsgNames.TICKET_CARD_CHANGE,onticketCardChange);
			this.addHandler(MsgNames.GET_ALLEXP_CHANGE,ongetExpChange);
		}
		
		protected function onRemoveListener():void
		{
		}
		
		
		private function onticketCardChange(msg:Message):void
		{
			if (msg) msg.complete();
			
		}
		private function ongetExpChange(msg:Message):void
		{
			if(msg)msg.complete();
		}
		
	}
}