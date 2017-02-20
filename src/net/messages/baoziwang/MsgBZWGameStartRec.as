package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_99 豹子王  游戏开始*/
	public class MsgBZWGameStartRec implements IRpcDecoder
	{
		public function MsgBZWGameStartRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["wBankerUser"] 		= BytesUtil.read(bytes, BytesType.WORD);
			vo["lBankerScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);
			vo["lUserMaxScore"] 	= BytesUtil.read(bytes, BytesType.LONGLONG);
			vo["cbTimeLeave"]		= BytesUtil.read(bytes, BytesType.BYTE);
			vo["nChipRobotCount"] 	= BytesUtil.read(bytes, BytesType.INT);
			
			return vo;
		}
	}
}