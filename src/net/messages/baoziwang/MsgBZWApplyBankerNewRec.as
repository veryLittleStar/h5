package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**200_111 新的申请庄家更新消息，原来的200_103废弃*/
	public class MsgBZWApplyBankerNewRec implements IRpcDecoder
	{
		public function MsgBZWApplyBankerNewRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["btCount"] 			= BytesUtil.read(bytes, BytesType.BYTE);		//申请玩家
			var i:int;
			var arr:Array = [];
			for(i = 0; i < vo.btCount; i++)
			{
				var obj:Object = SBankerDecoder(bytes);
				arr.push(obj);
			}
			vo["arApplyBanker"] = arr;
			
			return vo;
		}
		
		public static function SBankerDecoder(bytes:ByteArray):Object
		{
			var vo:Object = {};
			vo["chIsMir"] 		= BytesUtil.read(bytes, BytesType.BYTE);
			vo["szServer"] 	= BytesUtil.read(bytes, BytesType.TCHAR,16);
			vo["wChair"] 		= BytesUtil.read(bytes, BytesType.WORD);
			vo["szName"] 		= BytesUtil.read(bytes, BytesType.TCHAR,32);
			vo["nGold"] 		= BytesUtil.read(bytes, BytesType.LONGLONG);
			vo["time"] 			= BytesUtil.read(bytes, BytesType.DWORD);
			
			return vo;
		}
	}
}