package net.messages.status
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**24_100 桌子状态*/
	public class MsgTableStatusRec implements IRpcDecoder
	{
		public function MsgTableStatusRec()
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
				obj["cbTableLock"] 			= BytesUtil.read(bytes, BytesType.BYTE);
				obj["cbPlayStatus"] 			= BytesUtil.read(bytes, BytesType.BYTE);
				arr.push(obj);
			}
			vo["arTableStatus"] = arr;
			
			return vo;
		}
	}
}