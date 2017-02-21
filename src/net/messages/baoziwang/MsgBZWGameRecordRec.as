package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**200_106 游戏记录*/
	public class MsgBZWGameRecordRec implements IRpcDecoder
	{
		public function MsgBZWGameRecordRec()
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
				obj["cbResult"] 	= BytesUtil.read(bytes, BytesType.BYTE);
				obj["cbDice0"]		= BytesUtil.read(bytes, BytesType.BYTE);
				obj["cbDice1"]		= BytesUtil.read(bytes, BytesType.BYTE);
				obj["cbDice2"]		= BytesUtil.read(bytes, BytesType.BYTE);
				arr.push(obj);
			}
			vo["arRecord"] = arr;
			
			return vo;
		}
	}
}