/**Created by the LayaAirIDE,do not modify.*/
package ui.snake {
	import laya.ui.*;
	import laya.display.*; 

	public class FoodUI extends View {
		public var img:Image;

		public static var uiView:Object ={"type":"View","props":{},"child":[{"type":"Image","props":{"var":"img","skin":"snake/food1_1.png","anchorY":0.5,"anchorX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}