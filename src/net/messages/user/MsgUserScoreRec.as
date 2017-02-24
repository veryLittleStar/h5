package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**23_101 用户分数*/
	public class MsgUserScoreRec implements IRpcDecoder
	{
		public function MsgUserScoreRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//基本属性
			vo["dwUserID"]				= BytesUtil.read(bytes, BytesType.DWORD);			//用户 I D
			
			//积分信息
			vo["lScore"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户分数
			vo["lGrade"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户成绩
			vo["lInsure"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户银行
			
			//游戏信息
			vo["dwWinCount"]				= BytesUtil.read(bytes, BytesType.DWORD);		//胜利盘数
			vo["dwLostCount"]				= BytesUtil.read(bytes, BytesType.DWORD);		//失败盘数
			vo["dwDrawCount"]				= BytesUtil.read(bytes, BytesType.DWORD);		//和局盘数
			vo["dwFleeCount"]				= BytesUtil.read(bytes, BytesType.DWORD);		//逃跑盘数
			
			vo["dwUserMedal"]				= BytesUtil.read(bytes, BytesType.DWORD);		//用户奖牌
			vo["dwExperience"]			= BytesUtil.read(bytes, BytesType.DWORD);		//用户经验
			vo["lLoveLiness"]				= BytesUtil.read(bytes, BytesType.LONG);		//用户魅力
			
			return vo;
		}
	}
}