package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_100*/
	public class MsgBZWGameStatusRec implements IRpcDecoder
	{
		public function MsgBZWGameStatusRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["cbGameStatus"] 	= BytesUtil.read(bytes, BytesType.BYTE);
			vo["cbAllowLookon"]	= BytesUtil.read(bytes, BytesType.BYTE);
			
			return vo;
		}
	}
}