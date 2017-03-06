package net.messages.bank
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_1 查询银行信息请求*/
	public class MsgBankInsureInfoReq implements IRpcEncoder
	{
		public function MsgBankInsureInfoReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,25);
			BytesUtil.write(bytes, BytesType.WORD,1);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbActivityGame);			//游戏动作
			
			
			return bytes;
		}
	}
}