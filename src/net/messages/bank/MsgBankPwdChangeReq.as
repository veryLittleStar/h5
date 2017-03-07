package net.messages.bank
{
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_6*/
	public class MsgBankPwdChangeReq implements IRpcEncoder
	{
		public function MsgBankPwdChangeReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,6);
			
			BytesUtil.write(bytes, BytesType.DWORD,body.dwUserID);			//用户 I D
			var newPass:String = body.szDesPassword;
			if(newPass != "")
			{
				newPass = MD5.hash(newPass);
			}
			BytesUtil.write(bytes, BytesType.TCHAR,newPass,33);		//新密码
			var oldPass:String = body.szScrPassword;
			if(oldPass != "")
			{
				oldPass = MD5.hash(oldPass);
			}
			BytesUtil.write(bytes, BytesType.TCHAR,oldPass,33);		//老密码
			

			
			return bytes;
		}
	}
}