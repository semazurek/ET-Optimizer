﻿using System;
using System.Linq;
using System.Windows.Forms;

namespace ET
{
    internal static class Program
    {
        [STAThread]
        static void Main(string[] aargs)
        {
            //Code of implementing .dll inside .exe
            AppDomain.CurrentDomain.AssemblyResolve += (sender, args) =>
            {
                var assemblyName = new System.Reflection.AssemblyName(args.Name).Name + ".dll";
                var resourceName = typeof(Program).Assembly.GetManifestResourceNames()
                    .FirstOrDefault(r => r.EndsWith(assemblyName));

                if (resourceName == null)
                    return null;

                using (var stream = typeof(Program).Assembly.GetManifestResourceStream(resourceName))
                {
                    if (stream == null) return null;

                    byte[] assemblyData = new byte[stream.Length];
                    stream.Read(assemblyData, 0, assemblyData.Length);
                    return System.Reflection.Assembly.Load(assemblyData);
                }
            };


            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1(aargs));

        }
    }
}
