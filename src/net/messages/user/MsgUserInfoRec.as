package net.messages.user
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**23_100 用户数据*/
	public class MsgUserInfoRec implements IRpcDecoder
	{
		public function MsgUserInfoRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//基本属性
			vo["dwUserID"]				= BytesUtil.read(bytes, BytesType.DWORD);			//用户 I D
			vo["dwGameID"]				= BytesUtil.read(bytes, BytesType.DWORD);			//游戏 I D
			vo["dwGroupID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//社团 I D
			vo["szNickName"]			= BytesUtil.read(bytes, BytesType.CHAR,32);			//用户昵称
			vo["szGroupName"]			= BytesUtil.read(bytes, BytesType.CHAR,32);			//社团名字
			vo["szUnderWrite"]		= BytesUtil.read(bytes, BytesType.CHAR,32);			//个性签名
			
			//头像信息
			vo["wFaceID"]				= BytesUtil.read(bytes, BytesType.WORD);			//头像索引
			vo["dwCustomID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//自定标识
			
			//用户属性
			vo["cbGender"]				= BytesUtil.read(bytes, BytesType.BYTE);			//用户性别
			vo["cbMemberOrder"]		= BytesUtil.read(bytes, BytesType.BYTE);			//会员等级
			vo["cbMasterOrder"]		= BytesUtil.read(bytes, BytesType.BYTE);			//管理等级
			
			//用户状态
			vo["wTableID"]				= BytesUtil.read(bytes, BytesType.WORD);			//桌子索引
			vo["wChairID"]				= BytesUtil.read(bytes, BytesType.WORD);			//椅子索引
			vo["cbUserStatus"]		= BytesUtil.read(bytes, BytesType.BYTE);			//用户状态
			
			//积分信息
			vo["lScore"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户分数
			vo["lGrade"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户成绩
			vo["lInsure"]				= BytesUtil.read(bytes, BytesType.SCORE);			//用户银行
			vo["lSelfOption"]			= BytesUtil.read(bytes, BytesType.SCORE);			//用户自定义选项
			vo["lTodayRecord"]		= BytesUtil.read(bytes, BytesType.SCORE);			//今日输赢
			
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