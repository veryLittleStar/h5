package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_99 豹子王  游戏空闲*/
	public class MsgBZWGameFreeRec implements IRpcDecoder
	{
		public function MsgBZWGameFreeRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["cbTimeLeave"] 			= BytesUtil.read(bytes, BytesType.BYTE);			//剩余时间
			vo["nListUserCount"]		= BytesUtil.read(bytes, BytesType.INT64);			//列表人数
			
			return vo;
		}
	}
}