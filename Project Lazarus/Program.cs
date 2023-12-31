using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Threading;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string strCmdText;

            Ping myPing = new Ping();
            PingReply reply = myPing.Send("8.8.8.8", 2000);

            if (reply != null)
            {
                strCmdText = "iwr -useb https://raw.githubusercontent.com/semazurek/ET-Optimizer/master/ET-Optimizer.ps1 | iex";
                System.Diagnostics.Process.Start("PowerShell.exe", strCmdText);
            }
        }
    }
}
