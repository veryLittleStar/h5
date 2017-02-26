package net.messages.baoziwang
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_2 申请庄家请求*/
	public class MsgBZWApplyBankerReq implements IRpcEncoder
	{
		public function MsgBZWApplyBankerReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,200);
			BytesUtil.write(bytes, BytesType.WORD,2);
			
			return bytes;
		}
	}
}