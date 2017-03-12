package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_104 排行榜数据*/
	public class MsgUserRankListRec implements IRpcDecoder
	{
		public function MsgUserRankListRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["cType"]				= BytesUtil.read(bytes, BytesType.BYTE);			//排行榜类型 0赢钱  1输钱
			
			
			var arr:Array = [];
			var i:int;
			for(i = 0; i < 15; i++)
			{
				var obj:Object = {};
				obj["wFaceID"]				= BytesUtil.read(bytes, BytesType.WORD);			//头像id
				obj["cbGender"]			= BytesUtil.read(bytes, BytesType.BYTE);			//性别
				obj["szNickName"]			= BytesUtil.read(bytes, BytesType.TCHAR,32);		//用户昵称
				obj["lScore"]				= BytesUtil.read(bytes, BytesType.SCORE);			//金币
				arr.push(obj);
			}
			vo["arRank"] = arr;
			
			return vo;
		}
	}
}