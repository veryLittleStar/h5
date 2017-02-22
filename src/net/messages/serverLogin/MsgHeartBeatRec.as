package net.messages.serverLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	
	public class MsgHeartBeatRec implements IRpcDecoder
	{
		public function MsgHeartBeatRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["bytes"] = bytes;
			
			return vo;
		}
	}
}