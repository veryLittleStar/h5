package net.messages.baoziwang
{
	import net.messages.IRpcEncoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_1*/
	public class MsgGameOptionReq implements IRpcEncoder
	{
		public function MsgGameOptionReq()
		{
		}
		
		public function makeEncodeBytes(body:Object):ByteArray
		{
			var bytes:ByteArray = BytesUtil.getByteArray();
			
			BytesUtil.write(bytes, BytesType.WORD,100);
			BytesUtil.write(bytes, BytesType.WORD,1);
			BytesUtil.write(bytes, BytesType.BYTE,body.cbAllowLookon);
			BytesUtil.write(bytes, BytesType.DWORD,body.dwFrameVersion);
			BytesUtil.write(bytes, BytesType.DWORD,body.dwClientVersion);
			
			return bytes;
		}
	}
}