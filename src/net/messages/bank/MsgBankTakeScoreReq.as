package net.messages.bank
{
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_3 取款操作请求*/
	public class MsgBankTakeScoreReq implements IRpcEncoder
	{
		public function MsgBankTakeScoreReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,3);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbActivityGame);		//游戏动作
			BytesUtil.write(bytes, BytesType.SCORE,body.lTakeScore);		//存款数目
			var password:String = MD5.hash(body.szInsurePass);
			BytesUtil.write(bytes, BytesType.TCHAR,password,33);			//银行密码
			
			return bytes;
		}
	}
}