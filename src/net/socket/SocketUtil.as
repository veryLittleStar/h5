package net.socket
{
	public class SocketUtil
	{
		static private var buffer:ByteArray = new ByteArray();

		/**
		 * 对INT进行高低位转换
		 * 代替 IDataInput 接口的 readInt方法
		 * IDataInput接口用于提供一组读取2进制数据的方法
		 * @param source 读取的位置
		 * @return 
		 * 
		 */
		static public  function readInt(source : ByteArray) : int
		{
			buffer.clear();
			var v1 : int = source.readByte();
			var v2 : int = source.readByte();
			var v3 : int = source.readByte();
			var v4 : int = source.readByte();
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position = 0;
			return buffer.readInt();
		}

		/**
		 * 对INT进行高低位转换
		 * 代替IDataOutput的writeInt方法
		 * @param value
		 * @param destination
		 * 
		 */
		static public  function writeInt(value : int,destination : ByteArray) : void
		{
			buffer.clear();
			buffer.position = 0;
			buffer.writeInt(value);
			destination.writeByte(buffer._byteView_[3]);
			destination.writeByte(buffer._byteView_[2]);	
			destination.writeByte(buffer._byteView_[1]);
			destination.writeByte(buffer._byteView_[0]);
		}
		/**
		 * 对UINT进行高低位转换
		 * 代替 IDataInput 接口的 readUsignedInt方法
		 * IDataInput接口用于提供一组读取2进制数据的方法
		 * @param source 读取的位置
		 * @return 
		 * 
		 */
		static public  function readUInt(source : ByteArray) : uint
		{
			buffer.clear();
			var v1 : int = source.readByte();
			var v2 : int = source.readByte();
			var v3 : int = source.readByte();
			var v4 : int = source.readByte();
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position= 0;
			return buffer.readUnsignedInt();
		}

		/**
		 * 对UINT进行高低位转换
		 * 代替IDataOutput的writeUnsignedInt方法
		 * @param value
		 * @param destination
		 * 
		 */
		static public  function writeUInt(value : uint,destination : ByteArray) : void
		{
			buffer.clear();
			buffer.writeUnsignedInt(value);
			destination.writeByte(buffer._byteView_[3]);
			destination.writeByte(buffer._byteView_[2]);	
			destination.writeByte(buffer._byteView_[1]);
			destination.writeByte(buffer._byteView_[0]);
		}
		
		/**
		 * 对INT64进行高低位转换
		 * @param source
		 * @return 
		 * 
		 */
		static public  function readInt64(source : ByteArray) : Number
		{
			buffer.clear();
			var v1 : int = source.readByte();
			var v2 : int = source.readByte();
			var v3 : int = source.readByte();
			var v4 : int = source.readByte();
			var v5 : int = source.readByte();
			var v6 : int = source.readByte();
			var v7 : int = source.readByte();
			var v8 : int = source.readByte();
			
			buffer.writeByte(v8);
			buffer.writeByte(v7);
			buffer.writeByte(v6);
			buffer.writeByte(v5);
			buffer.writeByte(v4);
			buffer.writeByte(v3);
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position= 0;
			
			if ((v8 & 0x80) != 0)
			{
				v1=~v1;
				v2=~v2;
				v3=~v3;
				v4=~v4;
				v5=~v5;
				v6=~v6;
				v7=~v7;
				
				v1 += 1;
				if (v1 > 0xff)
				{
					v2 += 1;
					if (v2 > 0xff)
					{
						v3 += 1;
						if (v3 > 0xff)
						{
							v4 += 1;
							if (v4 > 0xff)
							{
								v5 += 1;
								if (v5 > 0xff)
								{
									v6 += 1;
									if (v6 > 0xff)
									{
										v7 += 1;
									}
								}
							}
						}
					}
				}
			}
			
			v1=v1&0x000000ff;
			v2=v2&0x000000ff;
			v3=v3&0x000000ff;
			v4=v4&0x000000ff;
			v5=v5&0x000000ff;
			v6=v6&0x000000ff;
			v7=v7&0x000000ff;
			
			var v1r2: Number = v1;
			var v2r2: Number = v2;
			var v3r2: Number = v3;
			var v4r2: Number = v4;
			var v5r2: Number = v5;
			var v6r2: Number = v6;
			var v7r2: Number = v7;
			var reInt64:Number=0;
			
			reInt64=v7r2*281474976710656+v6r2*1099511627776+v5r2*4294967296+v4r2*16777216+v3r2*65536+v2r2*256+v1r2;
			if ((v8 & 0x80) != 0)
			{
				reInt64 = -reInt64;
			}
			
			return reInt64;
		}
		
		/**A7F8000000D6F6
		 * 
		 * 对INT64进行高地位转换 
		 * @param value
		 * @param destination
		 * 47278999994423035
		 * 47278999994423030
		 * 10000009C40
		 * 40 9c 00 00 00
		 */
		static public  function writeInt64(value : Number,destination : ByteArray) : void
		{
			//待验证
			var v1: Number = Math.floor(value) &0x000000ff ;
			var v2: Number = Math.floor(value/256)&0x000000ff;
			var v3: Number = Math.floor(value/65536)&0x000000ff;
			var v4: Number = Math.floor(value/16777216)&0x000000ff;
			var v5: Number = Math.floor(value/4294967296)&0x000000ff;
			var v6: Number = Math.floor(value/1099511627776)&0x000000ff;
			var v7: Number = Math.floor(value/281474976710656)&0x000000ff;
			var v8: Number = 0;
			
			destination.writeByte(v1);
			destination.writeByte(v2);
			destination.writeByte(v3);
			destination.writeByte(v4);
			destination.writeByte(v5);
			destination.writeByte(v6);
			destination.writeByte(v7);
			destination.writeByte(v8);
		}
		
		/**
		 * 对Short进行高低位转换
		 */
		static public  function readShort(source : ByteArray) : int
		{
			buffer.clear();
			var v1 : int = source.readByte();
			var v2 : int = source.readByte();
			buffer.writeByte(v2);
			buffer.writeByte(v1);
			buffer.position= 0;
			return buffer.readShort();
		}

		/**
		 * 对Short进行高低位转换
		 */
		static public  function writeShort(value : int , destination : ByteArray) : void
		{
			buffer.clear();
			buffer.writeShort(value);
			buffer.position= 0 ;
			destination.writeByte(buffer._byteView_[1]);
			destination.writeByte(buffer._byteView_[0]);
		}

		/**
		 * Byte解码
//		 */
//		static public function decode(ba : ByteArray, dest : ISocketStruct) : void
//		{
//			ba.position= 0;
//			var nsize : int = ba.length;
//			var data : Object = dest.data;
//			var props : Array = dest.propersarr;
//			var bufsizes : Array = dest.bufsizearr;
//			var typeofsarr : Array = dest.typeofsarr;
//			for(var i : int = 0;i < props.length; i++)
//			{
//				switch(String(typeofsarr[i]))
//				{
//					case "char":
//						if(parseInt(bufsizes[i]) > 0)
//						{
//							data[props[i]] = ba.readMultiByte(bufsizes[i], "GB2312");
//							nsize -= bufsizes[i];
//						}
//						else
//						{
//							data[props[i]] = ba.readMultiByte(nsize, "GB2312");
//						}
//						break;
//					case "int":
//						data[props[i]] = readInt(ba);
//						nsize -= 4;
//						break;
//					case "short":
//						data[props[i]] = readShort(ba);
//						nsize -= 2;
//						break;
//					case "byte":
//						data[props[i]] = ba.readByte();
//						nsize -= 1;
//						break;
//					case "bool":
//						data[props[i]] = ba.readBoolean();
//						nsize -= 1;
//						break;
//				}
//			}
//		}
//
//		/**
//		 * Byte重编码
//		 */
//		static public function encode(source : ISocketStruct) : ByteArray
//		{
//			var ba : ByteArray = new ByteArray();
//			var nsize : int = ba.position
//			var data : Object = source.data;
//			var props : Array = source.propersarr;
//			var bufsizes : Array = source.bufsizearr;
//			var typeofsarr : Array = source.typeofsarr;
//			for(var i : int = 0;i < props.length; i++)
//			{
//				ba.position= nsize;
//				switch(String(typeofsarr[i]))
//				{
//					case "char":
//						ba.writeMultiByte(String(data[props[i]]), "GB2312");
//						if(parseInt(bufsizes[i]) > 0)
//						{
//							nsize += bufsizes[i];
//						}
//						break;
//					case "int":
//						writeInt(parseInt(data[props[i]]), ba);
//						nsize += 4;
//						break;
//					case "short":
//						writeShort(parseInt(data[props[i]]), ba);
//						nsize += 2;
//						break;
//					case "byte":
//						ba.writeByte(parseInt(data[props[i]]));
//						nsize += 1;
//						break;
//					case "bool":
//						ba.writeBoolean(Boolean(data[props[i]]));
//						nsize += 1;
//						break;
//				}
//			}
//			return ba;
//		}
	}
}