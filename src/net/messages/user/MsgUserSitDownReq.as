package net.messages.user
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_3 玩家请求在桌子坐下*/
	public class MsgUserSitDownReq implements IRpcEncoder
	{
		public function MsgUserSitDownReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,23);
			BytesUtil.write(bytes, BytesType.WORD,3);
			BytesUtil.write(bytes, BytesType.WORD,body.wTableID);
			BytesUtil.write(bytes, BytesType.WORD,body.wChairID);
			BytesUtil.write(bytes, BytesType.CHAR, body.szPassword,33);
			
			return bytes;
		}
	}
}