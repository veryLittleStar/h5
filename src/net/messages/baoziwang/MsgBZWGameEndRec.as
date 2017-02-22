package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**200_102 豹子王 游戏一轮结束*/
	public class MsgBZWGameEndRec implements IRpcDecoder
	{
		public function MsgBZWGameEndRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//下局信息
			vo["cbTimeLeave"] 		= BytesUtil.read(bytes, BytesType.BYTE);	//剩余时间
			
			//扑克信息
			var i:int;
			var arr:Array = [];
			for(i = 0; i < 3; i++)
			{
				arr.push(BytesUtil.read(bytes, BytesType.BYTE));
			}
			vo["arcbDice"]	= arr;													//每个区域的总分
			
			//庄家信息
			vo["lBankerScore"] 		= BytesUtil.read(bytes, BytesType.LONGLONG);	//庄家成绩
			vo["lBankerTotallScore"] 	= BytesUtil.read(bytes, BytesType.LONGLONG);	//庄家成绩
			vo["nBankerTime"] 			= BytesUtil.read(bytes, BytesType.INT);			//做庄次数
			
			//玩家成绩
			vo["lUserScore"] 			= BytesUtil.read(bytes, BytesType.LONGLONG);	//玩家成绩
			vo["lUserReturnScore"] 	= BytesUtil.read(bytes, BytesType.LONGLONG);	//返回积分
			
			//全局信息
			vo["lRevenue"] 			= BytesUtil.read(bytes, BytesType.LONGLONG);	//游戏税收
			
			return vo;
		}
	}
}