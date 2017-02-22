package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**23_102*/
	public class MsgUserStatusRec implements IRpcDecoder
	{
		public function MsgUserStatusRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//基本属性
			vo["dwUserID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//用户标识
			vo["wTableID"]			= BytesUtil.read(bytes, BytesType.WORD);			//桌子索引
			vo["wChairID"]			= BytesUtil.read(bytes, BytesType.WORD);			//椅子位置
			vo["cbUserStatus"]	= BytesUtil.read(bytes, BytesType.BYTE);			//用户状态
			
			
			return vo;
		}
	}
}