package net.messages.login
{
	import laya.net.Socket;
	
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	
	/**1_2 登录消息*/
	public class MsgLoginReq implements IRpcEncoder
	{
		public function MsgLoginReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,0x01);
			BytesUtil.write(bytes, BytesType.WORD,0x02);
			BytesUtil.write(bytes, BytesType.DWORD,0);
			var password:String = MD5.hash(body.password);
			BytesUtil.write(bytes, BytesType.CHAR, password,33);
			BytesUtil.write(bytes, BytesType.CHAR, password,33);
			BytesUtil.write(bytes, BytesType.CHAR, body.account,32);
			BytesUtil.write(bytes, BytesType.BYTE, 2);
			
			return bytes;
		}
	}
}