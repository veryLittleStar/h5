package net.messages.bank
{
	import net.messages.IRpcDecoder;
	import net.socket.ByteArray;
	import net.socket.BytesType;
	import net.socket.BytesUtil;

	/**25_100 银行资料查询返回*/
	public class MsgBankInsreInfoRec implements IRpcDecoder
	{
		public function MsgBankInsreInfoRec()
		{
		}
		
		public function makeDecodeBytes(byteArray:ByteArray):Object
		{
			var vo:Object = {};
			var bytes:ByteArray = ByteArray(byteArray);
			
			vo["cbActivityGame"] 			= BytesUtil.read(bytes, BytesType.BYTE);		//游戏动作
			vo["wRevenueTake"] 			= BytesUtil.read(bytes, BytesType.WORD);		//税收比例
			vo["wRevenueTransfer"] 		= BytesUtil.read(bytes, BytesType.WORD);		//转账税收比例
			vo["wServerID"] 				= BytesUtil.read(bytes, BytesType.WORD);		//房间标识
			vo["lUserScore"] 				= BytesUtil.read(bytes, BytesType.SCORE);		//用户金币
			vo["lUserInsure"] 				= BytesUtil.read(bytes, BytesType.SCORE);		//银行金币
			vo["lTransferPrerequisite"] 	= BytesUtil.read(bytes, BytesType.SCORE);		//转账条件
			
			
			return vo;
		}
	}
}