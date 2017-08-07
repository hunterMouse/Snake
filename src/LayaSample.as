package {
	import game.snake.view.ui.GameScene;
	
	import laya.display.Stage;
	import laya.net.Loader;
	import laya.utils.Handler;
	import laya.webgl.WebGL;

	public class LayaSample {
		
		public function LayaSample() {
			//初始化引擎
			Laya.init(1136, 640,WebGL);
			//30帧率运行
			Laya.stage.frameRate=laya.display.Stage.FRAME_SLOW;
			//设置适配模式
			Laya.stage.scaleMode = "showall";
			//设置横竖屏
			Laya.stage.screenMode = Stage.SCREEN_HORIZONTAL;
			//设置水平对齐
			Laya.stage.alignH = "center";
			//设置垂直对齐
			Laya.stage.alignV = "middle";
			
			
			Laya.loader.load(
				[
					
					{url: "res/atlas/comp.json", type: Loader.ATLAS},					
					{url: "res/atlas/snake.json", type: Loader.ATLAS}
					
				],
				Handler.create(this, onLoaded));
			
		
			
		}	
		
		private function onLoaded():void { 
			var game:GameScene = new GameScene();
			Laya.stage.addChild(game );
			
		}
	}
}