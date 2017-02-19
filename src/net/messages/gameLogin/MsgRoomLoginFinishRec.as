package net.messages.gameLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	/**21_102 房间服务器登录完成*/
	public class MsgRoomLoginFinishRec implements IRpcDecoder
	{
		public function MsgRoomLoginFinishRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			return null;
		}
	}
}