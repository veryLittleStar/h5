package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_200 系统提示*/
	public class MsgSystemMessageRec implements IRpcDecoder
	{
		public function MsgSystemMessageRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//基本属性
			vo["wType"]			= BytesUtil.read(bytes, BytesType.WORD);			//消息类型
			vo["wLength"]			= BytesUtil.read(bytes, BytesType.WORD);			//消息长度
			vo["szString"]			= BytesUtil.read(bytes, BytesType.TCHAR,vo.wLength);//消息内容  实际并不会发1024 最多1024
			
			return vo;
		}
	}
}