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
				obj.header = "1_2";
				obj.body = {};
				obj.body.account = "111111";
				obj.body.password = "111111";
				sendToServer(obj);
			}
			else
			{
				obj.header = "21_1";
				obj.body = {};
				obj.body.account = "111111";
				obj.body.password = "111111";
				obj.body.dwUserID 	= ManagersMap.loginManager.userData.dwUserID;
				obj.body.wKindID	= ManagersMap.loginManager.userData.wKindID;
				sendToServer(obj);
			}
								
		}
		
		private function onSocketClose():void
		{
			
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
				case NetDefine.SEND_TO_SERVER:
					sendToServer(data);
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
		
		/**
		 * obj.header  	包头
		 * obj.body		数据
		 * */
		private function sendToServer(obj:Object):void
		{
			var bytes:ByteArray = RpcEncoderFac.getInstance().getEncodeData(obj.header,obj.body);
			trace("发送数据，消息号：",String(obj.header).split("_")[0],String(obj.header).split("_")[1],"数据长度：",bytes.length-4,obj.body);
			if(bytes)
			{
				_socket.writeInSocket(bytes);
			}
		}
		
		private function getFromServer(bytes:ByteArray):void
		{
			var main:int = bytes.readUnsignedShort();
			var sub:int = bytes.readUnsignedShort();
			var data:Object = {};
			data.header = main + "_" + sub;
			data.body = RpcDecoderFac.getInstance().getDecodeData(data.header,bytes);
			trace("接收数据，消息号：",main,sub,"数据长度:",bytes.length-4,data);
			ManagersProxy.getInstance().execute(ManagersDefine.MESSAGE_FROM_SERVER,data);
		}
	}
}