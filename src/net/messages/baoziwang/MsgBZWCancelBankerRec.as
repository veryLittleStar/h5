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
			
			vo["chIsMir"] 		= BytesUtil.read(bytes, BytesType.BYTE);
			vo["wChair"] 		= BytesUtil.read(bytes, BytesType.WORD);
			vo["szName"] 		= BytesUtil.read(bytes, BytesType.TCHAR,32);		//取消申请玩家
			
			return vo;
		}
	}
}