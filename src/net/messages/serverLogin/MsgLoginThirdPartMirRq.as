package net.messages.serverLogin
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**1_5 第三方登录 传奇*/
	public class MsgLoginThirdPartMirRq implements IRpcEncoder
	{
		public function MsgLoginThirdPartMirRq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,0x01);
			BytesUtil.write(bytes, BytesType.WORD,0x05);
			BytesUtil.write(bytes, BytesType.BYTE, body.cbGateID);
			BytesUtil.write(bytes, BytesType.BYTE, body.cbServerID);
			BytesUtil.write(bytes, BytesType.TCHAR, body.szAccount,11);
			BytesUtil.write(bytes, BytesType.TCHAR, body.szPwd,11);
			
			return bytes;
		}
	}
}