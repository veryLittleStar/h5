package net.socket
{
	/**
	 * 专门存储字节类型
	 * @author Administrator
	 * 
	 */	
	public class BytesType
	{
		/**
		 * 交换数据类型 ：布尔型 
		 */
		public static const BOOL : String = 'bool';
		
		/**
		 * 交换数据类型： 字节型
		 */
		public static const BYTE : String = 'byte';
		
		public static const UBYTE:String	= "unsignedByte";
		/**
		 * 交换用数据类型：短整型 
		 */
		public static const SHORT : String = 'short';
		
		public static const WORD:String	= "word";
		
		public static const DWORD:String	= "dWord";
		
		public static const UINT:String	= "uint";
		/**
		 * 交换用数据类型：长整形 
		 */
		public static const INT : String = 'int';
		public static const LONG:String = "long";
		/**
		 * 交换用数据类型：双精度整型
		 * 相当于Number
		 */
		public static const INT64:String = 'int64';
		public static const SCORE:String = "score";
		public static const LONGLONG:String	= "longlong";
		
		/**
		 *  双精度整型int64 赚换成number
		 */		
		public static const INT64_NUMBER :String = "int64_number";
		
		/**
		 * 交换用数据类型：字串 
		 */
		public static const CHAR : String = 'char';
		public static const TCHAR:String = "tchar";
		/**自定义字符串*/
		public static const CUSTOM_CHAR:String = "customChar";
		
		/**
		 * 交换用数据类型：二进制流
		 */
		public static const BYTES : String = 'bytes';
		public static const ELONGATE_BYTES : String = 'elongate_bytes';
		
		/**
		 *  交换数据类型 ：布尔型长度
		 */		
		public static const BOOL_LENGTH:int = 1;
		
		/**
		 *  交换数据类型 ：字节型长度
		 */		
		public static const BYTE_LENGTH:int = 1;
		
		
		public static const UBYTE_LENGTH:int = 1;
		
		/**
		 *  交换数据类型 ：双精度整型长度
		 */		
		public static const INT64_LENGTH:int = 8;
		
		/**
		 *  双精度整型int64 赚换成number
		 */		
		public static const INT64_NUMBER_LENGTH:int = 8;
		
		public static const UINT_LENGTH:int	= 4;
		/**
		 *  交换数据类型 ：长整型长度
		 */		
		public static const INT_LENGTH:int = 4;
		/**
		 *公会日志长度 
		 */		
		public static const GUILD_LOG_LEN:int	= 100;
		
		/**
		 *  交换数据类型 ：短整型长度
		 */		
		public static const SHORT_LENGTH:int = 2;
		
	}
}