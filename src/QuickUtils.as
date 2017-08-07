/* ----------------------------------------------------------------------------------------------------------------------------------------------------- /

public class QuickUtils - 类功能 - GAOLEI

/ ----------------------------------------------------------------------------------------------------------------------------------------------------- */

package
{

	import laya.display.Node;
	import laya.display.Sprite;
	import laya.display.Text;
	import laya.events.Event;
	import laya.filters.ColorFilter;
	import laya.filters.GlowFilter;
	import laya.maths.Point;
	import laya.net.LocalStorage;
	import laya.ui.Button;
	import laya.ui.Image;
	import laya.ui.View;
	import laya.utils.Browser;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import laya.utils.Tween;
	
	
	

	public class QuickUtils
	{
		// --- Vars ------------------------------------------------------------------------------------------------------------------------------------------------ //
		
		// --- Public Functions ------------------------------------------------------------------------------------------------------------------------------------ //
		public function QuickUtils()
		{
		}
		
		// --- Protected Functions --------------------------------------------------------------------------------------------------------------------------------- //
		
		// --- Internal&Private Functions -------------------------------------------------------------------------------------------------------------------------- //
		
		// --- Static Vars ----------------------------------------------------------------------------------------------------------------------------------------- //
		
		// --- Static Functions ------------------------------------------------------------------------------------------------------------------------------------ //
		
		
		
		protected static var _DarkGrowFilter:GlowFilter;
		
		/**
		 *取得一个文本白色包边滤镜
		 */		
		public static function get DarkGrowFilter():GlowFilter
		{
			if(_DarkGrowFilter == null)
			{
				_DarkGrowFilter =  new GlowFilter("#000000",2,0,0);
			}
			
			return _DarkGrowFilter;
		}
		
		
		private static var isNativeEnvSetted:Boolean=false;
		private static var isNativeEnv:Boolean=false;
		/**
		 *是否是本地app 
		 * @return 
		 * 
		 */		
		public static function get isNativeMobileApp():Boolean{
			if(isNativeEnvSetted)return isNativeEnv;
			//是否已经探测过了，增加效率
			isNativeEnvSetted=true;
//			var isBrowser:Boolean=Browser.onWeiXin||Browser.onMQQBrowser||Browser.onPC||onSafari;			
			try{
			if(__JS__("conchMarket")){
				isNativeEnv=true;
			}
			}catch(e){
				isNativeEnv=false;
			}
			return isNativeEnv;
		}
		public static var isIOS:Boolean=false;
		public static var isIPad:Boolean=false;
		public static var isIPhone:Boolean=false;
		public static var isAndroid:Boolean=false;
	
		public static function buildQuery(param:Object):String{
			if(param!=null){
				if(param is String){
					
				}else if(param is ArrayBuffer){
					
				}else{
					var query:Array=[];
					for(var k in param){
						
						query.push(k+"="+escape(param[k]));
					}
					param=query.join("&");
				}
			}
			
			return param as String;
		}
		// 打印直接子级
		public static function printXML(xml:*):void
		{
			var rootNode:Object = xml.firstChild;
			
			var nodes:Array = rootNode.childNodes;
			for (var i:int = 0; i < nodes.length; i++)
			{
				var node:Object = nodes[i];
				
				// 本节点为元素节点
				if (node.nodeType == 1)
				{
					trace("节点名称: " + node.nodeName);
					trace("元素节点，第一个子节点值为：" + node.firstChild.nodeValue);
				}
					// 本节点是文本节点
				else if (node.nodeType == 3)
				{
					trace("文本节点：" + node.nodeValue);
				}
				trace("\n");
			}
		}
		/** 放大缩小 ui */
		public static function OpenGui(gui:Sprite,caller:* = null,callback:Function=null,funArgs:* = null,duration:int = 150):void
		{
			if(gui == null)
				return;
			gui.scale(0.9,0.9);
			laya.utils.Tween.to(gui,{scaleX:1.1,scaleY:1.1},duration,null,Handler.create(null,function():void
			{
				laya.utils.Tween.to(gui,{scaleX:1,scaleY:1},duration,null,Handler.create(null,function():void
				{
					if(callback!=null)callback.call(caller,funArgs);
				}));
			}));
		}
		
	
		/**
		 *玩家头像信息添加段位入口 
		 * @param grade
		 * @param parentNode
		 * @param pos
		 * 
		 */		
		public static function addGradeIcon(grade:int, parentNode:Node, pos:Point):void
		{
			if (parentNode == null) return;
			
			if (parentNode.getChildByName("grade") == null)
			{
				var gradeIcon:Image = new Image();
				gradeIcon.skin = "";
				gradeIcon.name = "grade";
				parentNode.addChild(gradeIcon);
				gradeIcon.pos(pos.x, pos.y);
			}
		}
		
		/***********     自动化Scroll -------------***********/
		public static function AddTextScroll(txt:Text){
			txt.overflow = Text.SCROLL;
			txt.on(Event.MOUSE_DOWN, QuickUtils, startScrollText,[txt]);
		}
		private static function startScrollText(txt:Text):void 
		{ 
			//			prevX = Laya.stage.mouseX;
			txt["prevY"] = Laya.stage.mouseY;
			
			Laya.stage.on(Event.MOUSE_MOVE, QuickUtils, scrollText,[txt]);
			Laya.stage.on(Event.MOUSE_UP, QuickUtils, finishScrollText,[txt]);
		}
		/* 停止滚动文本 */
		private static function finishScrollText(txt:Text):void
		{
			Laya.stage.off(Event.MOUSE_MOVE, QuickUtils, scrollText);
			Laya.stage.off(Event.MOUSE_UP, QuickUtils, finishScrollText);
		}
		/* 鼠标滚动文本 */
		private static function scrollText(txt:Text):void
		{
			//			var nowX:Number = Laya.stage.mouseX;
			var nowY:Number = Laya.stage.mouseY;
			
			//			txt.scrollX += prevX - nowX;
			txt.scrollY += txt["prevY"] - nowY;
			
			//			prevX = nowX;
			txt["prevY"] = nowY;
		}
		/***********     自动化Scroll -------------***********/
		
		
		
		public static function decodeNickName(name:String) {
			if (!name) return '';
			var len = name.length, last = name.lastIndexOf('%');
			if (len == (last + 1)) name = name.substring(0, len - 1);
			len = name.length;
			if (decodeCheck(name)) return decodeURI(name);
			
			var nickname = name;
			for(var i = 0; i < len; i++) {
				var n = name.substring(0, len - i);
				if (decodeCheck(n)) return decodeURI(n);
			}
			
			return nickname;
		};
		
		static function decodeCheck(name) {
			try {
				name = decodeURI(name);
				return true;
			} catch (e) {
				return false;
			}
		}
		
		
		/**
		 *获取本地记录的内容 
		 * @param key
		 * @param defaultValue 默认值，会根据默认值int,float,string自动格式化返回值
		 * @return 
		 * 
		 */		
		public static function getLocalVar(key:String,defaultValue:*= null):*{
			var v:String=laya.net.LocalStorage.getItem(key);
			if(v===null){
				if(defaultValue==null)return null;
				v=defaultValue;
				laya.net.LocalStorage.setItem(key,v+"");
				return v;
			}
			
			if(defaultValue!=null)if(Math.floor(defaultValue)==defaultValue){
				return parseInt(v); 
			}else if (parseFloat(defaultValue+"")==defaultValue){
				
				return parseFloat(v);
			}
			return v;
		}
		public static function setLocalVar(key:String,value:*):void{
			//清除
			if(value==null){
				removeLocalVar(key);
				return;
			}
			LocalStorage.setItem(key,value+"");
		}
		public static function removeLocalVar(key:String):void{
			LocalStorage.removeItem(key);
		}
		
		public static function pailie(sourceArr:Array,sszie:int,canChongfu:Boolean = true):Vector.<Array>
		{  
			var result:Vector.<Array> = new Vector.<Array>();  
			
			var combinelist:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();  
			
			var tlength:int = sourceArr.length;  
			var startindex:int = 0;  
			var k:int = 0;  
			while(combinelist.length < sszie)  
			{  
				combinelist.push(new Vector.<int>());  
				for (var i:int = 0; i < tlength ; i++)  
					combinelist[k].push(i);  
				k++;  
			}  
			
			var  pnode:cnode = new cnode();  
			pnode.index = -1;  
			var curlayer:int = 0;  
			var lastnodes:Vector.<cnode> = new Vector.<cnode>();  
			lastnodes.push(pnode);  
			for(var i:int= curlayer; i < combinelist.length;i++)  
			{  
				var layerlist:Vector.<int> = combinelist[i];  
				for (var m:int = 0; m < lastnodes.length; m++)  
				{  
					var templastnode:cnode = lastnodes[m];  
					for (var j:int = 0; j < layerlist.length; j++)  
					{  
						if(layerlist[j] >= templastnode.index)  
						{  
							var tempnode:cnode = new cnode();  
							tempnode.index = layerlist[j];  
							tempnode.layer = i + 1;  
							tempnode.parent = templastnode;  
							templastnode.layerchildren.push(tempnode);  
						}  
						
					}  
				}  
				lastnodes = new Vector.<cnode>();
				pnode.getNodesBylayer(i+1,lastnodes);  
				trace("node length:" + lastnodes.length);
			}  
			lastnodes = new Vector.<cnode>();
			
			pnode.getNodesBylayer(sszie,lastnodes); 
			for each(var temp:cnode in lastnodes)
			{
				var onecom:Array = [];
				temp.printindex(onecom);
				if(canChongfu)
				{
					for(i=0;i < onecom.length;i++)
						onecom[i] = sourceArr[onecom[i]];
					result.push(onecom);
				}
				else
				{
					var haschngfu:Boolean = false;
					onecom.sort(Array.NUMERIC);
					for(i=0;i < onecom.length-1;i++)
					{
						if(onecom[i] == onecom[i+1])
						{
							haschngfu = true;
							break;
						}
					}
					if(haschngfu == false)
					{
						for(i=0;i < onecom.length;i++)
							onecom[i] = sourceArr[onecom[i]];
						result.push(onecom);
					}
				}
				
				//Console.WriteLine("");  
			}  
			
			return result;  
			
		}  
		/**浏览器代理信息*/
		public static const userAgent:String = /*[STATIC SAFE]*/ __JS__("navigator.userAgent");
		/** @private */
		private static const u:String = /*[STATIC SAFE]*/ userAgent;
		/**ios设备*/
		public static const onIOS:Boolean = /*[STATIC SAFE]*/ !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
		/**移动设备*/
		public static const onMobile:Boolean = /*[STATIC SAFE]*/ !!u.match(/AppleWebKit.*Mobile.*/);
		/**iphone设备*/
		public static const onIPhone:Boolean = /*[STATIC SAFE]*/ u.indexOf("iPhone") > -1;
		/**ipad设备*/
		public static const onIPad:Boolean = /*[STATIC SAFE]*/ u.indexOf("iPad") > -1;
		/**andriod设备*/
		public static const onAndriod:Boolean = /*[STATIC SAFE]*/ u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;
		/**Windows Phone设备*/
		public static const onWP:Boolean = /*[STATIC SAFE]*/ u.indexOf("Windows Phone") > -1;
		/**QQ浏览器*/
		public static const onQQBrowser:Boolean = /*[STATIC SAFE]*/ u.indexOf("QQBrowser") > -1;
		/**移动端QQ或QQ浏览器*/
		public static const onMQQBrowser:Boolean = /*[STATIC SAFE]*/ u.indexOf("MQQBrowser") > -1;
		/**微信内*/
		public static const onWeiXin:Boolean = /*[STATIC SAFE]*/ u.indexOf('MicroMessenger') > -1;
		public static const  onSafari:Boolean = /*[STATIC SAFE]*/ u.indexOf('Safari') > -1;
		/**PC端*/
		public static const onPC:Boolean = /*[STATIC SAFE]*/ !onMobile;
		
		/***/
		public static function localToGlobal(sp:Sprite,point:Point,createNewPoint:Boolean=false):Point
		{
			if (!sp || !point) return point;
			if (createNewPoint === true) {
				point = new Point(point.x, point.y);
			}
			var ele:Sprite = sp;
			while (ele) {
				if (ele == Laya.stage) break;
				point.x += (ele.parent as Sprite).x;
				point.y += (ele.parent as Sprite).y;
				ele = ele.parent as Sprite;
			}
			return point;
		}
		
		/***/
		public static function globalToLocal(sp:Sprite,point:Point,createNewPoint:Boolean=false):Point
		{
			if (!sp || !point) return point;
			if (createNewPoint === true) {
				point = new Point(point.x, point.y);
			}
			var ele:Sprite = sp;
			while (ele) {
				if (ele == Laya.stage) break;
				point.x -= (ele.parent as Sprite).x;
				point.y -= (ele.parent as Sprite).y;
				ele = ele.parent as Sprite;
			}
			return point;
		}
		
		//获取url中的参数
		public static function getUrlParam(name:String):String {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
			var r = laya.utils.Browser.window.location.search.substr(1).match(reg);  //匹配目标参数
			if (r != null) return unescape(r[2]); return null; //返回参数值
		}
		
		/** 创建数字纹理 
		 * url:纹理路径
		 * prefix:资源名前缀
		 * interval:单个数字宽度
		 * number:需要显示的数字
		 * symbol:+ - * /
		 * */
		public static function createNumberSprite(url:String,prefix:String,interval:int,number:int,symbol:String = ""):Sprite
		{
			var sprite:Sprite = new Sprite;
			var i:int = 0;
			var img:Image;
			if(symbol != "")
			{
				img = new Image;
				img.skin = url+prefix+symbol+".png";
				sprite.addChild(img);
				i++;
			}
			var tempStr:String = String(number);
			for(var j:int=0;j<tempStr.length;j++)
			{
				var a:String = tempStr[j];
				img = new Image;
				img.skin = url+prefix+a+".png";
				sprite.addChild(img);
				img.x = (i+j)*interval;
			}
			return sprite;
		}
		
	} 
}
class cnode  
{  
	public var index:int;  
	public var layer:int;  
	public var parent:cnode;  
	public var layerchildren:Vector.<cnode>  = new Vector.<cnode>();  
	
	public function  getNodesBylayer(layerIndex:int,arr:Vector.<cnode>):void
	{  
		//var  templist:Vector.<cnode> = new Vector.<cnode>();  
		if (layer == layerIndex)  
			arr.push(this);  
		else if(layer < layerIndex)  
		{  
			for each(var child:cnode in layerchildren) 
			{
				//templist.concat(child.getNodesBylayer(layerIndex));
				child.getNodesBylayer(layerIndex,arr);
			}
		}  
		
		//return templist;  
	}  
	
	public function printindex(arr:Array):void  
	{  
		if (this.parent != null && layer >= 0)  
			this.parent.printindex(arr);  
		if(index >= 0) 
		{
			arr.push(index);
			//trace(index + ",");  
		}
	}  
} 
