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
				obj["wKindID"] 		= BytesUtil.read(bytes, BytesType.WORD);		//名称索引
				obj["wNodeID"] 		= BytesUtil.read(bytes, BytesType.WORD);		//节点索引(忽略)
				obj["wSortID"] 		= BytesUtil.read(bytes, BytesType.WORD);		//排序索引(忽略)
				obj["wServerID"] 		= BytesUtil.read(bytes, BytesType.WORD);		//房间索引
				obj["wServerPort"] 	= BytesUtil.read(bytes, BytesType.WORD);		//房间端口
				obj["dwOnLineCount"]	= BytesUtil.read(bytes, BytesType.DWORD);		//在线人数
				obj["dwFullCount"]		= BytesUtil.read(bytes, BytesType.DWORD);		//满员人数
				obj["szServerAddr"]	= BytesUtil.read(bytes, BytesType.CHAR,	32);	//IP
				obj["szServerName"]	= BytesUtil.read(bytes, BytesType.CHAR,	32);	//房间名称
				arr.push(obj);
			}
			vo["arRoom"] = arr;
			
			return vo;
		}
	}
}