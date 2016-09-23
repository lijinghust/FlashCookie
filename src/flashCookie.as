package
{
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.system.Security;
	
	public class flashCookie extends Sprite
	{
		private var cookieSharedObj:SharedObject;
		
		public function flashCookie()
		{
			// 允许所标识的域中的html文件执行调用swf文件中的对象和变量
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			cookieSharedObj = SharedObject.getLocal("__flashCookie", "/");
			try{
				ExternalInterface.addCallback("get", getCookie);
				ExternalInterface.addCallback("set", setCookie);
				ExternalInterface.addCallback("remove", removeCookie);
				ExternalInterface.addCallback("clear", clearCookie);
				ExternalInterface.addCallback("getAll", getAllCookie);
				ExternalInterface.addCallback("size", size);
				
				// flash成功执行后调用js方法
				ExternalInterface.call("js_flash_cookie_init");
			}catch(error:Error){
				throw(error);
			}
			
		}
		public function getCookie(key:String):Object
		{
			return cookieSharedObj.data[key];
		}
		public function setCookie(key:String, value:*):void
		{
			cookieSharedObj.data[key] = value;
			cookieSharedObj.flush();
		}
		public function removeCookie(key:String):void
		{
			delete cookieSharedObj.data[key];
			cookieSharedObj.flush();
		}
		public function clearCookie():void
		{
			cookieSharedObj.clear();
		}
		public function getAllCookie():Object
		{
			return cookieSharedObj.data;
		}
		public function size():uint
		{
			return cookieSharedObj.size;
		}
	}
}