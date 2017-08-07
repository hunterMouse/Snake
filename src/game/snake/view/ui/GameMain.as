package game.snake.view.ui
{
	
	import common.tools.TextManager;
	
	import game.snake.model.LuanMath;
	import game.snake.model.SnakeConfig;
	
	import laya.events.Event;
	
	import ui.snake.GameMainUI;

	public class GameMain extends GameMainUI
	{
		private var keySpaceDown: Boolean = false;
		
		public function GameMain()
		{
			this.init()
		}
	
		private function init(): void 
		{
			SnakeConfig.stageW = Laya.stage.width;
			SnakeConfig.stageH = Laya.stage.height;
			SnakeConfig.clear();
			
			this.timeTxt.font = TextManager.timeFont;
			this.text_length.font = TextManager.timeFont;
			
			this.mask_rank.x = SnakeConfig.stageW - this.mask_rank.width - 10;
			this.ctrl_flash.pos(SnakeConfig.stageW - this.ctrl_flash.width, SnakeConfig.stageH - 100);
			this.ctrl_back.pos(this.ctrl_back.width, SnakeConfig.stageH - 100);
			
			
			this.ctrl_flash.on(Event.MOUSE_DOWN, this, this.ctrlFlashDown);
			this.ctrl_flash.on(Event.MOUSE_UP, this, this.ctrlFlashUp);
			this.ctrl_flashup.visible = false;
			//this.ctrl_flashup.on(Event.MOUSE_UP, this, this.ctrlFlashUp);
			
			Laya.stage.on(Event.MOUSE_UP, this, this.ctrlRockerUp);
			Laya.stage.on(Event.MOUSE_DOWN,this, this.ctrlRockerDown);
			Laya.stage.on(Event.MOUSE_MOVE,this, this.ctrlRockerMove);
			Laya.stage.on(Event.KEY_DOWN,this,this.keyDown);
			Laya.stage.on(Event.KEY_UP,this,this.keyUp);
			
			this.ctrl_flash_fast.visible = false;
		}
		
		public function clearAll():void
		{
			this.ctrl_flash.off(Event.MOUSE_DOWN, this, this.ctrlFlashDown);
			this.ctrl_flash.off(Event.MOUSE_UP, this, this.ctrlFlashUp);
			//this.ctrl_flashup.off(Event.MOUSE_UP, this, this.ctrlFlashUp);
			Laya.stage.off(Event.MOUSE_UP, this, this.ctrlRockerUp);
			Laya.stage.off(Event.MOUSE_DOWN,this, this.ctrlRockerDown);
			Laya.stage.off(Event.MOUSE_MOVE,this, this.ctrlRockerMove);
			Laya.stage.off(Event.KEY_DOWN,this,this.keyDown);
			Laya.stage.off(Event.KEY_UP,this,this.keyUp);
		}
		
		private function keyUp(e:Event):void 
		{
			if(e.keyCode == 32){
				this.ctrlFlashUp()
			}
		}
		private function keyDown(e:Event):void 
		{
			if(e.keyCode == 32)
			{
				this.ctrlFlashDown()
			}
		}
		
		private function ctrlFlashDown(): void 
		{
			SnakeConfig.snakeSelf.speedNow = "fast"
			this.ctrl_flash_fast.visible = true;
		}
		
		private function ctrlFlashMove():void
		{
			this.ctrl_flash.pos(Laya.stage.mouseX,Laya.stage.mouseY);
		}
		
		private function ctrlFlashUp(): void 
		{
			SnakeConfig.snakeSelf.speedNow = "slow"
			this.ctrl_flash_fast.visible = false;
		}
		
		private function ctrlRockerUp(e:Event): void 
		{
			e.stopPropagation();
			if (Laya.stage.mouseX <= SnakeConfig.stageW - 300) 
			{
				this.ctrl_rocker.visible = true
				this.ctrl_rocker_move.visible = false
			}
		}
		
		private function ctrlRockerDown(): void 
		{
			if (Laya.stage.mouseX <= SnakeConfig.stageW - 300) 
			{
				this.ctrl_back.pos(Laya.stage.mouseX,Laya.stage.mouseY);
			}
		}
		
		private function ctrlRockerMove(): void 
		{
			if (Laya.stage.mouseX <= SnakeConfig.stageW - 300) 
			{
				this.ctrl_rocker.visible = false;
				this.ctrl_rocker_move.visible = true;
				
				//圆球半径
//				var  r:Number = (this.ctrl_back.width - this.ctrl_rocker.width) / 2;
				var  r:Number = (this.ctrl_back.width) / 2;
				//算出当前ctrl_rocker_move位置。。
				var dist:Number = LuanMath.distance(Laya.stage.mouseX, Laya.stage.mouseY,
					this.ctrl_back.x, this.ctrl_back.y);
				if ( dist <= r) 
				{
					this.ctrl_rocker_move.pos(Laya.stage.mouseX, Laya.stage.mouseY);
				}
				else 
				{
//					 圆的参数方程：
//					　x=r*cosX //x、y是圆上一点的坐标；r是圆半径；
//					　y=r*sinX //X是圆半径绕圆心旋转的角度。
					
					//半径*余弦值 求出的X 半径*正弦值 求出的Y
					var arr:Array = LuanMath.Vspeed(this.ctrl_back.x,this.ctrl_back.y
						,Laya.stage.mouseX,Laya.stage.mouseY,r);
					
					this.ctrl_rocker_move.pos(this.ctrl_back.x + arr[0],this.ctrl_back.y + arr[1]);
				}
				
				//弧度 * 180 / Math.PI;
				//var r:Number = Math.atan2(Laya.stage.mouseY - this.ctrl_back.y, Laya.stage.mouseX - this.ctrl_back.x) * 180 / Math.PI;
				var r:Number = LuanMath.getV(this.ctrl_back.x,this.ctrl_back.y
					,Laya.stage.mouseX,Laya.stage.mouseY);
				SnakeConfig.snakeSelf.targetR = r; 
			}
		}
	}
}