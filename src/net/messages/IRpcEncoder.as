package net.messages
{
	import net.socket.ByteArray;

	public interface IRpcEncoder
	{
		function makeEncodeBytes(body:Object):ByteArray;
	}
}