/**Created by the LayaAirIDE,do not modify.*/
package ui.snake {
	import laya.ui.*;
	import laya.display.*; 

	public class GameOverUI extends View {
		public var btn_replay:Button;
		public var btn_out:Button;
		public var btn_fenxiang:Button;
		public var jieguoTxt:Label;
		public var liquantxt:Label;

		public static var uiView:Object ={"type":"View","props":{"stateNum":"1"},"child":[{"type":"Image","props":{"width":1136,"skin":"snake/mask.png","height":640}},{"type":"Box","props":{"y":320,"x":568,"anchorY":0.5,"anchorX":0.5},"child":[{"type":"Image","props":{"y":0,"x":0,"width":644,"skin":"snake/休闲游戏BG.png","sizeGrid":"50,43,55,44","height":500}},{"type":"Image","props":{"y":91,"x":8,"width":628,"skin":"snake/休闲游戏BG2.png","height":266}},{"type":"Image","props":{"y":-48.99999999999999,"x":29.99999999999985,"skin":"snake/贪吃蛇图像.png"}},{"type":"Image","props":{"y":-82,"x":141.99999999999994,"skin":"snake/游戏结束title.png"}},{"type":"Button","props":{"y":373.99999999999994,"x":192.99999999999974,"var":"btn_replay","stateNum":"1","skin":"snake/btnbg.png"},"child":[{"type":"Image","props":{"y":25,"x":12,"skin":"snake/btn-restart.png"}},{"type":"Image","props":{"y":19,"x":159,"skin":"snake/房卡.png"}},{"type":"Image","props":{"y":26,"x":202,"skin":"snake/x1.png"}}]},{"type":"Button","props":{"y":385.99999999999994,"x":67.99999999999994,"var":"btn_out","stateNum":"1","skin":"snake/btn-back.png"}},{"type":"Button","props":{"y":385.99999999999994,"x":493.99999999999994,"var":"btn_fenxiang","stateNum":"1","skin":"snake/分享.png"}},{"type":"Label","props":{"y":122,"x":161,"width":396,"var":"jieguoTxt","valign":"middle","text":"最终长度：100\\n被杀次数：100\\n杀蛇次数：100","leading":10,"height":168,"fontSize":35,"color":"#f9f1f1"}},{"type":"Button","props":{"y":15.000000000000018,"x":554.9999999999998,"visible":false,"stateNum":"1","skin":"snake/btn_关闭.png"}},{"type":"Label","props":{"y":290,"x":90,"width":424,"var":"liquantxt","valign":"middle","text":"获得礼券5000","height":50,"fontSize":35,"color":"#ffffff","align":"center"}}]}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}