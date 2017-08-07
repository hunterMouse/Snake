/**Created by the LayaAirIDE,do not modify.*/
package ui.snake {
	import laya.ui.*;
	import laya.display.*; 

	public class GameMainUI extends View {
		public var text_length:Label;
		public var text_kill:Label;
		public var liquanBox:Box;
		public var liquan:Image;
		public var mask_rank:Image;
		public var ctrl_flashup:Image;
		public var ctrl_back:Image;
		public var ctrl_rocker:Image;
		public var ctrl_rocker_move:Image;
		public var btn_out:Button;
		public var ctrl_flash:Button;
		public var ctrl_flash_fast:Image;
		public var timeBox:Box;
		public var timeTxt:Label;

		public static var uiView:Object ={"type":"View","props":{"width":1136,"height":640},"child":[{"type":"Label","props":{"y":32,"x":800,"width":86,"var":"text_length","text":"0","height":20,"fontSize":20}},{"type":"Label","props":{"y":30,"x":20,"width":91,"visible":false,"var":"text_kill","text":"0","height":20,"fontSize":20}},{"type":"Box","props":{"y":124,"x":841,"var":"liquanBox"},"child":[{"type":"Image","props":{"y":0,"x":0,"width":59,"var":"liquan","skin":"snake/li.png","pivotY":38.18181818181818,"pivotX":61.81818181818181,"height":73}}]},{"type":"Image","props":{"y":10,"x":989,"width":102,"visible":false,"var":"mask_rank","skin":"snake/mask.png","sizeGrid":"3,3,3,3","height":133}},{"type":"Image","props":{"y":0,"x":0,"width":1136,"var":"ctrl_flashup","skin":"snake/mask.png","height":640,"alpha":0.01}},{"type":"Image","props":{"y":447,"x":132,"var":"ctrl_back","skin":"snake/control-back.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":74,"x":74,"var":"ctrl_rocker","skin":"snake/control-rocker.png","anchorY":0.5,"anchorX":0.5}}]},{"type":"Image","props":{"y":555,"x":68,"visible":false,"var":"ctrl_rocker_move","skin":"snake/control-rocker.png","anchorY":0.5,"anchorX":0.5}},{"type":"Button","props":{"y":30,"x":69,"var":"btn_out","stateNum":"1","skin":"snake/退出.png"}},{"type":"Button","props":{"y":552.9999999999999,"x":1020,"var":"ctrl_flash","stateNum":"1","skin":"snake/加速按钮.png","anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":0,"x":0,"var":"ctrl_flash_fast","skin":"snake/加速按钮-按下.png"}}]},{"type":"Box","props":{"y":41,"x":512,"var":"timeBox","anchorY":0,"anchorX":0.5},"child":[{"type":"Image","props":{"y":0,"x":0,"skin":"snake/时间.png"}},{"type":"Label","props":{"y":0,"x":100,"width":122,"var":"timeTxt","valign":"middle","text":"label","height":30,"fontSize":20,"anchorY":0,"anchorX":0.5,"align":"left"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}