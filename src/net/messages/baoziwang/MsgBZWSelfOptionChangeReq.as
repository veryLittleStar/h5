package net.messages.baoziwang
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_6 更改秒注限制请求*/
	public class MsgBZWSelfOptionChangeReq implements IRpcEncoder
	{
		public function MsgBZWSelfOptionChangeReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,200);
			BytesUtil.write(bytes, BytesType.WORD,6);
			
			BytesUtil.write(bytes, BytesType.SCORE,body.lSelfOption);		//秒注限制
			
			return bytes;
		}
	}
}