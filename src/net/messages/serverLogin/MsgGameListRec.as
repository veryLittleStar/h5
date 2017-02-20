package net.messages.serverLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**2_101 游戏列表*/
	public class MsgGameListRec implements IRpcDecoder
	{
		public function MsgGameListRec()
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
				obj["wGameID"] 			= BytesUtil.read(bytes, BytesType.WORD);
				obj["dwOnLineCount"]	= BytesUtil.read(bytes, BytesType.DWORD);
				obj["dwFullCount"]		= BytesUtil.read(bytes, BytesType.DWORD);
				obj["szKindName"]		= BytesUtil.read(bytes, BytesType.CHAR,	32);
				arr.push(obj);
			}
			vo["arGame"] = arr;
			
			
			
			return vo;
		}
	}
}