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
			
			vo["wFaceID"] 			= BytesUtil.read(bytes, BytesType.WORD);
			vo["dwUserID"]			= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwGameID"]			= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwGroupID"]		= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwCustomID"]		= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwUserMedal"]		= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwExperience"]	= BytesUtil.read(bytes, BytesType.DWORD);
			vo["dwLoveLiness"]	= BytesUtil.read(bytes, BytesType.DWORD);
			
			vo["lUserScore"]		= BytesUtil.read(bytes, BytesType.INT64);
			vo["lUserInsure"]		= BytesUtil.read(bytes, BytesType.INT64);
			vo["cbGender"]			= BytesUtil.read(bytes, BytesType.BYTE);
			vo["cbMoorMachine"]	= BytesUtil.read(bytes, BytesType.BYTE);
			vo["szAccounts"]		= BytesUtil.read(bytes, BytesType.CHAR,32);
			vo["szNickName"]		= BytesUtil.read(bytes, BytesType.CHAR,32);
			vo["szGroupName"]		= BytesUtil.read(bytes, BytesType.CHAR,32);
			
			vo["cbShowServerStatus"]	= BytesUtil.read(bytes, BytesType.BYTE);
			
			return vo;
		}
	}
}