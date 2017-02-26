package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_103 申请庄家返回*/
	public class MsgBZWApplyBankerRec implements IRpcDecoder
	{
		public function MsgBZWApplyBankerRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wChairID"] 			= BytesUtil.read(bytes, BytesType.WORD);		//申请玩家
			
			return vo;
		}
	}
}