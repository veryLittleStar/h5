package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_107 用户下注失败*/
	public class MsgBZWPlaceJetionFailRec implements IRpcDecoder
	{
		public function MsgBZWPlaceJetionFailRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wPlaceUser"] 		= BytesUtil.read(bytes, BytesType.WORD);		//下注玩家
			vo["lJettonArea"]		= BytesUtil.read(bytes, BytesType.BYTE);		//下注区域
			vo["lPlaceScore"] 		= BytesUtil.read(bytes, BytesType.LONGLONG);	//当前下注
			
			return vo;
		}
	}
}