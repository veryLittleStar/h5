package net.messages.serverLogin
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	
	public class MsgHeartBeatReq implements IRpcEncoder
	{
		public function MsgHeartBeatReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = body.bytes;
			
			return bytes;
		}
	}
}