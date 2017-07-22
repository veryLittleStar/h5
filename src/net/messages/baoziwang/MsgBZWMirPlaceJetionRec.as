package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_110 从传奇那边过来的下注额更新*/
	public class MsgBZWMirPlaceJetionRec implements IRpcDecoder
	{
		public function MsgBZWMirPlaceJetionRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			var i:int;
			var arr:Array = [];
			for(i = 0; i < 3; i++)
			{
				arr.push(BytesUtil.read(bytes, BytesType.LONGLONG));
			}
			vo["arMirlAreaInAllScore"]	= arr;													//传奇每个区域的总分
			
			return vo;
		}
	}
}