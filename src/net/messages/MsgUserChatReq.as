package net.messages
{
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_10 用户聊天请求*/
	public class MsgUserChatReq implements IRpcEncoder
	{
		public function MsgUserChatReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,100);
			BytesUtil.write(bytes, BytesType.WORD,10);
			BytesUtil.write(bytes, BytesType.WORD,body.wChatLength+1);			//信息长度
			BytesUtil.write(bytes, BytesType.DWORD,body.dwChatColor);			//信息颜色
			BytesUtil.write(bytes, BytesType.DWORD,body.dwTargetUserID);		//目标用户
			var length:int = body.wChatLength+1;
			if(length > 128)length = 128;
			BytesUtil.write(bytes, BytesType.TCHAR, body.szChatString,length);		//聊天信息
			
			return bytes;
		}
	}
}