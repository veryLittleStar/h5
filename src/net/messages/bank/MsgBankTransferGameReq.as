package net.messages.bank
{
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_7 请求转金币到游戏
	 * */
	public class MsgBankTransferGameReq implements IRpcEncoder
	{
		public function MsgBankTransferGameReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,7);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbActivityGame);		//游戏动作
			BytesUtil.write(bytes, BytesType.SCORE,body.lTransferScore);	//转账金币
			var password:String = body.szInsurePass;
			if(password != "")
			{
				password = MD5.hash(password);
			}
			BytesUtil.write(bytes, BytesType.TCHAR,password,33);			//银行密码
			

			
			return bytes;
		}
	}
}