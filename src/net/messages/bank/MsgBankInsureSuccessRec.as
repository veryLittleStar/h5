package net.messages.bank
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_101操作银行成功返回*/
	public class MsgBankInsureSuccessRec implements IRpcDecoder
	{
		public function MsgBankInsureSuccessRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["cbActivityGame"] 		= BytesUtil.read(bytes, BytesType.BYTE);		//游戏动作
			vo["lUserScore"] 			= BytesUtil.read(bytes, BytesType.SCORE);		//身上金币
			vo["lUserInsure"] 			= BytesUtil.read(bytes, BytesType.SCORE);		//银行金币
			vo["wLength"] 				= BytesUtil.read(bytes, BytesType.WORD);		//消息长度
			vo["szDescribeString"] 	= BytesUtil.read(bytes, BytesType.TCHAR,vo.wLength);	//描述消息
			
			return vo;
			
		}
	}
}