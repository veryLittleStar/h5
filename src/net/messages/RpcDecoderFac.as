package net.messages
{
	import laya.utils.Dictionary;
	
	import net.messages.IRpcDecoder;
	import net.messages.baoziwang.MsgBZWApplyBankerRec;
	import net.messages.baoziwang.MsgBZWCancelBankerRec;
	import net.messages.baoziwang.MsgBZWChangeBankerRec;
	import net.messages.baoziwang.MsgBZWGameEndRec;
	import net.messages.baoziwang.MsgBZWGameFreeRec;
	import net.messages.baoziwang.MsgBZWGameRecordRec;
	import net.messages.baoziwang.MsgBZWGameSceneRec;
	import net.messages.baoziwang.MsgBZWGameStartRec;
	import net.messages.baoziwang.MsgBZWPlaceJetionFailRec;
	import net.messages.baoziwang.MsgBZWPlaceJetionRec;
	import net.messages.gameLogin.MsgRoomLoginFailureRec;
	import net.messages.gameLogin.MsgRoomLoginFinishRec;
	import net.messages.gameLogin.MsgRoomLoginSucessRec;
	import net.messages.serverLogin.MsgGameListRec;
	import net.messages.serverLogin.MsgHeartBeatRec;
	import net.messages.serverLogin.MsgLoginFailureRec;
	import net.messages.serverLogin.MsgLoginFinishRec;
	import net.messages.serverLogin.MsgLoginSuccessRec;
	import net.messages.serverLogin.MsgRoomListRec;
	import net.messages.status.MsgTableStatusRec;
	import net.messages.user.MsgSystemMessageRec;
	import net.messages.user.MsgUserInfoRec;
	import net.messages.user.MsgUserScoreRec;
	import net.messages.user.MsgUserStatusRec;
	import net.socket.ByteArray;

	public class RpcDecoderFac
	{
		/**保存注册的command */		
		private var _decodeMessageDict:Dictionary = null;
		private static var _ins:RpcDecoderFac;
		public static function getInstance():RpcDecoderFac
		{
			if(!_ins)
			{
				_ins = new RpcDecoderFac();
			}
			return _ins;
		}
		
		public function RpcDecoderFac()
		{
			if (_ins)
			{
				throw new Error("RpcDecoderFac is a singleton");
			}
			_decodeMessageDict = new Dictionary();
			init();
		}
		
		public function registerDecoder(header:String, decoder:Class):void
		{
			if (!_decodeMessageDict[header])
			{
				_decodeMessageDict[header] = decoder;
			}
			else
			{
				throw new Error("通信包注册冲突，包头：" + header + " 类：" + decoder)
			}
		}
		/**
		 *byteArray转换成object并返回
		 * @param name
		 * @param byteArray
		 * @return 
		 * 
		 */		
		public function getDecodeData(header:String, byteArray:ByteArray):Object
		{
			var ret:Object = null;
			var cls:Class = _decodeMessageDict[header];
			
			if (cls)
			{
				var command:IRpcDecoder = new cls() as IRpcDecoder;
				
				ret = command.makeDecodeBytes(byteArray);
			}
			return ret;
		}
		
		/**
		 *初始化 注册
		 * 
		 */		
		private function init():void
		{
			_decodeMessageDict["0_1"] =  MsgHeartBeatRec;
			//login
			_decodeMessageDict["1_100"] =  MsgLoginSuccessRec;
			_decodeMessageDict["1_101"] =  MsgLoginFailureRec;
			_decodeMessageDict["1_102"] =  MsgLoginFinishRec;
			_decodeMessageDict["2_101"] =  MsgGameListRec;
			_decodeMessageDict["2_104"] =  MsgRoomListRec;
			
			//gameLoin
			_decodeMessageDict["21_100"] =  MsgRoomLoginSucessRec;
			_decodeMessageDict["21_101"] =  MsgRoomLoginFailureRec;
			_decodeMessageDict["21_102"] =  MsgRoomLoginFinishRec;
			
			//user
			_decodeMessageDict["23_100"] =  MsgUserInfoRec;
			_decodeMessageDict["24_100"] =  MsgTableStatusRec;
			_decodeMessageDict["23_101"] =  MsgUserScoreRec;
			_decodeMessageDict["23_102"] =  MsgUserStatusRec;
			
			//baoziwang
			_decodeMessageDict["200_99"] 	= MsgBZWGameFreeRec
			_decodeMessageDict["200_100"] 	= MsgBZWGameStartRec;
			_decodeMessageDict["200_102"] 	= MsgBZWGameEndRec;
			_decodeMessageDict["200_106"] 	= MsgBZWGameRecordRec;
			_decodeMessageDict["200_101"] 	= MsgBZWPlaceJetionRec;
			_decodeMessageDict["200_103"] 	= MsgBZWApplyBankerRec;
			_decodeMessageDict["200_104"] 	= MsgBZWChangeBankerRec;
			_decodeMessageDict["200_107"] 	= MsgBZWPlaceJetionFailRec;
			_decodeMessageDict["200_108"] 	= MsgBZWCancelBankerRec;
			_decodeMessageDict["100_101"] 	= MsgBZWGameSceneRec;
			
			_decodeMessageDict["100_200"] 	= MsgSystemMessageRec;
		}
		
	}
}