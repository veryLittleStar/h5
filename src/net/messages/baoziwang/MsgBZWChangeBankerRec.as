package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_104 切换庄家返回*/
	public class MsgBZWChangeBankerRec implements IRpcDecoder
	{
		public function MsgBZWChangeBankerRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["SBanker"] 		= MsgBZWApplyBankerNewRec.SBankerDecoder(bytes);
			
			
			return vo;
		}
	}
}