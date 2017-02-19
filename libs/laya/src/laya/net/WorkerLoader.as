package laya.net 
{
	import laya.events.EventDispatcher;
	import laya.net.Loader;
	import laya.renders.Render;
	import laya.resource.HTMLCanvas;
	import laya.resource.HTMLImage;
	import laya.resource.Texture;
	import laya.utils.Browser;
	/**
	 * @private
	 * Worker Image加载器
	 */
	public class WorkerLoader extends EventDispatcher
	{
		/**
		 * 图片加载完成事件
		 */
		public static const IMAGE_LOADED:String = "image_loaded";
		/**
		 * 图片加载失败事件
		 */
		public static const IMAGE_ERR:String = "image_err";
		/**
		 * 图片加载过程中的信息
		 */
		public static const IMAGE_MSG:String = "image_msg";
		
		/**
		 * 实例
		 */
		public static var I:WorkerLoader;
		/**
		 * @private
		 */
		private static var _preLoadFun:Function;
		/**
		 * @private
		 */
		private static var _enable:Boolean = false;
		
		/**
		 * 尝试使用Work加载Image
		 * @return 是否启动成功
		 */
		public static function __init__():Boolean
		{
			if (_preLoadFun) return;
			if (!Browser.window.Worker) return;
			_preLoadFun = Loader["prototype"]["_loadImage"];
			Loader["prototype"]["_loadImage"] = WorkerLoader["prototype"]["_loadImage"];
			if (!I) I = new WorkerLoader();
			return true;
		}
		
		/**
		 * 是否启用。
		 */
		public static function set enable(v:Boolean):void
		{
			_enable = v;
			if (_enable && !_preLoadFun) __init__();
		}
		
		public static function get enable():Boolean
		{
			return _enable;
		}
		
		/**
		 * 使用的Worker对象。
		 */
		public var worker:Worker ;
		public function WorkerLoader() 
		{
			worker = new Browser.window.Worker("libs/worker.js");
			worker.onmessage = function(evt) { 
				//接收worker传过来的数据函数
				workerMessage(evt.data);
			}
		}
		/**
		 * @private
		 */
		private function workerMessage(data:*):void
		{
			if (data)
			{
				switch(data.type)
				{
					case "Image":
						imageLoaded(data);
						break;
					case "Msg":
						event(IMAGE_MSG, data.msg);
						break;
				}
			}
		}
		
		/**
		 * @private
		 */
		private function imageLoaded(data:*):void
		{
			
			if (!data.dataType)
			{
				event(data.url, null);
				event(IMAGE_ERR, data.url+"\n"+data.msg);
				return;
			}
			
			//性能统计用
			
			//var acceptTime:Number;
			//acceptTime = Browser.now();
			//
			//_myTrace("DataType:", data.dataType);
			//_myTrace("transferTime:", acceptTime - data.sendTime);
			
			var canvas:HTMLCanvas = new HTMLCanvas("2D");
			//canvas.src = data.url;
			var ctx:*;
			ctx = canvas.source.getContext("2d");   
			
			var imageData:*;
			switch(data.dataType)
			{
				case "buffer":
					 //_myTrace("new ImageDataTime:",Browser.now() -acceptTime);
					 imageData = ctx.createImageData(data.width, data.height);
			         imageData.data.set(data.buffer);
					 canvas.size(imageData.width, imageData.height);
			         ctx.putImageData(imageData, 0, 0);
					break;
				case "imagedata":
					imageData = data.imagedata;
					canvas.size(imageData.width, imageData.height);
			        ctx.putImageData(imageData, 0, 0);
					imageData = data.imagedata;
					break;
				case "imageBitmap":
					imageData = data.imageBitmap;
					canvas.size(imageData.width, imageData.height);
					ctx.drawImage(imageData, 0, 0);
					break;
				
			}
			
			//性能统计信息
			//_myTrace("PNGdecodeTime:", data.decodeTime);
			//_myTrace("getBufferTime:", data.getBufferTime);
			//_myTrace("putImageDataTime:",Browser.now() -acceptTime);
			//_myTrace("allDecodeTime:", Browser.now() - data.startTime);
			
			
			if (Render.isWebGL)
			{
				__JS__("canvas=new laya.webgl.resource.WebGLImage(canvas,data.url);");
				
			}
			event(data.url, canvas);
		}
		
		/**
		 * @private
		 */
		private function _myTrace(...arg):void
		{
			var rst:Array=[];
			var i:int,len:int=arg.length;		
			for(i=0;i<len;i++)
			{
				rst.push(arg[i]);
			}
			event(IMAGE_MSG, rst.join(" "));
		}
		
		/**
		 * 加载图片
		 * @param	url 图片地址
		 */
		public function loadImage(url:String):void
		{
			var data:Object;
			data = { };
			data.type = "load";
			data.url = url;
			worker.postMessage(data);
		}
		
		/**
		 * @private
		 * 加载图片资源。
		 * @param	url 资源地址。
		 */
		protected function _loadImage(url:String):void {
			var _this:Loader = this;
			if (!_enable||url.toLowerCase().indexOf(".png") < 0)
			{
				_preLoadFun.call(_this, url);
				return;
			}
			function clear():void {
				WorkerLoader.I.off(url, _this, onload);
			}
			
			var onload:Function = function(image:*):void {
				clear();
				if (image)
				{
					_this.onLoaded(image);
				}else
				{
					//失败之后使用原版的加载函数加载重试
					//_this.event(Event.ERROR, "Load image failed");
					_preLoadFun.call(_this, url);
					
				}
				
			};
			WorkerLoader.I.on(url, _this, onload);
			WorkerLoader.I.loadImage(url);
		}
		
	}

}