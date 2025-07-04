using System;
using System.Linq;
using System.Windows.Forms;

namespace ET
{
    internal static class Program
    {
        [STAThread]
        static void Main(string[] aargs)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            string[] argsToPass = (aargs != null && aargs.Length > 0) ? aargs : new string[0];
            Application.Run(new Form1(argsToPass));

        }
    }
}
