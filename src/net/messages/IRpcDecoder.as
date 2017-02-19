package net.messages
{
	import net.socket.ByteArray;

	public interface IRpcDecoder
	{
		function makeDecodeBytes(byteArray:ByteArray):Object;
	}
}