package net.messages.serverLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**2_104 房间列表*/
	public class MsgRoomListRec implements IRpcDecoder
	{
		public function MsgRoomListRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			var arr:Array = [];
			var i:int = 0;
			var dwCount:int = BytesUtil.read(bytes, BytesType.INT);
			for(i = 0; i < dwCount; i++)
			{
				var obj:Object = {};
				obj["wKindID"] 			= BytesUtil.read(bytes, BytesType.WORD);
				obj["wNodeID"] 			= BytesUtil.read(bytes, BytesType.WORD);
				obj["wSortID"] 			= BytesUtil.read(bytes, BytesType.WORD);
				obj["wServerID"] 		= BytesUtil.read(bytes, BytesType.WORD);
				obj["wServerPort"] 		= BytesUtil.read(bytes, BytesType.WORD);
				obj["dwOnLineCount"]	= BytesUtil.read(bytes, BytesType.DWORD);
				obj["dwFullCount"]		= BytesUtil.read(bytes, BytesType.DWORD);
				obj["szServerAddr"]	= BytesUtil.read(bytes, BytesType.CHAR,	32);
				obj["szServerName"]	= BytesUtil.read(bytes, BytesType.CHAR,	32);
				arr.push(obj);
			}
			vo["arRoom"] = arr;
			
			return vo;
		}
	}
}