package net.messages.bank
{
	import net.crypto.MD5;
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_4 转账金币请求*/
	public class MsgBankTransferScoreReq implements IRpcEncoder
	{
		public function MsgBankTransferScoreReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,4);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbActivityGame);		//游戏动作
			BytesUtil.write(bytes, BytesType.BYTE,body.cbByNickName);		//昵称赠送
			BytesUtil.write(bytes, BytesType.SCORE,body.lTransferScore);	//转账金币
			BytesUtil.write(bytes, BytesType.TCHAR,body.szNickName,32);		//目标用户
			var password:String = MD5.hash(body.szInsurePass);
			BytesUtil.write(bytes, BytesType.TCHAR,password,33);			//银行密码
			
			return bytes;
		}
	}
}