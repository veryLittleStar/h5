package net.messages.baoziwang
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_5 用户秒注*/
	public class MsgBZWAllInJetionReq implements IRpcEncoder
	{
		public function MsgBZWAllInJetionReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,200);
			BytesUtil.write(bytes, BytesType.WORD,5);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbJettonArea);			//筹码区域 大0 豹子1 小2
			
			return bytes;
		}
	}
}