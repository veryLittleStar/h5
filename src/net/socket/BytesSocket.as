package net.socket
{
	import laya.events.Event;
	import laya.net.Socket;
	import laya.utils.Byte;
	import laya.utils.Handler;
	
	import net.crypto.MD5;
	
	public class BytesSocket extends BaseSocket
	{
		private var _inputBa:ByteArray;
		private var _outputBa:ByteArray;
		public var openHandler:Handler;
		public var closeHandler:Handler;
		public var messageHandler:Handler;
		public var errorHandler:Handler;
		
		public function BytesSocket(host:String = null, port:int = 0, securityPort:int = 0)
		{
			super(host, port, securityPort);
		}
		
		/**
		 * 
		 * @param byte
		 * @param isSend
		 * 重写writeInSocket,用来传输对象
		 * 
		 */		
		override public function writeInSocket(bytes:ByteArray, isSend:Boolean=true):void
		{
			if(bytes)
			{
				if(connected)
				{
					_outputBa.writeBytes(bytes);
					if(isSend)
					{
						send();
					}
				}
				else
				{
					_buffers.push(bytes);
				}
			}
		}
		
		override protected function socketClose(event:* = null):void
		{
			trace("socket关闭");
			super.socketClose(event);
			if(closeHandler)
			{
				closeHandler.run();
			}
		}
		
		override protected function socketOpen(event:* = null):void
		{
			trace("socket连接成功");
			_socket.endian = Socket.LITTLE_ENDIAN;
			_inputBa = _socket.input;
			_outputBa = _socket.output;
			super.socketOpen(event);
			if(openHandler)
			{
				openHandler.run();
			}
		}
		
		override protected function socketError(event:Event = null):void
		{
			trace("socketError");
			super.socketError(event);
			if(errorHandler)
			{
				errorHandler.run();
			}
		}
		
		override protected function socketMessage(data:ArrayBuffer):void
		{
			if(!connect)return;
			_inputBa.position = 0;
			messageHandler.runWith(_inputBa);
			_inputBa.clear();
		}
		
		override public function clearBuffer():void
		{
			while(_buffers.length > 0)
			{
				var byte:ByteArray = _buffers.shift() as ByteArray;
				if(byte)
					byte.clear();//清除byte里内容从而释放内存空间
			}
		}
		
		/**
		 * 覆盖了父类BaseSocket的dispose,在处理添加的socket事件时要进行内存释放处理 
		 * 
		 */		
		override public function dispose():void
		{
			super.dispose();
		}
		
		public function reset():void
		{
			dispose();
			initialize();
		}
		
	}
}