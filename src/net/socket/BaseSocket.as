package net.socket
{
	
	import laya.events.Event;
	import laya.events.EventDispatcher;
	import laya.net.Socket;
	
	public class BaseSocket extends EventDispatcher
	{
		private var _port:int;				//服务器地址
		private var _host:String;			//服务器端口
		private var _securityPort:int;		//
		protected var _socket:Socket;		//基础socket
		protected var _buffers:Array;		//存储要发送的对象
		
		/**
		 * 基本SOCKT 
		 * @param host IP地址
		 * @param port 端口
		 * @param securityPort 安全协议端口
		 * 
		 */			
		public function BaseSocket(host:String = null,port:int = 0,securityPort:int = 0)
		{
			_host = host;
			_port = port;
			_securityPort = securityPort;
			initialize();
		}
		
		protected function initialize():void
		{
			_buffers = new Array();
			
			_socket = new Socket(null, 0, ByteArray);
			_socket.endian = Socket.LITTLE_ENDIAN;
			_socket.on(Event.OPEN, this, socketOpen);
			_socket.on(Event.CLOSE, this, socketClose);
			_socket.on(Event.ERROR, this, socketError);
			_socket.on(Event.MESSAGE, this, socketMessage);
		}
		
		/**
		 * 写入需要发送的值 
		 * @param obj 写入的对象
		 * @param isSend 是否立即发送
		 * 
		 */
		public function writeInSocket(byteArray:ByteArray,isSend:Boolean = true):void
		{
			throw new Error("需要被重写");
		}
		/**
		 * 
		 * 对socket所有字节进行刷新
		 */		
		public final function send():void
		{
			_socket.flush();
		}
		
		/**
		 * 
		 * 用来显示socket是否已经连接上了
		 * 
		 */		
		public final function get connected():Boolean
		{
			return _socket.connected;
		}
		
		/**
		 * 如果socket没有连接 ，socket连接主机
		 * 
		 */		
		public final function connect():void
		{
			if(!_socket.connected)
			{
				_socket.connect(host,port);
				trace('连接ip '+ host + ":"+port);
			}
		}
		
		/**
		 * 关闭socket连接
		 * 
		 */		
		public final function close():void
		{
			if(_socket.connected)
			{
				_socket.close();
			}
		}
		
		/**
		 * 处理添加的socket事件 
		 * 
		 */		
		public function dispose():void
		{
			clearBuffer();
			_buffers = null;
			if(_socket)
			{
				if(_socket.connected)
					_socket.close();
				_socket.off(Event.OPEN, this, socketOpen);
				_socket.off(Event.CLOSE, this, socketClose);
				_socket.off(Event.ERROR, this, socketError);
				_socket.off(Event.MESSAGE, this, socketMessage);
			}
			_socket = null;
		}
		
		/**
		 * 清空数据发送缓存池 
		 * 
		 */		
		public function clearBuffer():void
		{
			while(_buffers.length > 0)
				_buffers.pop();
		}
		
		protected function sendBuffer():void
		{
			if(_buffers.length > 0)
			{
				while(_buffers.length > 0)
				{
					var bu:ByteArray = _buffers.shift();
					writeInSocket(bu,false);
				}
				send();
			}
		}
		
		protected function socketOpen(event:* = null):void
		{
			sendBuffer();
		}
		
		protected function socketClose(event:* = null):void
		{
			
		}
		
		protected function socketError(event:* = null):void
		{
			
		}
		
		protected function socketMessage(data:ArrayBuffer):void
		{
			
		}
		
		public final function get securityPort():int
		{
			return _securityPort;
		}
		
		public final function set securityPort(value:int):void
		{
			_securityPort = value;
		}
		
		public final function get port():int
		{
			return _port;
		}
		
		public final function set port(value:int):void
		{
			_port = value;
		}
		
		public final function get host():String
		{
			return _host;
		}
		
		public final function set host(value:String):void
		{
			_host = value;
		}
	}
}