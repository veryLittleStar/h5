package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_103 qingqiushibai*/
	public class MsgUserRequestFailureRec implements IRpcDecoder
	{
		public function MsgUserRequestFailureRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["lErrorCode"]			= BytesUtil.read(bytes, BytesType.LONG);			//错误代码
			vo["wlength"]				= BytesUtil.read(bytes, BytesType.WORD);			
			vo["szDescribeString"]	= BytesUtil.read(bytes, BytesType.TCHAR,vo.wlength);//描述信息
			

			return vo;
		}
	}
}