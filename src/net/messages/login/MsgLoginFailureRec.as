package net.messages.login
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**1_101 登录服务器登录失败*/
	public class MsgLoginFailureRec implements IRpcDecoder
	{
		public function MsgLoginFailureRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["lResultCode"] 			= BytesUtil.read(bytes, BytesType.INT);
			vo["szDescribeString"]	= BytesUtil.read(bytes, BytesType.CHAR,128);
			
			return vo;
		}
	}
}