package net.messages.user
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_104 请求今日排行榜数据*/
	public class MsgUserRankListReq implements IRpcEncoder
	{
		public function MsgUserRankListReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,23);
			BytesUtil.write(bytes, BytesType.WORD,104);
			
			return bytes;
		}
	}
}