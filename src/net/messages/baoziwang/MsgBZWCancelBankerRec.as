package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**200_108 取消申请上庄返回*/
	public class MsgBZWCancelBankerRec implements IRpcDecoder
	{
		public function MsgBZWCancelBankerRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["szCancelUser"] 			= BytesUtil.read(bytes, BytesType.TCHAR,32);		//取消申请玩家
			
			return vo;
		}
	}
}