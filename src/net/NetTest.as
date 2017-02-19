package net
{
	import laya.events.Event;
	import laya.events.Keyboard;
	import laya.net.Socket;
	
	import net.socket.BytesSocket;
	import net.socket.SocketEvent;

	public class NetTest
	{
		private var bytesSocket:BytesSocket;
		
		public function NetTest()
		{
			bytesSocket = new BytesSocket("192.168.31.214",8300);
//			bytesSocket = new BytesSocket("192.168.31.214",38950);
			Laya.stage.on(Event.KEY_UP,this,key_up);
		}
		
		private function key_up(event:Event):void
		{
			switch(event.keyCode)
			{
				case Keyboard.Q:
					bytesSocket.connect();
					break;
				case Keyboard.W:
					bytesSocket.close();
					break;
				case Keyboard.E:
					break;
				case Keyboard.R:
					break;
				case Keyboard.T:
					break;
			}
		}
		
	}
}