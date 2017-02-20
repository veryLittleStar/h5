package net.messages.gameLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**21_100 游戏房间服务器登录成功*/
	public class MsgRoomLoginSucessRec implements IRpcDecoder
	{
		public function MsgRoomLoginSucessRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["dwUserRight"] 		= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwMasterRight"]		= BytesUtil.read(bytes, BytesType.DWORD);
			
			return vo;;
		}
	}
}