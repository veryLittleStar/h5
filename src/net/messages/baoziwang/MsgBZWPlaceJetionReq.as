package net.messages.baoziwang
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_1 用户下注*/
	public class MsgBZWPlaceJetionReq implements IRpcEncoder
	{
		public function MsgBZWPlaceJetionReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,200);
			BytesUtil.write(bytes, BytesType.WORD,1);
			
			BytesUtil.write(bytes, BytesType.BYTE,body.cbJettonArea);			//筹码区域 大0 豹子1 小2
			BytesUtil.write(bytes, BytesType.LONGLONG,body.lJettonScore);		//加注数目
			
			return bytes;
		}
	}
}