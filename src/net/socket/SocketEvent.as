package net.socket
{
	import laya.events.Event;
	
	public class SocketEvent extends Event
	{
		public static const SOCKET_BYTES_UPDATE:String = "socket_bytes_update";
		public static const SOCKET_CONNECT:String = "socket_bytes_connect";
		public static const SOCKET_CLOSE:String = "socket_bytes_close";
		
		public function SocketEvent(type:String)
		{
			super();
			this.type = type;
		}
	}
}