package net.messages.baoziwang
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**100_101  游戏状态更新*/
	public class MsgBZWGameSceneRec implements IRpcDecoder
	{
		public function MsgBZWGameSceneRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			//全局信息
			vo["cbGameStatus"] 			= BytesUtil.read(bytes, BytesType.BYTE);			//游戏状态
			vo["cbTimeLeave"]				= BytesUtil.read(bytes, BytesType.BYTE);			//剩余时间
			
			if(vo["cbGameStatus"] == 0)
			{
				//玩家信息
				vo["lUserMaxScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);		//玩家金币
				
				//庄家信息
				vo["wBankerUser"]			= BytesUtil.read(bytes, BytesType.WORD);			//当前庄家
				vo["cbBankerTime"]		= BytesUtil.read(bytes, BytesType.WORD);			//庄家局数
				vo["lBankerWinScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);		//庄家成绩
				vo["lBankerScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);		//庄家分数
				vo["bEnableSysBanker"]	= BytesUtil.read(bytes, BytesType.BOOL);			//系统做庄
				
				//控制信息
				vo["lApplyBankerCondition"]	= BytesUtil.read(bytes, BytesType.LONGLONG);	//申请条件
				vo["lAreaLimitScore"]	= BytesUtil.read(bytes, BytesType.LONGLONG);			//区域限制
				vo["szGameRoomName"]	= BytesUtil.read(bytes, BytesType.TCHAR,32);			//房间名称
			}
			else
			{
				//全局下注
				var i:int;
				var arr:Array = [];
				for(i = 0; i < 3; i++)
				{
					arr.push(BytesUtil.read(bytes, BytesType.LONGLONG));
				}
				vo["arlAreaInAllScore"]	= arr;													//每个区域的总分
				
				//个人下注
				arr = [];
				for(i = 0; i < 3; i++)
				{
					arr.push(BytesUtil.read(bytes, BytesType.LONGLONG));
				}
				vo["arlUserInAllScore"]	= arr;													//每个玩家每个区域的下注
				
				
				
				//玩家积分
				vo["lUserMaxScore"]	= BytesUtil.read(bytes, BytesType.LONGLONG);			//最大下注
				
				//控制信息
				vo["lApplyBankerCondition"]	= BytesUtil.read(bytes, BytesType.LONGLONG);	//申请条件
				vo["lAreaLimitScore"]			= BytesUtil.read(bytes, BytesType.LONGLONG);	//区域限制
				
				//骰子信息
				arr = [];
				for(i = 0; i < 3; i++)
				{
					arr.push(BytesUtil.read(bytes, BytesType.BYTE));							//骰子信息
				}
				vo["arcbDice"]	= arr;
				
				//庄家信息
				vo["wBankerUser"]			= BytesUtil.read(bytes, BytesType.WORD);			//当前庄家
				vo["cbBankerTime"]		= BytesUtil.read(bytes, BytesType.WORD);			//庄家局数
				vo["lBankerWinScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);		//庄家赢分
				vo["lBankerScore"]		= BytesUtil.read(bytes, BytesType.LONGLONG);		//庄家分数
				vo["bEnableSysBanker"]	= BytesUtil.read(bytes, BytesType.BOOL);			//系统做庄
				
				//结束信息
				vo["lEndBankerScore"]			= BytesUtil.read(bytes, BytesType.LONGLONG);	//庄家成绩
				vo["lEndUserScore"]			= BytesUtil.read(bytes, BytesType.LONGLONG);	//玩家成绩
				vo["lEndUserReturnScore"]	= BytesUtil.read(bytes, BytesType.LONGLONG);	//返回积分
				vo["lEndRevenue"]				= BytesUtil.read(bytes, BytesType.LONGLONG);	//游戏税收
				
				vo["szGameRoomName"]	= BytesUtil.read(bytes, BytesType.TCHAR,32);			//房间名称
			}
			
			return vo;
		}
	}
}