package net.messages.serverLogin
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;
	/**1_100 登录服务器登录成功*/
	public class MsgLoginSuccessRec implements IRpcDecoder
	{
		public function MsgLoginSuccessRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//属性资料
			vo["wFaceID"] 			= BytesUtil.read(bytes, BytesType.WORD);			//头像标识
			vo["dwUserID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//用户 I D
			vo["dwGameID"]			= BytesUtil.read(bytes, BytesType.DWORD);			//游戏 I D
			vo["dwGroupID"]		= BytesUtil.read(bytes, BytesType.DWORD);			//社团标识
			vo["dwCustomID"]		= BytesUtil.read(bytes, BytesType.DWORD);			//自定标识
			vo["dwUserMedal"]		= BytesUtil.read(bytes, BytesType.DWORD);			//用户奖牌
			vo["dwExperience"]	= BytesUtil.read(bytes, BytesType.DWORD);			//经验数值
			vo["dwLoveLiness"]	= BytesUtil.read(bytes, BytesType.DWORD);			//用户魅力
			
			//用户成绩
			vo["lUserScore"]		= BytesUtil.read(bytes, BytesType.INT64);			//用户金币
			vo["lUserInsure"]		= BytesUtil.read(bytes, BytesType.INT64);			//用户银行
			
			//用户信息
			vo["cbGender"]			= BytesUtil.read(bytes, BytesType.BYTE);			//用户性别
			vo["cbMoorMachine"]	= BytesUtil.read(bytes, BytesType.BYTE);			//锁定机器
			vo["szAccounts"]		= BytesUtil.read(bytes, BytesType.CHAR,32);			//登录帐号
			vo["szNickName"]		= BytesUtil.read(bytes, BytesType.CHAR,32);			//用户昵称
			vo["szGroupName"]		= BytesUtil.read(bytes, BytesType.CHAR,32);			//社团名字
			
			//配置信息
			vo["cbShowServerStatus"]	= BytesUtil.read(bytes, BytesType.BYTE);		//显示服务器状态
			
			return vo;
		}
	}
}