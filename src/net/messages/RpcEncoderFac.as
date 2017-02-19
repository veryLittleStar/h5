package net.messages
{
	import laya.utils.Dictionary;
	
	import net.messages.gameLogin.MsgRoomLoginReq;
	import net.messages.login.MsgLoginReq;
	import net.messages.user.MsgUserSitDownReq;
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
			_encodeMessageDict["1_2"] =  MsgLoginReq;
			_encodeMessageDict["21_1"] =  MsgRoomLoginReq;
			
			//
			_encodeMessageDict["23_3"] =  MsgUserSitDownReq;
		}
		
	}
}