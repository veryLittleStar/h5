package net.messages.serverLogin
{
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**1_3*/
	public class MsgRegisterAccountReq implements IRpcEncoder
	{
		public function MsgRegisterAccountReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,0x01);
			BytesUtil.write(bytes, BytesType.WORD,0x03);
			
			BytesUtil.write(bytes, BytesType.TCHAR, MD5.hash(body.szLogonPass),33);		//登录密码
			BytesUtil.write(bytes, BytesType.TCHAR, MD5.hash(body.szInsurePass),33);	//银行密码
			
			
			//注册信息
			BytesUtil.write(bytes, BytesType.WORD, body.wFaceID);					//头像标识
			BytesUtil.write(bytes, BytesType.BYTE, body.cbGender);					//用户性别
			BytesUtil.write(bytes, BytesType.TCHAR, body.szAccounts,37);		//登录帐号
			BytesUtil.write(bytes, BytesType.TCHAR, body.szNickName,32);		//用户昵称

			
			return bytes;
		}
	}
}