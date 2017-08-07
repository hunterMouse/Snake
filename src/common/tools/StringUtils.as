package common.tools{
	public class StringUtils {
		
		public function StringUtils(){
			
			
		}
		
		private static function getRegExp(fullmatch:Boolean, pattern:String):RegExp{
			
			
			
			
			
			if (fullmatch){
				
				return (new RegExp((("^" + pattern) + "$")));
			};
			
			return (new RegExp(pattern));
		}
		
		public static function getChineseNameRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "[一-龥]+"));
		}
		
		public static function getClassNameRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "(?P<name>[A-Z][a-zA-Z0-9_]*)"));
		}
		
		public static function getEmailRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "(?P<name>[a-zA-Z0-9\\-\\_]+([_\\.][a-zA-Z0-9\\-\\_]+)*)@(?P<domain>[a-zA-Z0-9\\-]+(\\.[a-zA-Z0-9\\-]+)+)"));
		}
		
		public static function getEnglishNameRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "[a-zA-Z][a-zA-Z\\s\\.]+[a-zA-Z]"));
		}
		
		public static function getIDCardRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "((?P<prefix>\\d{6})(?P<year>(\\d{4})|(\\d{2}))(?P<month>\\d{2})(?P<day>\\d{2})(?P<postfix>(\\d{3})|((\\d{4})|(\\d{3}[a-zA-Z]))))"));
		}
		
		public static function getMobileRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "1[1-9][0-9]{1}[0-9]{8}"));
		}
		
		public static function getPackageNameRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "[a-z][a-z0-9]*"));
		}
		
		public static function getPhoneRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "((?P<area>0[0-9]{2,3})\\-)?(?P<main>([2-9][0-9]{6,7})+)(\\-(?P<sub>[0-9]{1,4}))?"));
		}
		
		public static function getUrlRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "(?P<protocol>(http|https))://(?P<domain>[a-zA-Z0-9\\-_]+(\\.[a-zA-Z0-9\\-_]+)*)(:(?P<port>\\d*))*(?P<path>(/[a-zA-Z0-9\\-_]*)*([a-zA-Z0-9\\-_]+\\.[a-zA-Z0-9]+)*)((?P<query>[\\?#]+[\\?\\S]*))*"));
		}
		
		public static function getUserIdRegExp(fullmatch:Boolean=true):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "[a-zA-Z0-9_]{3,30}"));
		}
		
		public static function getVariableNameRegExp(fullmatch:Boolean):RegExp{
			
			
			
			
			return (getRegExp(fullmatch, "([A-Z][a-z0-9_]*)+"));
		}
		
		public static function ltrim(source:String):String{
			
			
			
			
			
			var result:String = source.replace(/^\s+/g, "");
			
			return (result);
		}
		
		public static function rtrim(source:String):String{
			
			
			
			
			
			var result:String = source.replace(/\s+$/g, "");
			
			return (result);
		}
		
		public static function trim(source:String):String{
			
			
			
			
			return (ltrim(rtrim(source)));
		}
		
		public static function format(formatText:String, ... _args):String{
			
			
			
			
			
			return (formatEx(formatText, _args));
		}
		
		public static function formatEx(formatText:String, args:Array):String{
			
			
			
			
			
			
			
			var result:String = formatText;
			
			var i:int;
			while (i < args.length) {
				
				result = result.replace((("{" + i.toString()) + "}"), args[i]);
				
				i++;
			};
			
			return (result);
		}
		
		public static function isChineseName(source:String):Boolean{
			
			
			
			
			return (getChineseNameRegExp().test(source));
		}
		
		public static function isEnglishName(source:String):Boolean{
			
			
			
			
			return (getEnglishNameRegExp().test(source));
		}
		
		public static function isEmail(source:String):Boolean{
			
			
			
			
			return (getEmailRegExp().test(source));
		}
		
		public static function isIDCard(source:String):Boolean{
			
			
			
			
			return (getIDCardRegExp().test(source));
		}
		
		public static function isMobile(source:String):Boolean{
			
			
			
			
			return (getMobileRegExp().test(source));
		}
		
		public static function isPhone(source:String):Boolean{
			
			
			
			
			return (getPhoneRegExp().test(source));
		}
		
		public static function isUserId(source:String):Boolean{
			
			
			
			
			return (getUserIdRegExp().test(source));
		}
		
		public static function isUrl(source:String):Boolean{
			
			
			
			
			return (getUrlRegExp().test(source));
		}
		
		public static function repeat(str:String, count:int):String{
			
			
			
			
			
			
			
			var result:String = "";
			
			var i:int;
			while (i < count) {
				
				result = (result + str);
				
				i++;
			};
			
			return (result);
		}
		
		public static function padLeft(source:String, fill:String, count:int):String{
			
			
			
			
			
			
			
			var result:String = (repeat(fill, count) + source);
			
			result = result.substr((result.length - count));
			
			return (result);
		}
		
		public static function padRight(source:String, fill:String, count:int):String{
			
			
			
			
			
			
			
			var result:String = (source + repeat(fill, count));
			
			result = result.substr(0, count);
			
			return (result);
		}
		
		public static function isEmpty(source:String):Boolean{
			
			
			
			
			if (source == null){
				return (true);
			};
			
			if (source == ""){
				return (true);
			};
			
			
			if (/^\s*$/.test(source)){
				return (true);
			};
			
			return (false);
		}
		
		
	}
	
	
	
	
	
}//package hs.framework.utils
