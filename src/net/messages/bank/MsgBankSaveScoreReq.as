package net.messages.bank
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_2 存款操作请求*/
	public class MsgBankSaveScoreReq implements IRpcEncoder
	{
		public function MsgBankSaveScoreReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,2);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbActivityGame);		//游戏动作
			BytesUtil.write(bytes, BytesType.SCORE,body.lSaveScore);		//存款数目
			
			return bytes;
		}
	}
}