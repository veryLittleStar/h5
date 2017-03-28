package net
{
	import laya.utils.Browser;
	import laya.utils.Handler;
	
	import managers.ManagersDefine;
	import managers.ManagersMap;
	import managers.ManagersProxy;
	
	import net.messages.RpcDecoderFac;
	import net.messages.RpcEncoderFac;
	import net.socket.ByteArray;
	import net.socket.BytesSocket;
	import net.socket.SocketEvent;
	
	import system.Logger;
	import system.Offline;

	public class NetProxy
	{
		private static var _instance:NetProxy;
		public static function getInstance():NetProxy
		{
			if(!_instance)
			{
				_instance = new NetProxy();
			}
			return _instance;
		}
		//////////////////////////////////////
		private var _socket:BytesSocket;
		
		//////////////////////////////////////
		
		public function NetProxy()
		{
			_socket = new BytesSocket();
			_socket.openHandler = Handler.create(this,onSocketOpen,null,false);
			_socket.closeHandler = Handler.create(this,onSocketClose,null,false);
			_socket.messageHandler = Handler.create(this,onSocketMessage,null,false);
		}
		
		private function onSocketOpen():void
		{
			var obj:Object = {};
			if(_socket.host == Browser.window.initConfig.loginHost && _socket.port == Browser.window.initConfig.loginPort)
			{
				ManagersMap.serverLoginManager.onSocketConnect();
			}
			else
			{
				ManagersMap.serverLoginManager.closeMe();
				ManagersMap.baoziwangManager.openMe();
				ManagersMap.gameLoginManager.roomLoginReq();
			}
								
		}
		
		private function onSocketClose():void
		{
			if(_socket.host == Browser.window.initConfig.loginHost && _socket.port == Browser.window.initConfig.loginPort)
			{
				
			}
			else
			{
				Offline.getInstance().openMe();
			}
		}
		
		private function onSocketMessage(byteArray:ByteArray):void
		{
			getFromServer(byteArray);
		}
		
		public function execute(cmd:String,data:Object):void
		{
			switch(cmd)
			{
				case NetDefine.CONNECT_SOCKET:
					connectSocket(data);
					break;
			}
		}
		
		/**obj.ip
		 * obj.port*/
		private function connectSocket(obj:Object):void
		{
			_socket.host = obj.host;
			_socket.port = obj.port;
			if(_socket.connected)
			{
				_socket.close();
			}
			_socket.connect();
		}
		
		public function socketConnected():Boolean
		{
			return _socket.connected;
		}
		
		/**
		 * obj.header  	包头
		 * obj.body		数据
		 * */
		public function sendToServer(header:String,body:Object):void
		{
			var bytes:ByteArray = RpcEncoderFac.getInstance().getEncodeData(header,body);
			trace("发送数据，消息号：",header.split("_")[0],header.split("_")[1],"数据长度：",bytes.length-4,{body:body});
			if(bytes)
			{
				_socket.writeInSocket(bytes);
			}
		}
		
		private function getFromServer(bytes:ByteArray):void
		{
			var main:int = bytes.readUnsignedShort();
			var sub:int = bytes.readUnsignedShort();
			var header:String = main + "_" + sub;
			var body:Object = RpcDecoderFac.getInstance().getDecodeData(header,bytes);
			trace("接收数据，消息号：",main,sub,"数据长度:",bytes.length-4,{body:body});
			ManagersProxy.getInstance().messageHanlder(header,body);
		}
	}
}