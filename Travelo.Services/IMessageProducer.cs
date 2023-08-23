using System;
namespace Travelo.Services
{
	public interface IMessageProducer
	{
		public void SendingMessage(string message);
	}
}

