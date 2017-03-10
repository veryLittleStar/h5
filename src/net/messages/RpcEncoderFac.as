package net.messages
{
	import laya.utils.Dictionary;
	
	import net.messages.bank.MsgBankInsureInfoReq;
	import net.messages.bank.MsgBankPwdChangeReq;
	import net.messages.bank.MsgBankSaveScoreReq;
	import net.messages.bank.MsgBankTakeScoreReq;
	import net.messages.bank.MsgBankTransferGameReq;
	import net.messages.bank.MsgBankTransferScoreReq;
	import net.messages.baoziwang.MsgBZWAllInJetionReq;
	import net.messages.baoziwang.MsgBZWApplyBankerReq;
	import net.messages.baoziwang.MsgBZWCancelBankerReq;
	import net.messages.baoziwang.MsgBZWGameOptionReq;
	import net.messages.baoziwang.MsgBZWPlaceJetionReq;
	import net.messages.baoziwang.MsgBZWSelfOptionChangeReq;
	import net.messages.gameLogin.MsgRoomLoginReq;
	import net.messages.serverLogin.MsgHeartBeatReq;
	import net.messages.serverLogin.MsgLoginReq;
	import net.messages.serverLogin.MsgLoginThirdPartReq;
	import net.messages.user.MsgUserSitDownReq;
	import net.messages.user.MsgUserStandUpReq;
	import net.socket.ByteArray;
	
	public class RpcEncoderFac
	{
		/**保存注册的message*/
		private var _encodeMessageDict:Dictionary = null;
		
		private static var _ins:RpcEncoderFac;
		public static function getInstance():RpcEncoderFac
		{
			if(!_ins)
			{
				_ins = new RpcEncoderFac();
			}
			return _ins;
		}
		
		public function RpcEncoderFac()
		{
			if (_ins)
			{
				throw new Error("RpcEncoderFac is a singleton");
			}
			_encodeMessageDict = new Dictionary();
			init();
		}
		
		public function registerEncoder(cmd:String, encoder:Class):void
		{
			if (!_encodeMessageDict[cmd])
			{
				_encodeMessageDict[cmd] = encoder;
			}
			else
			{
				throw new Error("通信包注册冲突，包头：" + cmd + " 类：" + encoder)
			}
		}
		
		/**
		 *object转换成byteArray并返回
		 * @param heander
		 * @param body
		 * @return 
		 * f
		 */		
		public function getEncodeData(header:String,body:Object):ByteArray
		{
			var ret:ByteArray = null;
			var cls:Class = _encodeMessageDict[header];
			
			if (cls)
			{
				var command:IRpcEncoder = new cls() as IRpcEncoder;
				
				ret = command.makeEncodeBytes(body);
			}
			return ret;
		}
		
		/**
		 *初始化 注册
		 * 
		 */		
		private function init():void
		{
			_encodeMessageDict["0_1"] =  MsgHeartBeatReq;
			
			_encodeMessageDict["1_2"] =  MsgLoginReq;
			_encodeMessageDict["1_4"] =  MsgLoginThirdPartReq;
			_encodeMessageDict["21_1"] =  MsgRoomLoginReq;
			
			//
			_encodeMessageDict["23_3"] =  MsgUserSitDownReq;
			_encodeMessageDict["23_4"] =  MsgUserStandUpReq;
			
			_encodeMessageDict["100_1"] =  MsgBZWGameOptionReq;
			_encodeMessageDict["200_1"] =  MsgBZWPlaceJetionReq;
			_encodeMessageDict["200_2"] =  MsgBZWApplyBankerReq;
			_encodeMessageDict["200_3"] =  MsgBZWCancelBankerReq;
			_encodeMessageDict["200_5"] =  MsgBZWAllInJetionReq;
			_encodeMessageDict["200_6"] =  MsgBZWSelfOptionChangeReq;
			
			_encodeMessageDict["100_10"] =  MsgUserChatReq;
			
			_encodeMessageDict["25_1"] =  MsgBankInsureInfoReq;
			_encodeMessageDict["25_2"] =  MsgBankSaveScoreReq;
			_encodeMessageDict["25_3"] =  MsgBankTakeScoreReq;
			_encodeMessageDict["25_4"] =  MsgBankTransferScoreReq;
			_encodeMessageDict["25_6"] =  MsgBankPwdChangeReq;
			_encodeMessageDict["25_7"] =  MsgBankTransferGameReq;
		}
		
	}
}