package net.messages.gameLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**21_101 房间服务器登录失败*/
	public class MsgRoomLoginFailureRec implements IRpcDecoder
	{
		public function MsgRoomLoginFailureRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["lErrorCode"] 			= BytesUtil.read(bytes, BytesType.LONG);
			vo["szDescribeString"]	= BytesUtil.read(bytes, BytesType.CHAR,128);
			
			return vo;
		}
	}
}