package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	
	/**200_6 更改秒注限制返回*/
	public class MsgBZWSelfOptionChangeRec implements IRpcDecoder
	{
		public function MsgBZWSelfOptionChangeRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["lSelfOption"] 		= BytesUtil.read(bytes, BytesType.SCORE);		//
			
			return vo;
		}
	}
}