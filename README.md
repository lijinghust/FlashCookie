# FlashCookie
flash cookie存储方案

>src目录为flash源码，需要编译为swf文件.

#使用方法
1. 将flashcookie.swf引入页面中
2. 在JavaScript中获取到该flash对象
3. 通过该flash对象即可操作flashcookie中各API
 
>注意：不支持file://协议，因此需要将页面放在http服务下进行测试


#Flash调用函数
```
/**
 * ！建议使用（可选择不用）
 *
 * 由于flash和浏览器是两个独立的系统，flash加载成功到方法可被调用的话可能会有几十毫秒延时，需要注意这点
 * 
 * js_flash_cookie_init
 *
 * flash加载成功后调用的js函数，可以保证js执行的时候flash方法可以被正常调用
 * 
 * 
 */
```

#API

* set(key, value)
```
/**
 * [set 删除该flash cookie下存储的该key的数据]
 *
 * @param  {string} key 
 * @param  {string/int/object等} value  
 *
 * @return {object}     数据对象
 */ 
```
* get(key)
```
/**
 * [get 获取该flash cookie下存储的该key的数据]
 *
 * @param  {string} key  
 *
 * @return {string/int/object等}     数据值
 */ 
```
* remove(key)
```
/**
 * [remove 删除该flash cookie下存储的该key的数据]
 *
 * @param  {string} key  
 *
 * @return null
 */ 
```
* clear()
```
/**
 * [clear 清楚该flash cookie下存储的所有数据] 
 *
 * @return null
 */ 
```
* getAll() 
```
/**
 * [getAll 获取该flash cookie下存储的所有数据]
 *
 * @param  {string} key  
 *
 * @return {object}     数据对象
 */ 
```

* size()    
```
/**
 * [size 获取flash cookie数据的大小，以字节为单位]

 *
 * @return {uint}     返回存储数据的大小，以字节为单位
 */
```
#示例

```html
<html>
<head>
	<title>flash cookie demo</title>
	<meta charset="utf-8">
</head>
<body>

<script type="text/javascript">
(function(){
	var flashId = "_Flash_Cookie_";
	var flashPath = 'http://s8.qhimg.com/static/248e0d8a97bcf575.swf';

	// 动态插入Flash
	var insertFlash = function(path){
		var container = document.createElement("div"), html = [];

		if(window.ActiveXObject){
			html.push('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"',
				' width="1" height="1" id="',flashId,'">',
				'<param name="allowScriptAccess" value="always" />',
				'<param name="movie" value="',path,'" /></object>');
		}else{
			html.push('<embed src="',path,'" width="1" height="1" id="',flashId,'" ',
				'align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"/>');
		}

		var style = container.style;
		style.position = "absolute";
		style.top = "-9999px";
		var body = document.body;
		body.insertBefore(container, body.firstChild );
		container.innerHTML = html.join("");
		document.title=document.title.split("#")[0];
	};
	insertFlash(flashPath);

	// flash成功执行后会调用js_flash_cookie_init方法
	window.js_flash_cookie_init = function(){

		var FlashCookie = document.getElementById(flashId);
		// TODO 
		// 通过FlashCookie调用各种API即可
		// 如：FlashCookie.set('name', 'lj'); 
		// FlashCookie.get('name');  
	}
})();
</script>
</body>
</html>
```
