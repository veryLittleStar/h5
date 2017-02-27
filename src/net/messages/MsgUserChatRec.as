package net.messages
{
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_10 用户聊天返回*/
	public class MsgUserChatRec implements IRpcDecoder
	{
		public function MsgUserChatRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wChatLength"]				= BytesUtil.read(bytes, BytesType.WORD);			//信息长度
			vo["dwChatColor"]				= BytesUtil.read(bytes, BytesType.DWORD);			//信息颜色
			vo["dwSendUserID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//发送用户
			vo["dwTargetUserID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//目标用户
			vo["szChatString"]			= BytesUtil.read(bytes, BytesType.TCHAR,vo.wChatLength);	//聊天信息
			
			return vo;
		}
	}
}