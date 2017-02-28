package net.messages.serverLogin
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**1_4 第三方登录消息*/
	public class MsgLoginThirdPartReq implements IRpcEncoder
	{
		public function MsgLoginThirdPartReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,0x01);
			BytesUtil.write(bytes, BytesType.WORD,0x04);
			BytesUtil.write(bytes, BytesType.BYTE, body.s);
			BytesUtil.write(bytes, BytesType.TCHAR, body.pid,33);
			
			
			return bytes;
		}
	}
}