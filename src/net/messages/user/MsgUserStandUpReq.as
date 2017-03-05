package net.messages.user
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_4 用户请求离开桌子*/
	public class MsgUserStandUpReq implements IRpcEncoder
	{
		public function MsgUserStandUpReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,23);
			BytesUtil.write(bytes, BytesType.WORD,4);
			BytesUtil.write(bytes, BytesType.WORD,body.wTableID);
			BytesUtil.write(bytes, BytesType.WORD,body.wChairID);
			BytesUtil.write(bytes, BytesType.BYTE, body.cbForceLeave);
			
			return bytes;

		}
	}
}