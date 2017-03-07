package net.messages.bank
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_104*/
	public class MsgBankPwdChangeRec implements IRpcDecoder
	{
		public function MsgBankPwdChangeRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["lErrorCode"] 			= BytesUtil.read(bytes, BytesType.LONG);		//错误代码
			vo["wLength"] 				= BytesUtil.read(bytes, BytesType.WORD);		//消息长度
			vo["szDescribeString"] 	= BytesUtil.read(bytes, BytesType.TCHAR,vo.wLength);	//描述消息
			
			
			return vo;
		}
	}
}