package net.messages.serverLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**1_102 登录服务器登录完成*/
	public class MsgLoginFinishRec implements IRpcDecoder
	{
		public function MsgLoginFinishRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wIntermitTime"] 			= BytesUtil.read(bytes, BytesType.WORD);		//中断时间
			vo["wOnLineCountTime"] 		= BytesUtil.read(bytes, BytesType.WORD);		//更新时间
			
			return vo;
		}
	}
}