/**Created by the LayaAirIDE,do not modify.*/
package ui.snake {
	import laya.ui.*;
	import laya.display.*; 

	public class SheUI extends View {
		public var jiasu:Image;
		public var img:Image;
		public var wudiImg:Image;

		public static var uiView:Object ={"type":"View","props":{},"child":[{"type":"Image","props":{"y":0,"x":-38,"visible":false,"var":"jiasu","skin":"snake/加速.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":0,"x":0,"var":"img","skin":"snake/head1.png","anchorY":0.5,"anchorX":0.5}},{"type":"Image","props":{"y":0,"x":0,"visible":false,"var":"wudiImg","skin":"snake/无敌.png","anchorY":0.5,"anchorX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}