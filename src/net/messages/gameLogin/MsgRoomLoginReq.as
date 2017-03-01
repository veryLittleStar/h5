package net.messages.gameLogin
{
	import laya.net.Socket;
	
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**21_01 登录房间*/
	public class MsgRoomLoginReq implements IRpcEncoder
	{
		public function MsgRoomLoginReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,21);
			BytesUtil.write(bytes, BytesType.WORD,1);
			BytesUtil.write(bytes, BytesType.DWORD,body.dwUserID);
			BytesUtil.write(bytes, BytesType.CHAR, body.password,33);
			BytesUtil.write(bytes, BytesType.CHAR, body.password,33);
			BytesUtil.write(bytes, BytesType.WORD,body.wKindID);
			
			return bytes;
		}
	}
}