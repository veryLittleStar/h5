package net.socket
{
	import laya.net.Socket;

	public class BytesUtil
	{
		/**
		 * 读取 
		 * @param bytes 读取数据来源
		 * @param type 需要读取的类型
		 * @param length 读取的长度
		 * @return 读取的内容值
		 * 
		 */		
		public static function read(bytes:ByteArray,type:String,length:int = 0):*
		{
			var value:*;
			var ba:ByteArray;
			try
			{
				switch(type)
				{
					case BytesType.BOOL:
						value = bytes.readBoolean();
						break;
					
					case BytesType.BYTE:
						value = bytes.readByte();
						break;
					
					case BytesType.UBYTE:
						value = bytes.readUnsignedByte();
						break;
					
					case BytesType.BYTES:
						ba = new ByteArray();
						bytes.readBytes(ba, 0, length);
						value = ba;
						break;
					
					case BytesType.CHAR:
					case BytesType.TCHAR:
						var cp:int = bytes.position;
						value = bytes.readMultiByte(length*2, "unicode");
						bytes.position = cp + length*2;
						break;
					case BytesType.CUSTOM_CHAR:
						var cl:int = bytes.readUnsignedShort();
						bytes.readUnsignedShort();
						value = read(bytes,BytesType.CHAR,cl/2);
						break;
					
					case BytesType.INT:
					case BytesType.LONG:
						value = bytes.readInt();
						break;
					
					case BytesType.UINT:
						value = bytes.readUnsignedInt();
						break;
					
					case BytesType.SHORT:
						value = bytes.readShort();
						break;
					case BytesType.WORD:
						value = bytes.readUnsignedShort();
						break;
					case BytesType.DWORD:
						value = bytes.readUnsignedInt();
						break;
					case BytesType.INT64:
					case BytesType.SCORE:
					case BytesType.LONGLONG:
						value = SocketUtil.readInt64(bytes);
						break;
				}
			}
			catch (error:*)
			{
				trace("wrong command length!!!!!!!!!!!!!!!!");
			}
			return value;
		}
		
		/**
		 * 用一个特定函数来读取一个对象 
		 * @param key 为了方便区别和识别,所使用的标识KEY
		 * @param bytes 读取目标源
		 * @param func 读取调用的编码函数
		 * @return 读取的内容值
		 * 
		 */		
		public static function readVO(key:String, bytes:ByteArray, func:Function):Object
		{
			if(func != null)
			{
				return func(bytes);
			}
			return null;
		}
		
		/**
		 * 调用一个既定函数,写入一个VO对象 
		 * @param key 为了方便区别和识别,所使用的标识KEY
		 * @param bytes 写入目标数据源
		 * @param func 写入调用的编码函数
		 * @param value 读取的内容值
		 * 
		 */		
		public static function writeVO(key:String, bytes:ByteArray, func:Function, value:Object):void
		{
			if(func != null && value != null)
			{
				bytes.writeBytes(func(value));
			}
		}
		
		/**
		 * 写入 
		 * @param bytes 写入目标数据源
		 * @param type 类型
		 * @param length 长度
		 * @param value 值
		 * 
		 */		
		public static function write(bytes:ByteArray, type:String, value:*, length:int = 0):void
		{
			switch(type)
			{
				case BytesType.BOOL:
					bytes.writeBoolean(value);
					break;
				case BytesType.UBYTE:
				case BytesType.BYTE:
					bytes.writeByte(value);
					break;
				case BytesType.BYTES:
					bytes.writeBytes(value);
					break;
				case BytesType.CHAR:
					var cp:int = bytes.position;
					if(value)
					{
						bytes.writeMultiByte(value, 'unicode');
					}
					
					if(bytes.position < cp + length*2)
					{
						bytes.position = cp + length*2 - 2;
						bytes.writeByte(0);
						bytes.writeByte(0);
					}
					break;
				case BytesType.INT:
					bytes.writeInt(value);
					break;
				case BytesType.UINT:
					SocketUtil.writeUInt(value, bytes);
					break;
				case BytesType.SHORT:
					bytes.writeShort(value);
					break;
				case BytesType.WORD:
					bytes.writeUnsignedShort(value);
					break;
				case BytesType.DWORD:
					bytes.writeUnsignedInt(value);
					break;
				case BytesType.INT64_NUMBER:
					SocketUtil.writeInt64(value,bytes);
					break;
			}
		}
		
		public static function getByteArray():ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.endian = Socket.LITTLE_ENDIAN;
			return bytes;
		}
	}
}