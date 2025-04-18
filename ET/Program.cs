using System;
using System.Windows.Forms;

namespace ET
{
    internal static class Program
    {
        [STAThread]
        static void Main(string[] args)
        {

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1(args));

        }
    }
}
