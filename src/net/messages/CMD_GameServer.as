package net.messages
{
	import net.socket.BytesType;

	public class CMD_GameServer
	{
		//////////////////////////////////////////////////////////////////////////////
		public static const GS_MGS_BEGIN:int = 				20;
		
		public static const MDM_GR_LOGON:int = 				GS_MGS_BEGIN + 1;					//登录信息
		
		//登录模式
		public static const SUB_GR_LOGON_USERID:int =			1;									//I D 登录
		public static const SUB_GR_LOGON_ACCOUNTS:int =		2;									//帐户登录
		public static const SUB_GR_LOGON_MOBILE:int =			3;									//手机登录
		
		//登录结果
		public static const SUB_GR_LOGON_SUCCESS:int =		100;								//登录成功
		public static const SUB_GR_LOGON_FAILURE:int =		101;								//登录失败
		public static const SUB_GR_LOGON_FINISH:int =			102;								//登录完成
		
		//升级提示
		public static const SUB_GR_UPDATE_NOTIFY:int =		200;								//升级提示
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//I D 登录
//		public static const CMD_GR_LogonUserID:Object =
//		{
//			//版本信息
//			dwPlazaVersion:				[BytesType.DWORD],						//广场版本
//			DWORD							dwFrameVersion;						//框架版本
//			DWORD							dwProcessVersion;					//进程版本
//			//登录信息
//			dwUserID:					[BytesType.DWORD],						//用户 I D
//			szPassword:					[BytesType.TCHAR,33],					//登录密码
//			szMachineID:				[BytesType.TCHAR,33],					//机器序列
//			wKindID:					[BytesType.WORD]						//类型索引
//		};
		
//		//手机登录
//		struct CMD_GR_LogonMobile
//		{
//			//版本信息
//			WORD							wGameID;							//游戏标识
//			DWORD							dwProcessVersion;					//进程版本
//			
//			//桌子区域
//			BYTE                            cbDeviceType;                       //设备类型
//			WORD                            wBehaviorFlags;                     //行为标识
//			WORD                            wPageTableCount;                    //分页桌数
//			
//			//登录信息
//			DWORD							dwUserID;							//用户 I D
//			TCHAR							szPassword[LEN_MD5];				//登录密码
//			TCHAR							szMachineID[LEN_MACHINE_ID];		//机器标识
//		};
//		
//		//帐号登录
//		struct CMD_GR_LogonAccounts
//		{
//			//版本信息
//			// 	DWORD							dwPlazaVersion;						//广场版本
//			// 	DWORD							dwFrameVersion;						//框架版本
//			// 	DWORD							dwProcessVersion;					//进程版本
//			
//			//登录信息
//			TCHAR							szPassword[LEN_MD5];				//登录密码
//			TCHAR							szAccounts[LEN_ACCOUNTS];			//登录帐号
//			TCHAR							szMachineID[LEN_MACHINE_ID];		//机器序列
//		};
//		
//		//登录成功
//		struct CMD_GR_LogonSuccess
//		{
//			DWORD							dwUserRight;						//用户权限
//			DWORD							dwMasterRight;						//管理权限
//		};
//		
//		//登录失败
//		struct CMD_GR_LogonFailure
//		{
//			LONG							lErrorCode;							//错误代码
//			TCHAR							szDescribeString[128];				//描述消息
//		};
//		
//		//升级提示
//		struct CMD_GR_UpdateNotify
//		{
//			//升级标志
//			BYTE							cbMustUpdatePlaza;					//强行升级
//			BYTE							cbMustUpdateClient;					//强行升级
//			BYTE							cbAdviceUpdateClient;				//建议升级
//			
//			//当前版本
//			DWORD							dwCurrentPlazaVersion;				//当前版本
//			DWORD							dwCurrentFrameVersion;				//当前版本
//			DWORD							dwCurrentClientVersion;				//当前版本
//		};
		
		//////////////////////////////////////////////////////////////////////////////////
		
		
		public function CMD_GameServer()
		{
		}
	}
}