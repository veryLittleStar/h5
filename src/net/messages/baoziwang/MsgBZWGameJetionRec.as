package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**200_101 通知开始下注*/
	public class MsgBZWGameJetionRec implements IRpcDecoder
	{
		public function MsgBZWGameJetionRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wChairID"] 		= BytesUtil.read(bytes, BytesType.WORD);			//用户位置
			vo["cbJettonArea"]	= BytesUtil.read(bytes, BytesType.BYTE);			//筹码区域
			vo["lJettonScore"] 	= BytesUtil.read(bytes, BytesType.LONGLONG);		//加注数目
			vo["cbAndroid"]		= BytesUtil.read(bytes, BytesType.BYTE);			//机器人
			
			return vo;
		}
	}
}