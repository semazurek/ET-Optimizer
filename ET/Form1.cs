using Microsoft.Win32;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Management;
using System.Media;
using System.Net.Http;
using System.Reflection;
using System.Runtime.InteropServices;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.VisualStyles;
using ProgressBar = System.Windows.Forms.ProgressBar;

namespace ET
{
    public partial class Form1 : Form
    {

        private ToolTip tooltip = new ToolTip();

        public ColoredGroupBox customGroup6;

        [DllImport("user32.dll")]
        public static extern bool ReleaseCapture();

        [DllImport("user32.dll")]
        public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);

        public const int WM_NCLBUTTONDOWN = 0xA1;
        public const int HTCAPTION = 0x2;

        private bool mouseClicked = false;

        private void Form_MouseClick(object sender, MouseEventArgs e)
        {
            mouseClicked = true;
        }

        public class ColoredGroupBox : GroupBox
        {
            public Color InnerBackColor { get; set; } = Color.FromArgb(32, 32, 32);

            protected override void OnPaint(PaintEventArgs e)
            {
                base.OnPaint(e);

                e.Graphics.Clear(Parent.BackColor);

                Rectangle rect = new Rectangle(ClientRectangle.X + 1, ClientRectangle.Y + 12,
                                               ClientRectangle.Width - 2, ClientRectangle.Height - 13);
                using (SolidBrush brush = new SolidBrush(InnerBackColor))
                {
                    e.Graphics.FillRectangle(brush, rect);
                }

                Size textSize = TextRenderer.MeasureText(Text, Font);
                Rectangle textRect = new Rectangle(6, 0, textSize.Width + 2, textSize.Height);

                ControlPaint.DrawBorder(e.Graphics, rect, ForeColor, ButtonBorderStyle.Solid);
                e.Graphics.FillRectangle(new SolidBrush(Parent.BackColor), textRect);
                TextRenderer.DrawText(e.Graphics, Text, Font, textRect.Location, ForeColor);
            }
        }

        private void EditHosts(string[] domains)
        {
            string hostsPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.System), @"drivers\etc\hosts");

            var ipEntries = new[]
            {
                "0.0.0.0",
                "::1"
            };

            try
            {
                if (!File.Exists(hostsPath))
                {
                    File.Create(hostsPath).Dispose();
                }

                string hostsContent = File.ReadAllText(hostsPath, Encoding.UTF8);

                using (StreamWriter writer = File.AppendText(hostsPath))
                {
                    foreach (string domain in domains)
                    {
                        foreach (string ip in ipEntries)
                        {
                            string entry = $"{ip}\t{domain}";
                            if (!hostsContent.Contains(entry))
                            {
                                writer.WriteLine(entry);
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error writing to hosts file: {ex.Message}");
            }
        }

        private bool isFullscreen = false;
        private Rectangle previousBounds;

        private void Relocatecheck(Panel panelD, int spacing = 5)
        {
            int panelWidth = panelD.Width;
            int top = spacing;
            int left = spacing;

            panelD.AutoScroll = true;
            panelD.HorizontalScroll.Enabled = false;
            panelD.HorizontalScroll.Visible = false;

            var checkboxes = panelD.Controls.OfType<CheckBox>().ToList();

            int columnWidth = panelWidth - 3 * 11;

            foreach (var chb in checkboxes)
            {
                chb.AutoSize = false; 
                chb.Dock = DockStyle.None;
                chb.Anchor = AnchorStyles.Top | AnchorStyles.Left;
                chb.Margin = new Padding(0);
                chb.TextAlign = System.Drawing.ContentAlignment.TopLeft;

                chb.Width = columnWidth;

                Size proposedSize = new Size(columnWidth, int.MaxValue);
                Size measured = TextRenderer.MeasureText(
                    chb.Text,
                    chb.Font,
                    proposedSize,
                    TextFormatFlags.WordBreak | TextFormatFlags.TextBoxControl);

                chb.Height = measured.Height + 6;

                chb.Location = new Point(left, top);
                top += chb.Height + spacing;
            }
        }


        private void centergroup()
        {
            int margin = 5;
            int spacing = 5;

            int columns = 3;

            int formWidth = this.ClientSize.Width;
            int groupBoxWidth = (formWidth - ((columns + 1) * margin)) / columns;

            GroupBox[] layout =
            {
        groupBox1, groupBox2, groupBox3,
        customGroup6, groupBox4, groupBox5
    };

            int spacingB = 10;
            int buttonWidth = 150;
            int buttonHeight = 50;
            int buttonCount = 5;
            int totalWidth = buttonCount * buttonWidth + (buttonCount - 1) * spacingB;
            int startX = (this.ClientSize.Width - totalWidth) / 2;
            int buttonY = this.ClientSize.Height - buttonHeight - 5;

            Button[] buttons = { button1, button2, button3, button4, button5 };
            for (int i = 0; i < buttons.Length; i++)
            {
                buttons[i].Size = new Size(buttonWidth, buttonHeight);
                buttons[i].Location = new Point(startX + i * (buttonWidth + spacingB), buttonY);
            }

            int topY = toolStrip1.Bottom + 10;
            int bottomY = buttons[0].Top - 10;
            int availableHeight = bottomY - topY;

            int rows = (int)Math.Ceiling(layout.Length / (float)columns);
            int groupBoxHeight = (availableHeight - (rows - 1) * spacing) / rows;

            for (int i = 0; i < layout.Length; i++)
            {
                int col = i % columns;
                int row = i / columns;

                int x = margin + col * (groupBoxWidth + margin);
                int y = topY + row * (groupBoxHeight + spacing);

                layout[i].Location = new Point(x, y);
                layout[i].Size = new Size(groupBoxWidth, groupBoxHeight);
            }

            progressBar1.Location = new Point(0, this.ClientSize.Height - progressBar1.Height);
            progressBar1.Width = this.ClientSize.Width;
            toolStrip1.Size = new Size(this.Width, 25);
            pictureBox4.Size = new Size(this.Width, 5);
            pictureBox5.Size = new Size(this.Width, 5);
            pictureBox4.Location = new Point(0, this.Height - progressBar1.Height - 5);
            panelmain.Size = new Size(this.Width, 40);
            textBox1.Size = new Size(this.ClientSize.Width, this.ClientSize.Height - progressBar1.Height - 50);
            textBox1.Location = new Point(0, toolStrip1.Bottom);

        }


        private void Panelmain_DoubleClick(object sender, EventArgs e)
        {
            if (!isFullscreen)
            {
                previousBounds = this.Bounds;
                this.FormBorderStyle = FormBorderStyle.None;
                this.WindowState = FormWindowState.Normal;
                this.Bounds = Screen.FromHandle(this.Handle).Bounds;
                centergroup();
                CultureInfo cinfo = CultureInfo.InstalledUICulture;
                if (cinfo.Name == "ko-KR")
                { }
                else
                {
                    panel1.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel2.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel3.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel4.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel5.Font = new Font("Consolas", 12, FontStyle.Regular);
                    groupBox1.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox2.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox3.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox4.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox5.Font = new Font("Consolas", 13, FontStyle.Bold);
                    customGroup6.Font = new Font("Consolas", 13, FontStyle.Bold);
                    toolStrip1.Font = new Font("Consolas", 11, FontStyle.Regular);
                }
                Relocatecheck(panel1);
                Relocatecheck(panel2);
                Relocatecheck(panel3);
                Relocatecheck(panel4);
                Relocatecheck(panel5);

                isFullscreen = true;
            }
            else
            {
                this.Bounds = previousBounds;
                this.AutoSizeMode = AutoSizeMode.GrowAndShrink;
                this.MinimizeBox = false;
                this.MaximizeBox = false;
                centergroup();
                CultureInfo cinfo = CultureInfo.InstalledUICulture;
                Console.WriteLine(cinfo.Name);
                if (cinfo.Name == "ko-KR")
                {
                    panel1.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel2.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel3.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel4.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel5.Font = new Font("Consolas", 12, FontStyle.Regular);
                    groupBox1.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox2.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox3.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox4.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox5.Font = new Font("Consolas", 13, FontStyle.Bold);
                    customGroup6.Font = new Font("Consolas", 13, FontStyle.Bold);
                    toolStrip1.Font = new Font("Consolas", 12, FontStyle.Regular);
                }
                else
                {
                    panel1.Font = new Font("Consolas", 9, FontStyle.Regular);
                    panel2.Font = new Font("Consolas", 9, FontStyle.Regular);
                    panel3.Font = new Font("Consolas", 9, FontStyle.Regular);
                    panel4.Font = new Font("Consolas", 9, FontStyle.Regular);
                    panel5.Font = new Font("Consolas", 9, FontStyle.Regular);
                    groupBox1.Font = new Font("Consolas", 12, FontStyle.Bold);
                    groupBox2.Font = new Font("Consolas", 12, FontStyle.Bold);
                    groupBox3.Font = new Font("Consolas", 12, FontStyle.Bold);
                    groupBox4.Font = new Font("Consolas", 12, FontStyle.Bold);
                    groupBox5.Font = new Font("Consolas", 12, FontStyle.Bold);
                    customGroup6.Font = new Font("Consolas", 12, FontStyle.Bold);
                    toolStrip1.Font = new Font("Consolas", 9, FontStyle.Regular);
                }
                Relocatecheck(panel1);
                Relocatecheck(panel2);
                Relocatecheck(panel3);
                Relocatecheck(panel4);
                Relocatecheck(panel5);

                isFullscreen = false;

            }

        }

        public static void StopOneDriveKFM()
        {
            string userProfile = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);

            var folders = new (string name, string regPath)[]
            {
            ("Desktop", "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"),
            ("Documents", "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"),
            ("Pictures", "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders"),
            ("Downloads", "Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders")
            };

            foreach (var (name, regPath) in folders)
            {
                string localPath = Path.Combine(userProfile, name);
                try
                {
                    using (RegistryKey key = Registry.CurrentUser.OpenSubKey(regPath, writable: true))
                    {
                        if (key != null)
                        {
                            key.SetValue(name, localPath);
                            Console.WriteLine($"{name} folder reset to local path: {localPath}");
                        }
                    }

                    string oneDrivePath = Path.Combine(userProfile, "OneDrive", name);
                    if (Directory.Exists(oneDrivePath) && !Directory.Exists(localPath))
                    {
                        Directory.Move(oneDrivePath, localPath);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error processing {name}: {ex.Message}");
                }
            }
        }

        private void DeleteFilesByPattern(string folder, string pattern)
        {
            if (!Directory.Exists(folder)) return;

            try
            {
                foreach (var file in Directory.GetFiles(folder, pattern, SearchOption.AllDirectories))
                {
                    TryDeleteFile(file);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting files in folder {folder} with pattern {pattern}: {ex.Message}");
            }
        }

        private void DeleteFolder(string path)
        {
            try
            {
                if (Directory.Exists(path))
                    Directory.Delete(path, true);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting folder {path}: {ex.Message}");
            }
        }

        private void TryDeleteFile(string file)
        {
            try
            {
                File.SetAttributes(file, FileAttributes.Normal);
                File.Delete(file);
            }
            catch
            {
                Console.WriteLine($"Error deleting file {file}");
            }
        }

        private void DeleteFilesInFolder(string path)
        {
            if (!Directory.Exists(path)) return;

            try
            {
                foreach (var file in Directory.GetFiles(path, "*", SearchOption.AllDirectories))
                {
                    TryDeleteFile(file);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting files in folder {path}: {ex.Message}");
            }
        }

        private void LoadAppxPackages()
        {

            try
            {
                ProcessStartInfo psi = new ProcessStartInfo
                {
                    FileName = "powershell.exe",
                    Arguments = "-Command \"Get-AppxPackage -AllUsers | Where-Object { $_.NonRemovable -eq $false } | Select -ExpandProperty Name\"",
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };

                using (Process p = Process.Start(psi))
                using (StreamReader reader = p.StandardOutput)
                {
                    string line;
                    int top = 5;
                    int tabIndex = 0;

                    while ((line = reader.ReadLine()) != null)
                    {
                        string appName = line.Trim();

                        if (string.IsNullOrWhiteSpace(appName)) continue;

                        if (whitelistapps.Contains(appName)) continue;

                        CheckBox cb = new CheckBox
                        {
                            Text = appName,
                            AutoSize = true,
                            Top = top,
                            Left = 10,
                            Checked = true,
                            TabIndex = tabIndex++
                        };

                        panel6.Controls.Add(cb);
                        top += 25;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error getching packets:\n" + ex.Message);
            }
        }

        private void SaveUncheckedToWhitelist()
        {
            string whitelistPath = "whitelist.txt";

            using (StreamWriter writer = new StreamWriter(whitelistPath, false, System.Text.Encoding.UTF8))
            {
                foreach (Control ctrl in panel6.Controls)
                {
                    if (ctrl is CheckBox cb && !cb.Checked)
                    {
                        writer.WriteLine(cb.Text.Trim());
                    }
                }
            }
        }

        public class MySR : ToolStripSystemRenderer
        {
            public MySR() { }

        }

        public string systemDrive = Environment.GetEnvironmentVariable("SystemDrive");

        public HashSet<string> whitelistapps = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "Microsoft.MicrosoftOfficeHub",
                                "Microsoft.Office.OneNote",
                                "Microsoft.WindowsAlarms",
                                "Microsoft.WindowsCalculator",
                                "Microsoft.WindowsCamera",
                                "microsoft.windowscommunicationsapps",
                                "Microsoft.NET.Native.Framework.2.2",
                                "Microsoft.NET.Native.Framework.2.0",
                                "Microsoft.NET.Native.Runtime.2.2",
                                "Microsoft.NET.Native.Runtime.2.0",
                                "Microsoft.UI.Xaml.2.7",
                                "Microsoft.UI.Xaml.2.0",
                                "Microsoft.WindowsAppRuntime.1.3",
                                "Microsoft.WindowsAppRuntime.1.2",
                                "Microsoft.NET.Native.Framework.1.7",
                                "MicrosoftWindows.Client.Core",
                                "Microsoft.LockApp",
                                "Microsoft.ECApp",
                                "Microsoft.Windows.ContentDeliveryManager",
                                "Microsoft.Windows.Search",
                                "Microsoft.Windows.OOBENetworkCaptivePortal",
                                "Microsoft.Windows.SecHealthUI",
                                "Microsoft.SecHealthUI",
                                "Microsoft.WindowsAppRuntime.CBS",
                                "Microsoft.VCLibs.140.00.UWPDesktop",
                                "Microsoft.VCLibs.120.00.UWPDesktop",
                                "Microsoft.VCLibs.110.00.UWPDesktop",
                                "Microsoft.DirectXRuntime",
                                "Microsoft.XboxGameOverlay",
                                "Microsoft.XboxGamingOverlay",
                                "Microsoft.GamingApp",
                                "Microsoft.GamingServices",
                                "Microsoft.XboxIdentityProvider",
                                "Microsoft.Xbox.TCUI",
                                "Microsoft.AccountsControl",
                                "Microsoft.WindowsStore",
                                "Microsoft.StorePurchaseApp",
                                "Microsoft.VP9VideoExtensions",
                                "Microsoft.RawImageExtension",
                                "Microsoft.HEIFImageExtension",
                                "Microsoft.HEIFImageExtension",
                                "Microsoft.WebMediaExtensions",
                                "RealtekSemiconductorCorp.RealtekAudioControl",
                                "Microsoft.MicrosoftEdge",
                                "Microsoft.MicrosoftEdge.Stable",
                                "MicrosoftWindows.Client.FileExp",
                                "NVIDIACorp.NVIDIAControlPanel",
                                "AppUp.IntelGraphicsExperience",
                                "Microsoft.Paint",
                                "Microsoft.Messaging",
                                "Microsoft.AsyncTextService",
                                "Microsoft.CredDialogHost",
                                "Microsoft.Win32WebViewHost",
                                "Microsoft.MicrosoftEdgeDevToolsClient",
                                "Microsoft.Windows.OOBENetworkConnectionFlow",
                                "Microsoft.Windows.PeopleExperienceHost",
                                "Microsoft.Windows.PinningConfirmationDialog",
                                "Microsoft.Windows.SecondaryTileExperience",
                                "Microsoft.Windows.SecureAssessmentBrowser",
                                "Microsoft.Windows.ShellExperienceHost",
                                "Microsoft.Windows.StartMenuExperienceHost",
                                "Microsoft.Windows.XGpuEjectDialog",
                                "Microsoft.XboxGameCallableUI",
                                "MicrosoftWindows.UndockedDevKit",
                                "NcsiUwpApp",
                                "Windows.CBSPreview",
                                "Windows.MiracastView",
                                "Windows.ContactSupport",
                                "Windows.PrintDialog",
                                "c5e2524a-ea46-4f67-841f-6a9465d9d515",
                                "windows.immersivecontrolpanel",
                                "WinRAR.ShellExtension",
                                "Microsoft.WindowsNotepad",
                                "MicrosoftWindows.Client.WebExperience",
                                "Microsoft.ZuneMusic",
                                "Microsoft.ZuneVideo",
                                "Microsoft.OutlookForWindows",
                                "MicrosoftWindows.Ai.Copilot.Provider",
                                "Microsoft.WindowsTerminal",
                                "Microsoft.Windows.Terminal",
                                "WindowsTerminal",
                                "Microsoft.Winget.Source",
                                "Microsoft.DesktopAppInstaller",
                                "Microsoft.Services.Store.Engagement",
                                "Microsoft.HEVCVideoExtension",
                                "Microsoft.WebpImageExtension",
                                "MicrosoftWindows.CrossDevice",
                                "NotepadPlusPlus",
                                "MicrosoftCorporationII.WinAppRuntime.Main.1.5",
                                "Microsoft.WindowsAppRuntime.1.5",
                                "MicrosoftCorporationII.WinAppRuntime.Singleton",
                                "Microsoft.WindowsSoundRecorder",
                                "MicrosoftCorporationII.WinAppRuntime.Main.1.4",
                                "MicrosoftWindows.Client.LKG",
                                "MicrosoftWindows.Client.CBS",
                                "Microsoft.VCLibs.140.00",
                                "Microsoft.Windows.CloudExperienceHost",
                                "SpotifyAB.SpotifyMusic",
                                "Microsoft.SkypeApp",
                                "5319275A.WhatsAppDesktop",
                                "FACEBOOK.317180B0BB486",
                                "TelegramMessengerLLP.TelegramDesktop",
                                "4DF9E0F8.Netflix",
                                "Discord",
                                "Paint",
                                "mspaint",
                                "Microsoft.Windows.Paint",
                                "Microsoft.MicrosoftEdge.Stable",
                                "1527c705-839a-4832-9118-54d4Bd6a0c89",
                                "c5e2524a-ea46-4f67-841f-6a9465d9d515",
                                "E2A4F912-2574-4A75-9BB0-0D023378592B",
                                "F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE",
                                "Microsoft.AAD.BrokerPlugin",
                                "Microsoft.AccountsControl",
                                "Microsoft.AsyncTextService",
                                "Microsoft.BioEnrollment",
                                "Microsoft.CredDialogHost",
                                "Microsoft.ECApp",
                                "Microsoft.LockApp",
                                "Microsoft.MicrosoftEdgeDevToolsClient",
                                "Microsoft.UI.Xaml.CBS",
                                "Microsoft.Win32WebViewHost",
                                "Microsoft.Windows.Apprep.ChxApp",
                                "Microsoft.Windows.AssignedAccessLockApp",
                                "Microsoft.Windows.CapturePicker",
                                "Microsoft.Windows.CloudExperienceHost",
                                "Microsoft.Windows.ContentDeliveryManager",
                                "Microsoft.Windows.NarratorQuickStart",
                                "Microsoft.Windows.OOBENetworkCaptivePortal",
                                "Microsoft.Windows.OOBENetworkConnectionFlow",
                                "Microsoft.Windows.ParentalControls",
                                "Microsoft.Windows.PeopleExperienceHost",
                                "Microsoft.Windows.PinningConfirmationDialog",
                                "Microsoft.Windows.PrintQueueActionCenter",
                                "Microsoft.Windows.SecureAssessmentBrowser",
                                "Microsoft.Windows.XGpuEjectDialog",
                                "Microsoft.XboxGameCallableUI",
                                "MicrosoftWindows.Client.AIX",
                                "MicrosoftWindows.Client.FileExp",
                                "MicrosoftWindows.Client.OOBE",
                                "MicrosoftWindows.LKG.Search",
                                "MicrosoftWindows.UndockedDevKit",
                                "NcsiUwpApp",
                                "Windows.CBSPreview",
                                "windows.immersivecontrolpanel",
                                "Windows.PrintDialog",
                                "Microsoft.NET.Native.Framework.2.2",
                                "Microsoft.NET.Native.Framework.2.2",
                                "Microsoft.NET.Native.Runtime.2.2",
                                "Microsoft.NET.Native.Runtime.2.2",
                                "Microsoft.SecHealthUI",
                                "Microsoft.Services.Store.Engagement",
                                "Microsoft.UI.Xaml.2.8",
                                "Microsoft.VCLibs.140.00.UWPDesktop",
                                "Microsoft.VCLibs.140.00",
                                "Microsoft.VCLibs.140.00",
                                "Microsoft.WindowsAppRuntime.1.3",
                                "Microsoft.WindowsCamera",
                                "Microsoft.XboxIdentityProvider",
                                "Microsoft.ZuneMusic",
                                "RealtekSemiconductorCorp.RealtekAudioControl",
                                "DolbyLaboratories.DolbyAudioPremium",
                                "Microsoft.NET.Native.Framework.2.0",
                                "Microsoft.NET.Native.Framework.2.0",
                                "Microsoft.NET.Native.Runtime.2.0",
                                "AppUp.IntelGraphicsExperience",
                                "Microsoft.NET.Native.Runtime.2.0",
                                "Microsoft.Windows.AugLoop.CBS",
                                "Microsoft.Windows.ShellExperienceHost",
                                "Microsoft.Windows.StartMenuExperienceHost",
                                "Microsoft.WindowsAppRuntime.CBS.1.6",
                                "Microsoft.WindowsAppRuntime.CBS",
                                "MicrosoftWindows.Client.CBS",
                                "MicrosoftWindows.Client.Core",
                                "MicrosoftWindows.Client.Photon",
                                "MicrosoftWindows.LKG.AccountsService",
                                "MicrosoftWindows.LKG.DesktopSpotlight",
                                "MicrosoftWindows.LKG.IrisService",
                                "MicrosoftWindows.LKG.RulesEngine",
                                "MicrosoftWindows.LKG.SpeechRuntime",
                                "MicrosoftWindows.LKG.TwinSxS",
                                "Microsoft.VCLibs.140.00",
                                "Microsoft.Copilot",
                                "Microsoft.OneDriveSync",
                                "Microsoft.OutlookForWindows",
                                "Microsoft.VCLibs.140.00.UWPDesktop",
                                "Microsoft.WindowsAppRuntime.1.5",
                                "Microsoft.WindowsAppRuntime.1.5",
                                "Microsoft.VCLibs.140.00.UWPDesktop",
                                "Microsoft.Windows.DevHome",
                                "Microsoft.UI.Xaml.2.8",
                                "Microsoft.Paint",
                                "MicrosoftWindows.Client.WebExperience",
                                "Microsoft.WindowsStore",
                                "Microsoft.WindowsNotepad",
                                "Microsoft.WidgetsPlatformRuntime",
                                "Microsoft.Xbox.TCUI",
                                "Microsoft.WebpImageExtension",
                                "Microsoft.WebMediaExtensions",
                                "Microsoft.RawImageExtension",
                                "Microsoft.HEVCVideoExtension",
                                "Microsoft.HEIFImageExtension",
                                "Microsoft.WindowsTerminal",
                                "Microsoft.DesktopAppInstaller",
                                "Microsoft.StartExperiencesApp",
                                "Microsoft.StorePurchaseApp",
                                "Microsoft.GamingApp",
                                "Microsoft.VP9VideoExtensions",
                                "Microsoft.UI.Xaml.2.7",
                                "Microsoft.UI.Xaml.2.7",
                                "Microsoft.XboxGamingOverlay",
                                "Microsoft.WindowsCalculator",
                                "Microsoft.WindowsSoundRecorder",
                                "Microsoft.WindowsAlarms",
                                "Microsoft.MicrosoftOfficeHub",
                                "Microsoft.WindowsAppRuntime.1.6",
                                "Microsoft.WindowsAppRuntime.1.6",
                                "MicrosoftWindows.CrossDevice",
                                "Microsoft.Windows.Photos",
                                "Microsoft.MinecraftUWP",
                                "minecraft",
                                "Linux",
                                "Ubuntu",
                                "Kali",
                                "Debian",
                                "kali-linux",
                                "WSL",
                                "WSL2",
                                "Docker",
                                "Xbox",
                                "Microsoft.LanguageExperiencePack",
                                "Microsoft.LanguageExperiencePacken-US",
                                "Microsoft.LanguageExperiencePackpl-PL",
                                "Microsoft.Lovika",
                                "Microsoft.4297127D64EC6",
                                "Microsoft.Winget.Source",
                                "26737FrancescoSorge.Dockerun",
                                "CanonicalGroupLimited.Ubuntu",
                                "KaliLinux.54290C8133FEE",
                                "TheDebianProject.DebianGNULinux",
                                "Crystalnix.Termius",
                                "OpenAI.ChatGPT-Desktop",
                                "Disney.37853FC22B2CE",
                                "5319275A.WhatsAppDesktop",
                                "FACEBOOK.317180B0BB486",
                                "MicrosoftWindows.55182690.Taskbar",
                                "Microsoft.WindowsAppRuntime.1.7",
                                "Microsoft.VCLibs.120.00",
                                "Microsoft.ApplicationComatibilityEnhanced",
                                "Microsoft.AV1VideoExtension",
                                "Microsoft.AVCEncoderVideoExtension",
                                "Microsoft.MPEG2VideoExtension",
                                "Microsoft.NET.Native.Runtime.1.3",
                                "Microsoft.NET.Native.Framework.1.3",
                                "Microsoft.NET.Native.Runtime.1.6",
                                "Microsoft.NET.Native.Framework.1.6",
                                "Microsoft.NET.Native.Framework.1.7",
                                "Microsoft.UI.Xaml.2.1",
                                "Microsoft.NET.Native.Runtime.1.7",
                                "Microsoft.UI.Xaml.2.3",
                                "Microsoft.UI.Xaml.2.4",
                                "Microsoft.WinJS.2.0",
                                "Microsoft.WindowsAppRuntime.1.4"
        };

        string mainforecolor = "#eeeeee";
        string mainbackcolor = "#252525";
        string menubackcolor = "#323232";
        string selectioncolor = "#3498db";
        string selectioncolor2 = "#246c9d";
        string expercolor = "#e74c3c";

        public bool isswitch = false;
        public bool issillent = false;
        public bool engforced = false;

        string ETVersion = "E.T. ver 6.06.35";
        string ETBuild = "04.07.2025";

        public string selectall0 = "Select All";
        public string selectall1 = "Unselect All";

        public string msgend = "Everything has been done. Reboot is recommended.";
        public string msgerror = "No option selected.";
        public string msgupdate = "A newer version of the application is available on GitHub!";
        public string isoinfo = "The generated ISO image will contain the following features: ET-Optimizer.exe /auto and bypassing Microsoft requirements by bypassing data collection, local account creation, etc.";

        public void CreateRestorePoint(string description, int restorePointType)
        {
            try
            {
                ManagementClass mc = new ManagementClass(@"\\localhost\root\default:SystemRestore");
                ManagementBaseObject parameters = mc.GetMethodParameters("CreateRestorePoint");

                parameters["Description"] = description;
                parameters["EventType"] = 100;
                parameters["RestorePointType"] = restorePointType;

                mc.InvokeMethod("CreateRestorePoint", parameters, null);
            }
            catch (Exception ex)
            {
                Console.WriteLine("BackUp Error: " + ex.Message);
            }
        }
        private async Task BackItUp()
        {
            await Task.Run(() =>
            {
                System.Diagnostics.Process process = new System.Diagnostics.Process();
                System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

                try
                {
                    using (ManagementClass mc = new ManagementClass("SystemRestore"))
                    {
                        mc.InvokeMethod("Enable", new object[] { systemDrive });
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error enabling System Restore: " + ex.Message);
                }


                string backupPath = System.IO.Path.Combine(systemDrive + @"\", @"Backup");

                if (!Directory.Exists(backupPath))
                {
                    Directory.CreateDirectory(backupPath);
                }

                string backupPathcmd = Environment.ExpandEnvironmentVariables(@"%SystemDrive%\Backup\");

                string[] commands = new[]
        {
            $"reg export \"HKLM\\SOFTWARE\" \"{backupPathcmd}HKLM_SOFTWARE.reg\" /y",
            $"reg export \"HKLM\\SYSTEM\" \"{backupPathcmd}HKLM_SYSTEM.reg\" /y",
            $"reg export \"HKCU\\Software\" \"{backupPathcmd}HKCU_SOFTWARE.reg\" /y",
            $"reg export \"HKCU\\System\" \"{backupPathcmd}HKCU_SYSTEM.reg\" /y",
            $"reg export \"HKCU\\Control Panel\" \"{backupPathcmd}HKCU_ControlPanel.reg\" /y"
        };

                foreach (string command in commands)
                {
                    process.StartInfo.FileName = "cmd.exe";
                    process.StartInfo.Arguments = "/c " + command;
                    process.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    process.StartInfo.UseShellExecute = false;
                    process.StartInfo.CreateNoWindow = true;

                    process.Start();
                    process.WaitForExit();
                }

                CreateRestorePoint("ET_BACKUP-APPLICATION_INSTALL", 0);
                CreateRestorePoint("ET_BACKUP-DEVICE_DRIVER_INSTALL", 10);
                CreateRestorePoint("ET_BACKUP-MODIFY_SETTINGS", 12);
            });
        }

        public void SetRegistryValue(string hivePath, string name, object value, RegistryValueKind kind)
        {
            try
            {
                RegistryKey baseKey;
                string subKeyPath;

                if (hivePath.StartsWith("HKLM"))
                {
                    baseKey = Registry.LocalMachine;
                    subKeyPath = hivePath.Substring(5);
                }
                else if (hivePath.StartsWith("HKCU"))
                {
                    baseKey = Registry.CurrentUser;
                    subKeyPath = hivePath.Substring(5);
                }
                else if (hivePath.StartsWith("HKU"))
                {
                    baseKey = Registry.Users;
                    subKeyPath = hivePath.Substring(4);
                }
                else
                {
                    Console.WriteLine($"Uknown registry tree: {hivePath}");
                    return;
                }

                using (RegistryKey key = baseKey.CreateSubKey(subKeyPath, true))
                {
                    key?.SetValue(name, value, kind);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Settings Error: {hivePath}\\{name}: {ex.Message}");
            }
        }

        public void PopUpMSG(string messagepopup)
        {
            Form popup = new Form
            {
                FormBorderStyle = FormBorderStyle.None,
                StartPosition = FormStartPosition.CenterScreen,
                TopMost = true,
                Size = new Size(this.ClientSize.Width, this.ClientSize.Height),
                BackColor = ColorTranslator.FromHtml(menubackcolor),
                ForeColor = ColorTranslator.FromHtml(mainforecolor),
                Font = new Font("Consolas", 10F, FontStyle.Regular)
            };
            popup.AllowTransparency = true;
            popup.StartPosition = FormStartPosition.Manual;
            popup.ShowIcon = false;
            popup.ShowInTaskbar = false;
            popup.Location = new Point(
                this.Location.X + (this.Width - popup.Width) / 2,
                this.Location.Y + (this.Height - popup.Height) / 2
            );

            popup.Opacity = 0.9;

            Label msgLabel = new Label
            {
                Text = messagepopup,
                AutoSize = false,
                TextAlign = System.Drawing.ContentAlignment.MiddleCenter,
                Dock = DockStyle.Fill,
                Font = new Font("Consolas", 13F, FontStyle.Bold),
                Padding = new Padding(10),
                ForeColor = ColorTranslator.FromHtml(mainforecolor),
                BackColor = ColorTranslator.FromHtml(menubackcolor)
            };

            Button okButton = new Button
            {
                Text = "OK",
                FlatStyle = FlatStyle.Flat,
                BackColor = ColorTranslator.FromHtml(selectioncolor),
                ForeColor = Color.White,
                Size = new Size(120, 45),
                Font = new Font("Consolas", 13F, FontStyle.Bold),
                Anchor = AnchorStyles.Bottom
            };
            okButton.FlatAppearance.BorderSize = 0;
            okButton.Location = new Point((popup.ClientSize.Width - okButton.Width) / 2, popup.ClientSize.Height / 2 + 30);
            okButton.Click += (s, e) => popup.Close();

            popup.Controls.Add(okButton);
            popup.Controls.Add(msgLabel);
            popup.AcceptButton = okButton;

            popup.ShowDialog();
        }

        public void StopService(string serviceName)
        {
            try
            {
                ServiceController sc = new ServiceController(serviceName);
                if (sc.Status != ServiceControllerStatus.Stopped && sc.CanStop)
                    sc.Stop();
            }
            catch { }
        }

        public void StartService(string serviceName)
        {
            try
            {
                ServiceController sc = new ServiceController(serviceName);
                if (sc.Status != ServiceControllerStatus.Running)
                    sc.Start();
            }
            catch
            { }
        }

        public int ct;
        public int cy;
        public int cu;
        public int ci;
        public void c_p(object sender, EventArgs e)
        {
            ct = panel1.Controls.OfType<CheckBox>().Count();
            int checkedCt = panel1.Controls.OfType<CheckBox>().Count(cb => cb.Checked);
            if (checkedCt == ct)
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            else
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
            }

            cy = panel2.Controls.OfType<CheckBox>().Count();
            int checkedCy = panel2.Controls.OfType<CheckBox>().Count(cb => cb.Checked);
            if (checkedCy == cy)
            {
                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            else
            {
                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
            }

            cu = panel3.Controls.OfType<CheckBox>().Count();
            int checkedCu = panel3.Controls.OfType<CheckBox>().Count(cb => cb.Checked);
            if (checkedCu == cu)
            {
                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            else
            {
                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
            }

            ci = panel4.Controls.OfType<CheckBox>().Count();
            int checkedCi = panel4.Controls.OfType<CheckBox>().Count(cb => cb.Checked);
            if (checkedCi == ci)
            {
                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            }
            else
            {
                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            int allc = checkedCi + checkedCu + checkedCy + checkedCt;

            if (allc == 72)
            {
                selecall++;
                button4.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button4.Text = selectall1;

            }
            else
            {
                button4.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                button4.Text = selectall0;
            }
        }

        void SetToolstripIcons()
        {
            TrySetIcon("dfrgui.exe", diskDefragmenterToolStripMenuItem);
            TrySetIcon("cleanmgr.exe", cleanmgrToolStripMenuItem);
            TrySetIcon("msconfig.exe", msconfigToolStripMenuItem);
            TrySetIcon("control.exe", controlPanelToolStripMenuItem);
            TrySetIcon("devmgmt.msc", deviceManagerToolStripMenuItem);
            TrySetIcon("UserAccountControlSettings.exe", uACSettingsToolStripMenuItem);
            TrySetIcon("msinfo32.exe", msinfo32ToolStripMenuItem);
            TrySetIcon("services.msc", servicesToolStripMenuItem);
            TrySetIcon("mstsc.exe", remoteDesktopToolStripMenuItem);
            TrySetIcon("eventvwr.exe", eventViewerToolStripMenuItem);
            TrySetIcon("control.exe", resetNetworkToolStripMenuItem);
            TrySetIcon(@"oobe\Setup.exe", makeETISOToolStripMenuItem);
            TrySetIcon("ComputerDefaults.exe", updateApplicationsToolStripMenuItem);
            TrySetIcon("ComputerDefaults.exe", downloadSoftwareToolStripMenuItem);
            TrySetIcon("slui.exe", windowsLicenseKeyToolStripMenuItem);
            TrySetIcon("cmd.exe", rebootToBIOSToolStripMenuItem);
            TrySetIcon("cmd.exe", rebootToSafeModeToolStripMenuItem);
            TrySetIcon(@"..\explorer.exe", restartExplorerexeToolStripMenuItem);
            TrySetIcon(@"RecoveryDrive.exe", restorePointToolStripMenuItem);
            TrySetIcon(@"..\regedit.exe", registryRestoreToolStripMenuItem);
        }

        void TrySetIcon(string relativePath, ToolStripMenuItem menuItem)
        {
            try
            {
                string fullPath;

                if (relativePath.Contains("\\"))
                {
                    // Subfolder like oobe\Setup.exe or ..\regedit.exe
                    fullPath = Path.GetFullPath(Path.Combine(Environment.SystemDirectory, relativePath));
                }
                else
                {
                    fullPath = Path.Combine(Environment.SystemDirectory, relativePath);
                }

                if (File.Exists(fullPath))
                {
                    menuItem.Image = Icon.ExtractAssociatedIcon(fullPath)?.ToBitmap();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Icon load failed for {relativePath}: {ex.Message}");
            }
        }


        public Form1(string[] args)
        {

            InitializeComponent();
            LoadAppxPackages();
            this.KeyPreview = true; 
            this.KeyDown += Form1_KeyDown;

            this.Opacity = 0;
            this.Enabled = false;
            toolStripLabel1.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            toolStripLabel2.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            toolStripLabel3.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            button6.Location = new System.Drawing.Point(910, 5);
            button6.FlatAppearance.BorderSize = 0;
            button7.Location = new System.Drawing.Point(845, -2);
            button7.FlatAppearance.BorderSize = 0;

            this.MouseDown += new MouseEventHandler(Form1_MouseDown);
            this.MouseDown += new MouseEventHandler(ToolStrip1_MouseDown);
            this.MouseDown += new MouseEventHandler(panelmain_MouseDown);
            this.MouseDown += new MouseEventHandler(label1_MouseDown);

            this.Load += new EventHandler(Form1_Load);

            toolStrip1.Renderer = new MySR();
            this.Size = new System.Drawing.Size(975, 500);
            this.StartPosition = FormStartPosition.CenterScreen;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            string CPUL = string.Empty;
            try
            {
                using (var searcher = new ManagementObjectSearcher("select Name from Win32_Processor"))
                {
                    foreach (var item in searcher.Get())
                    {
                        CPUL = item["Name"]?.ToString() ?? "Unknown CPU";
                        break;
                    }
                }
                CPUL = CPUL.Replace("(R)", "").Replace("(TM)", "").Trim();
            }
            catch
            {
                CPUL = "CPU Info Not Available";
            }


            this.Text = ETVersion + "   -   " + CPUL;
            label1.Text = ETVersion + "   -   " + CPUL;
            this.AutoSizeMode = AutoSizeMode.GrowAndShrink;
            this.MinimizeBox = false;
            this.MaximizeBox = false;
            button5.Location = new System.Drawing.Point(680, 440);
            button5.Size = new System.Drawing.Size(140, 50);
            button5.FlatAppearance.BorderSize = 0;
            button4.Location = new System.Drawing.Point(530, 440);
            button4.Size = new System.Drawing.Size(140, 50);
            button4.FlatAppearance.BorderSize = 0;
            button3.Location = new System.Drawing.Point(400, 440);
            button3.Size = new System.Drawing.Size(140, 50);
            button3.FlatAppearance.BorderSize = 0;
            button2.Location = new System.Drawing.Point(270, 440);
            button2.Size = new System.Drawing.Size(140, 50);
            button2.FlatAppearance.BorderSize = 0;
            button1.Location = new System.Drawing.Point(130, 440);
            button1.Size = new System.Drawing.Size(140, 50);
            button1.FlatAppearance.BorderSize = 0;
            groupBox1.Location = new System.Drawing.Point(10, 70);
            groupBox1.Size = new System.Drawing.Size(305, 180);
            groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox2.Location = new System.Drawing.Point(320, 70);
            groupBox2.Size = new System.Drawing.Size(305, 180);
            groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox3.Location = new System.Drawing.Point(630, 70);
            groupBox3.Size = new System.Drawing.Size(305, 180);
            groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox4.Location = new System.Drawing.Point(320, 250);
            groupBox4.Size = new System.Drawing.Size(305, 180);
            groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox5.Location = new System.Drawing.Point(630, 250);
            groupBox5.Size = new System.Drawing.Size(305, 180);
            groupBox5.ForeColor = System.Drawing.ColorTranslator.FromHtml(expercolor);

            groupBox6.Location = new System.Drawing.Point(10, 250);
            groupBox6.Size = new System.Drawing.Size(305, 180);
            groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox6.BackColor = System.Drawing.ColorTranslator.FromHtml(menubackcolor);
            panel6.BackColor = System.Drawing.ColorTranslator.FromHtml(menubackcolor);
            panel6.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            customGroup6 = new ColoredGroupBox
            {
                Text = groupBox6.Text,
                InnerBackColor = System.Drawing.ColorTranslator.FromHtml(menubackcolor),
                Bounds = groupBox6.Bounds,
                Font = groupBox6.Font,
                ForeColor = groupBox6.ForeColor
            };

            while (groupBox6.Controls.Count > 0)
                customGroup6.Controls.Add(groupBox6.Controls[0]);

            Controls.Remove(groupBox6);
            Controls.Add(customGroup6);


            toolStrip1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            toolStrip1.BackColor = System.Drawing.ColorTranslator.FromHtml(menubackcolor);
            toolStrip1.Size = new Size(this.Width, 25);
            textBox1.Location = new System.Drawing.Point(10, 70);
            textBox1.Size = new System.Drawing.Size(925, 360);
            toolStripButton5.Visible = false;

            CheckBox chck1 = new CheckBox();
            chck1.Tag = "Disable Edge WebWidget";
            chck1.TabIndex = 1;
            chck1.Checked = true;
            chck1.Click += c_p;
            panel1.Controls.Add(chck1);
            CheckBox chck2 = new CheckBox();
            chck2.Tag = "Power Option to Ultimate Perform.";
            chck2.Checked = true;
            chck2.Click += c_p;
            chck2.TabIndex = 2;
            panel1.Controls.Add(chck2);
            CheckBox chck3 = new CheckBox();
            chck3.Tag = "Split Threshold for Svchost";
            chck3.Checked = true;
            chck3.Click += c_p;
            chck3.TabIndex = 3;
            panel4.Controls.Add(chck3);
            CheckBox chck4 = new CheckBox();
            chck4.Tag = "Dual Boot Timeout 3sec";
            chck4.Checked = true;
            chck4.Click += c_p;
            chck4.TabIndex = 4;
            panel1.Controls.Add(chck4);
            CheckBox chck5 = new CheckBox();
            chck5.Tag = "Disable Hibernation/Fast Startup";
            chck5.Checked = true;
            chck5.Click += c_p;
            chck5.TabIndex = 5;
            panel1.Controls.Add(chck5);
            CheckBox chck6 = new CheckBox();
            chck6.Tag = "Disable Windows Insider Experiments";
            chck6.Checked = true;
            chck6.Click += c_p;
            chck6.TabIndex = 6;
            panel1.Controls.Add(chck6);
            CheckBox chck7 = new CheckBox();
            chck7.Tag = "Disable App Launch Tracking";
            chck7.Checked = true;
            chck7.Click += c_p;
            chck7.TabIndex = 7;
            panel1.Controls.Add(chck7);
            CheckBox chck8 = new CheckBox();
            chck8.Tag = "Disable Powerthrottling (Intel 6gen+)";
            chck8.Checked = true;
            chck8.Click += c_p;
            chck8.TabIndex = 8;
            panel1.Controls.Add(chck8);
            CheckBox chck9 = new CheckBox();
            chck9.Tag = "Turn Off Background Apps";
            chck9.Checked = true;
            chck9.Click += c_p;
            chck9.TabIndex = 9;
            panel1.Controls.Add(chck9);
            CheckBox chck10 = new CheckBox();
            chck10.Tag = "Disable Sticky Keys Prompt";
            chck10.Checked = true;
            chck10.Click += c_p;
            chck10.TabIndex = 10;
            panel1.Controls.Add(chck10);
            CheckBox chck11 = new CheckBox();
            chck11.Tag = "Disable Activity History";
            chck11.Checked = true;
            chck11.Click += c_p;
            chck11.TabIndex = 11;
            panel1.Controls.Add(chck11);
            CheckBox chck12 = new CheckBox();
            chck12.Tag = "Disable Updates for MS Store Apps";
            chck12.Checked = true;
            chck12.Click += c_p;
            chck12.TabIndex = 12;
            panel1.Controls.Add(chck12);
            CheckBox chck13 = new CheckBox();
            chck13.Tag = "SmartScreen Filter for Apps Disable";
            chck13.Checked = true;
            chck13.Click += c_p;
            chck13.TabIndex = 13;
            panel1.Controls.Add(chck13);
            CheckBox chck14 = new CheckBox();
            chck14.Tag = "Let Websites Provide Locally";
            chck14.Checked = true;
            chck14.Click += c_p;
            chck14.TabIndex = 14;
            panel1.Controls.Add(chck14);
            CheckBox chck15 = new CheckBox();
            chck15.Tag = "Fix Microsoft Edge Settings";
            chck15.Checked = true;
            chck15.Click += c_p;
            chck15.TabIndex = 15;
            panel1.Controls.Add(chck15);
            CheckBox chck64 = new CheckBox();
            chck64.Tag = "Disable Nagle's Alg. (Delayed ACKs)";
            chck64.Checked = true;
            chck64.Click += c_p;
            chck64.TabIndex = 64;
            panel1.Controls.Add(chck64);
            CheckBox chck65 = new CheckBox();
            chck65.Tag = "CPU/GPU Priority Tweaks";
            chck65.Checked = true;
            chck65.Click += c_p;
            chck65.TabIndex = 65;
            panel1.Controls.Add(chck65);
            CheckBox chck16 = new CheckBox();
            chck16.Tag = "Disable Location Sensors";
            chck16.Checked = true;
            chck16.Click += c_p;
            chck16.TabIndex = 16;
            panel1.Controls.Add(chck16);
            CheckBox chck17 = new CheckBox();
            chck17.Tag = "Disable WiFi HotSpot Auto-Sharing";
            chck17.Checked = true;
            chck17.Click += c_p;
            chck17.TabIndex = 17;
            panel1.Controls.Add(chck17);
            CheckBox chck18 = new CheckBox();
            chck18.Tag = "Disable Shared HotSpot Connect";
            chck18.Checked = true;
            chck18.Click += c_p;
            chck18.TabIndex = 18;
            panel1.Controls.Add(chck18);
            CheckBox chck19 = new CheckBox();
            chck19.Tag = "Updates Notify to Sched. Restart";
            chck19.Checked = true;
            chck19.Click += c_p;
            chck19.TabIndex = 19;
            panel1.Controls.Add(chck19);
            CheckBox chck20 = new CheckBox();
            chck20.Tag = "P2P Update Setting to LAN (local)";
            chck20.Checked = true;
            chck20.Click += c_p;
            chck20.TabIndex = 20;
            panel1.Controls.Add(chck20);
            CheckBox chck21 = new CheckBox();
            chck21.Tag = "Set Lower Shutdown Time (2sec)";
            chck21.Checked = true;
            chck21.Click += c_p;
            chck21.TabIndex = 21;
            panel1.Controls.Add(chck21);
            CheckBox chck22 = new CheckBox();
            chck22.Tag = "Remove Old Device Drivers";
            chck22.Checked = true;
            chck22.Click += c_p;
            chck22.TabIndex = 22;
            panel1.Controls.Add(chck22);
            CheckBox chck23 = new CheckBox();
            chck23.Tag = "Disable Get Even More Out of...";
            chck23.Checked = true;
            chck23.Click += c_p;
            chck23.TabIndex = 23;
            panel1.Controls.Add(chck23);
            CheckBox chck24 = new CheckBox();
            chck24.Tag = "Disable Installing Suggested Apps";
            chck24.Checked = true;
            chck24.Click += c_p;
            chck24.TabIndex = 24;
            panel1.Controls.Add(chck24);
            CheckBox chck25 = new CheckBox();
            chck25.Tag = "Disable Start Menu Ads/Suggestions";
            chck25.Checked = true;
            chck25.Click += c_p;
            chck25.TabIndex = 25;
            panel1.Controls.Add(chck25);
            CheckBox chck26 = new CheckBox();
            chck26.Tag = "Disable Suggest Apps WindowsInk";
            chck26.Checked = true;
            chck26.Click += c_p;
            chck26.TabIndex = 26;
            panel1.Controls.Add(chck26);
            CheckBox chck27 = new CheckBox();
            chck27.Tag = "Disable Unnecessary Components";
            chck27.Checked = true;
            chck27.Click += c_p;
            chck27.TabIndex = 27;
            panel1.Controls.Add(chck27);
            CheckBox chck28 = new CheckBox();
            chck28.Tag = "Defender Scheduled Scan Nerf";
            chck28.Checked = true;
            chck28.Click += c_p;
            chck28.TabIndex = 28;
            panel1.Controls.Add(chck28);
            CheckBox chck29 = new CheckBox();
            chck29.Tag = "Disable Process Mitigation";
            chck29.Click += c_p;
            chck29.TabIndex = 29;
            panel5.Controls.Add(chck29);
            CheckBox chck30 = new CheckBox();
            chck30.Tag = "Defragment Indexing Service File";
            chck30.Checked = true;
            chck30.Click += c_p;
            chck30.TabIndex = 30;
            panel1.Controls.Add(chck30);
            CheckBox chck66 = new CheckBox();
            chck66.Tag = "Disable Spectre/Meltdown";
            chck66.Click += c_p;
            chck66.TabIndex = 66;
            panel5.Controls.Add(chck66);
            CheckBox chck67 = new CheckBox();
            chck67.Tag = "Disable Windows Defender";
            chck67.Click += c_p;
            chck67.TabIndex = 67;
            panel5.Controls.Add(chck67);
            CheckBox chck31 = new CheckBox();
            chck31.Tag = "Disable Telemetry Scheduled Tasks";
            chck31.Checked = true;
            chck31.Click += c_p;
            chck31.TabIndex = 31;
            panel2.Controls.Add(chck31);
            CheckBox chck32 = new CheckBox();
            chck32.Tag = "Remove Telemetry/Data Collection";
            chck32.Checked = true;
            chck32.Click += c_p;
            chck32.TabIndex = 32;
            panel2.Controls.Add(chck32);
            CheckBox chck33 = new CheckBox();
            chck33.Tag = "Disable PowerShell Telemetry";
            chck33.Checked = true;
            chck33.Click += c_p;
            chck33.TabIndex = 33;
            panel2.Controls.Add(chck33);
            CheckBox chck34 = new CheckBox();
            chck34.Tag = "Disable Skype Telemetry";
            chck34.Checked = true;
            chck34.Click += c_p;
            chck34.TabIndex = 34;
            panel2.Controls.Add(chck34);
            CheckBox chck35 = new CheckBox();
            chck35.Tag = "Disable Media Player Usage Reports";
            chck35.Checked = true;
            chck35.Click += c_p;
            chck35.TabIndex = 35;
            panel2.Controls.Add(chck35);
            CheckBox chck36 = new CheckBox();
            chck36.Tag = "Disable Mozilla Telemetry";
            chck36.Checked = true;
            chck36.Click += c_p;
            chck36.TabIndex = 36;
            panel2.Controls.Add(chck36);
            CheckBox chck37 = new CheckBox();
            chck37.Tag = "Disable Apps Use My Advertising ID";
            chck37.Checked = true;
            chck37.Click += c_p;
            chck37.TabIndex = 37;
            panel2.Controls.Add(chck37);
            CheckBox chck38 = new CheckBox();
            chck38.Tag = "Disable Send Info About Writing";
            chck38.Checked = true;
            chck38.Click += c_p;
            chck38.TabIndex = 38;
            panel2.Controls.Add(chck38);
            CheckBox chck39 = new CheckBox();
            chck39.Tag = "Disable Handwriting Recognition";
            chck39.Checked = true;
            chck39.Click += c_p;
            chck39.TabIndex = 39;
            panel2.Controls.Add(chck39);
            CheckBox chck40 = new CheckBox();
            chck40.Tag = "Disable Watson Malware Reports";
            chck40.Checked = true;
            chck40.Click += c_p;
            chck40.TabIndex = 40;
            panel2.Controls.Add(chck40);
            CheckBox chck41 = new CheckBox();
            chck41.Tag = "Disable Malware Diagnostic Data";
            chck41.Checked = true;
            chck41.Click += c_p;
            chck41.TabIndex = 41;
            panel2.Controls.Add(chck41);
            CheckBox chck42 = new CheckBox();
            chck42.Tag = "Disable Reporting to MS MAPS";
            chck42.Checked = true;
            chck42.Click += c_p;
            chck42.TabIndex = 42;
            panel2.Controls.Add(chck42);
            CheckBox chck43 = new CheckBox();
            chck43.Tag = "Disable Spynet Defender Reporting";
            chck43.Checked = true;
            chck43.Click += c_p;
            chck43.TabIndex = 43;
            panel2.Controls.Add(chck43);
            CheckBox chck44 = new CheckBox();
            chck44.Tag = "Do Not Send Malware Samples";
            chck44.Checked = true;
            chck44.Click += c_p;
            chck44.TabIndex = 44;
            panel2.Controls.Add(chck44);
            CheckBox chck45 = new CheckBox();
            chck45.Tag = "Disable Sending Typing Samples";
            chck45.Checked = true;
            chck45.Click += c_p;
            chck45.TabIndex = 45;
            panel2.Controls.Add(chck45);
            CheckBox chck46 = new CheckBox();
            chck46.Tag = "Disable Sending Contacts to MS";
            chck46.Checked = true;
            chck46.Click += c_p;
            chck46.TabIndex = 46;
            panel2.Controls.Add(chck46);
            CheckBox chck47 = new CheckBox();
            chck47.Tag = "Disable Cortana";
            chck47.Checked = true;
            chck47.Click += c_p;
            chck47.TabIndex = 47;
            panel2.Controls.Add(chck47);
            CheckBox chck48 = new CheckBox();
            chck48.Tag = "Show File Extensions in Explorer";
            chck48.Checked = true;
            chck48.Click += c_p;
            chck48.TabIndex = 48;
            panel3.Controls.Add(chck48);
            CheckBox chck49 = new CheckBox();
            chck49.Tag = "Disable Transparency on Taskbar";
            chck49.Checked = true;
            chck49.Click += c_p;
            chck49.TabIndex = 49;
            panel3.Controls.Add(chck49);
            CheckBox chck50 = new CheckBox();
            chck50.Tag = "Disable Windows Animations";
            chck50.Checked = true;
            chck50.Click += c_p;
            chck50.TabIndex = 50;
            panel3.Controls.Add(chck50);
            CheckBox chck51 = new CheckBox();
            chck51.Tag = "Disable MRU lists (jump lists)";
            chck51.Checked = true;
            chck51.Click += c_p;
            chck51.TabIndex = 51;
            panel3.Controls.Add(chck51);
            CheckBox chck52 = new CheckBox();
            chck52.Tag = "Set Search Box to Icon Only";
            chck52.Checked = true;
            chck52.Click += c_p;
            chck52.TabIndex = 52;
            panel3.Controls.Add(chck52);
            CheckBox chck53 = new CheckBox();
            chck53.Tag = "Explorer on Start on This PC";
            chck53.Checked = true;
            chck53.Click += c_p;
            chck53.TabIndex = 53;
            panel3.Controls.Add(chck53);
            CheckBox chck54 = new CheckBox();
            chck54.Tag = "Remove Windows Game Bar/DVR";
            chck54.Checked = true;
            chck54.Click += c_p;
            chck54.TabIndex = 54;
            panel4.Controls.Add(chck54);
            CheckBox chck55 = new CheckBox();
            chck55.Tag = "Enable Service Tweaks";
            chck55.Checked = true;
            chck55.Click += c_p;
            chck55.TabIndex = 55;
            panel1.Controls.Add(chck55);
            CheckBox chck56 = new CheckBox();
            chck56.Tag = "Remove Bloatware (Preinstalled)";
            chck56.Checked = true;
            chck56.Click += c_p;
            chck56.CheckedChanged += (s, e) =>
            {
                panel6.Enabled = chck56.Checked;
                if (chck56.Checked)
                {
                    groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                }
                else
                {
                    groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                }
            };
            chck56.TabIndex = 56;
            panel1.Controls.Add(chck56);
            CheckBox chck57 = new CheckBox();
            chck57.Tag = "Disable Unnecessary Startup Apps";
            chck57.Checked = true;
            chck57.Click += c_p;
            chck57.TabIndex = 57;
            panel1.Controls.Add(chck57);
            CheckBox chck58 = new CheckBox();
            chck58.Tag = "Clean Temp/Cache/Prefetch/Logs";
            chck58.Checked = true;
            chck58.Click += c_p;
            chck58.TabIndex = 58;
            panel4.Controls.Add(chck58);
            CheckBox chck59 = new CheckBox();
            chck59.Tag = "Remove News and Interests/Widgets";
            chck59.Click += c_p;
            chck59.TabIndex = 59;
            panel4.Controls.Add(chck59);
            CheckBox chck60 = new CheckBox();
            chck60.Tag = "Remove Microsoft OneDrive";
            chck60.Click += c_p;
            chck60.TabIndex = 60;
            panel5.Controls.Add(chck60);
            CheckBox chck61 = new CheckBox();
            chck61.Tag = "Disable Xbox Services";
            chck61.Click += c_p;
            chck61.TabIndex = 61;
            panel5.Controls.Add(chck61);
            CheckBox chck62 = new CheckBox();
            chck62.Tag = "Enable Fast/Secure DNS (1.1.1.1)";
            chck62.Click += c_p;
            chck62.TabIndex = 62;
            panel5.Controls.Add(chck62);
            CheckBox chck63 = new CheckBox();
            chck63.Tag = "Scan for Adware (AdwCleaner)";
            chck63.Click += c_p;
            chck63.TabIndex = 63;
            panel4.Controls.Add(chck63);
            CheckBox chck68 = new CheckBox();
            chck68.Tag = "Clean WinSxS Folder";
            chck68.Click += c_p;
            chck68.TabIndex = 68;
            panel4.Controls.Add(chck68);
            CheckBox chck69 = new CheckBox();
            chck69.Tag = "Remove Copilot";
            chck69.Checked = true;
            chck69.Click += c_p;
            chck69.TabIndex = 69;
            panel2.Controls.Add(chck69);
            CheckBox chck70 = new CheckBox();
            chck70.Tag = "Remove Learn about this photo";
            chck70.Checked = true;
            chck70.Click += c_p;
            chck70.TabIndex = 70;
            panel3.Controls.Add(chck70);
            CheckBox chck71 = new CheckBox();
            chck71.Tag = "Enable Long Paths";
            chck71.Checked = true;
            chck71.Click += c_p;
            chck71.TabIndex = 71;
            panel1.Controls.Add(chck71);
            CheckBox chck72 = new CheckBox();
            chck72.Tag = "Enable Old Context Menu";
            chck72.Checked = true;
            chck72.Click += c_p;
            chck72.TabIndex = 72;
            panel3.Controls.Add(chck72);
            CheckBox chck73 = new CheckBox();
            chck73.Tag = "Disable Fullscreen Optimizations";
            chck73.Checked = true;
            chck73.Click += c_p;
            chck73.TabIndex = 73;
            panel1.Controls.Add(chck73);
            CheckBox chck74 = new CheckBox();
            chck74.Tag = "RAM Memory Tweaks";
            chck74.Checked = true;
            chck74.Click += c_p;
            chck74.TabIndex = 74;
            panel1.Controls.Add(chck74);
            CheckBox chck75 = new CheckBox();
            chck75.Tag = "Block telemetry and user experience hosts";
            chck75.Checked = true;
            chck75.Click += c_p;
            chck75.TabIndex = 75;
            panel2.Controls.Add(chck75);
            CheckBox chck76 = new CheckBox();
            chck76.Tag = "Block location data sharing hosts";
            chck76.Checked = true;
            chck76.Click += c_p;
            chck76.TabIndex = 76;
            panel2.Controls.Add(chck76);
            CheckBox chck77 = new CheckBox();
            chck77.Tag = "Block Windows crash report hosts";
            chck77.Checked = true;
            chck77.Click += c_p;
            chck77.TabIndex = 77;
            panel2.Controls.Add(chck77);
            CheckBox chck78 = new CheckBox();
            chck78.Tag = "Disable Logon Background Image";
            chck78.Checked = true;
            chck78.Click += c_p;
            chck78.TabIndex = 78;
            panel3.Controls.Add(chck78);

            SetToolstripIcons();

            CultureInfo cinfo = CultureInfo.InstalledUICulture;

            void DefaultLang()
            {
                button7.Text = "en-US";
                groupBox1.Text = "Performance Tweaks ("+panel1.Controls.OfType<CheckBox>().Count()+")";
                groupBox2.Text = "Privacy (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                groupBox3.Text = "Visual Tweaks (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                groupBox4.Text = "Other (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                groupBox5.Text = "Expert Mode (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                button1.Text = "Performance";
                button2.Text = "Visual";
                button3.Text = "Privacy";
                selectall0 = "Select All";
                selectall1 = "Unselect All";

                button5.Text = "Start";

                button4.Text = "Select All";
                button4.Font = new Font("Consolas", 13, FontStyle.Regular);

                toolStripButton2.Text = "Backup";
                toolStripDropDownButton2.Text = "Restore";
                registryRestoreToolStripMenuItem.Text = "Registry Restore";
                restorePointToolStripMenuItem.Text = "Restore Point";
                toolStripButton3.Text = "About";
                toolStripButton4.Text = "Donate";

                button1.Font = new Font("Consolas", 13, FontStyle.Regular);
                button2.Font = new Font("Consolas", 13, FontStyle.Regular);
                button3.Font = new Font("Consolas", 13, FontStyle.Regular);
                button4.Font = new Font("Consolas", 13, FontStyle.Regular);
                button5.Font = new Font("Consolas", 13, FontStyle.Regular);
                panel1.Font = new Font("Consolas", 9, FontStyle.Regular);
                panel2.Font = new Font("Consolas", 9, FontStyle.Regular);
                panel3.Font = new Font("Consolas", 9, FontStyle.Regular);
                panel4.Font = new Font("Consolas", 9, FontStyle.Regular);
                panel5.Font = new Font("Consolas", 9, FontStyle.Regular);
                groupBox1.Font = new Font("Consolas", 12, FontStyle.Bold);
                groupBox2.Font = new Font("Consolas", 12, FontStyle.Bold);
                groupBox3.Font = new Font("Consolas", 12, FontStyle.Bold);
                groupBox4.Font = new Font("Consolas", 12, FontStyle.Bold);
                groupBox5.Font = new Font("Consolas", 12, FontStyle.Bold);
                toolStrip1.Font = new Font("Consolas", 9, FontStyle.Regular);

                msgend = "Everything has been done. Reboot is recommended.";
                msgerror = "No option selected.";
                msgupdate = "A newer version of the application is available on GitHub!";
                isoinfo = "The generated ISO image will contain the following features: ET-Optimizer.exe /auto and bypassing Microsoft requirements by bypassing data collection, local account creation, etc.";

                rebootToSafeModeToolStripMenuItem.Text = "Reboot to Safe Mode";
                restartExplorerexeToolStripMenuItem.Text = "Restart Explorer.exe";
                downloadSoftwareToolStripMenuItem.Text = "Download Software";
                toolStripDropDownButton1.Text = "Extras";
                diskDefragmenterToolStripMenuItem.Text = "Disk Defragmenter";
                controlPanelToolStripMenuItem.Text = "Control Panel";
                deviceManagerToolStripMenuItem.Text = "Device Manager";
                uACSettingsToolStripMenuItem.Text = "UAC Settings";
                servicesToolStripMenuItem.Text = "Services";
                remoteDesktopToolStripMenuItem.Text = "Remote Desktop";
                eventViewerToolStripMenuItem.Text = "Event Viewer";
                resetNetworkToolStripMenuItem.Text = "Reset Network";
                updateApplicationsToolStripMenuItem.Text = "Update Applications";
                windowsLicenseKeyToolStripMenuItem.Text = "Windows License Key";
                rebootToBIOSToolStripMenuItem.Text = "Reboot to BIOS";
                makeETISOToolStripMenuItem.Text = "Make ET-Optimized .ISO";

                chck1.Text = "Disable Edge WebWidget";
                chck2.Text = "Power Option to Ultimate Perform.";
                chck3.Text = "Split Threshold for Svchost";
                chck4.Text = "Dual Boot Timeout 3sec";
                chck5.Text = "Disable Hibernation/Fast Startup";
                chck6.Text = "Disable Windows Insider Experiments";
                chck7.Text = "Disable App Launch Tracking";
                chck8.Text = "Disable Powerthrottling (Intel 6gen+)";
                chck9.Text = "Turn Off Background Apps";
                chck10.Text = "Disable Sticky Keys Prompt";
                chck11.Text = "Disable Activity History";
                chck12.Text = "Disable Updates for MS Store Apps";
                chck13.Text = "SmartScreen Filter for Apps Disable";
                chck14.Text = "Let Websites Provide Locally";
                chck15.Text = "Fix Microsoft Edge Settings";
                chck64.Text = "Disable Nagle's Alg. (Delayed ACKs)";
                chck65.Text = "CPU/GPU Priority Tweaks";
                chck16.Text = "Disable Location Sensors";
                chck17.Text = "Disable WiFi HotSpot Auto-Sharing";
                chck18.Text = "Disable Shared HotSpot Connect";
                chck19.Text = "Updates Notify to Sched. Restart";
                chck20.Text = "P2P Update Setting to LAN (local)";
                chck21.Text = "Set Lower Shutdown Time (2sec)";
                chck22.Text = "Remove Old Device Drivers";
                chck23.Text = "Disable Get Even More Out of...";
                chck24.Text = "Disable Installing Suggested Apps";
                chck25.Text = "Disable Start Menu Ads/Suggest";
                chck26.Text = "Disable Suggest Apps WindowsInk";
                chck27.Text = "Disable Unnecessary Components";
                chck28.Text = "Defender Scheduled Scan Nerf";
                chck29.Text = "Disable Process Mitigation";
                chck30.Text = "Defragment Indexing Service File";
                chck66.Text = "Disable Spectre/Meltdown";
                chck67.Text = "Disable Windows Defender";
                chck31.Text = "Disable Telemetry Scheduled Tasks";
                chck32.Text = "Remove Telemetry/Data Collection";
                chck33.Text = "Disable PowerShell Telemetry";
                chck34.Text = "Disable Skype Telemetry";
                chck35.Text = "Disable Media Player Usage Reports";
                chck36.Text = "Disable Mozilla Telemetry";
                chck37.Text = "Disable Apps Use My Advertising ID";
                chck38.Text = "Disable Send Info About Writing";
                chck39.Text = "Disable Handwriting Recognition";
                chck40.Text = "Disable Watson Malware Reports";
                chck41.Text = "Disable Malware Diagnostic Data";
                chck42.Text = "Disable Reporting to MS MAPS";
                chck43.Text = "Disable Spynet Defender Reporting";
                chck44.Text = "Do Not Send Malware Samples";
                chck45.Text = "Disable Sending Typing Samples";
                chck46.Text = "Disable Sending Contacts to MS";
                chck47.Text = "Disable Cortana";
                chck48.Text = "Show File Extensions in Explorer";
                chck49.Text = "Disable Transparency on Taskbar";
                chck50.Text = "Disable Windows Animations";
                chck51.Text = "Disable MRU lists (jump lists)";
                chck52.Text = "Set Search Box to Icon Only";
                chck53.Text = "Explorer on Start on This PC";
                chck54.Text = "Remove Windows Game Bar/DVR";
                chck55.Text = "Enable Service Tweaks";
                chck56.Text = "Remove Bloatware (Preinstalled)";
                chck57.Text = "Disable Unnecessary Startup Apps";
                chck58.Text = "Clean Temp/Cache/Prefetch/Logs";
                chck59.Text = "Remove News and Interests/Widgets";
                chck60.Text = "Remove Microsoft OneDrive";
                chck61.Text = "Disable Xbox Services";
                chck62.Text = "Enable Fast/Secure DNS (1.1.1.1)";
                chck63.Text = "Scan for Adware (AdwCleaner)";
                chck68.Text = "Clean WinSxS Folder";
                chck69.Text = "Remove Copilot";
                chck70.Text = "Remove Learn about this photo";
                chck71.Text = "Enable Long System Paths";
                chck72.Text = "Enable Old Context Menu";
                chck73.Text = "Disable Fullscreen Optimizations";
                chck74.Text = "Enable RAM Memory Tweaks";
                chck75.Text = "Block Telemetry/User experience hosts";
                chck76.Text = "Block location data sharing hosts";
                chck77.Text = "Block Windows crash report hosts";
                chck78.Text = "Disable Logon Background Image";

                tooltip.SetToolTip(chck1, "Disables the Edge WebWidget to reduce background resource usage and free up memory.");
                tooltip.SetToolTip(chck2, "Switches Windows power plan to Ultimate Performance for better system responsiveness.");
                tooltip.SetToolTip(chck3, "Allows services to run in separate svchost processes, improving system stability.");
                tooltip.SetToolTip(chck4, "Shortens dual boot menu timeout to 3 seconds for faster startup.");
                tooltip.SetToolTip(chck5, "Disables hibernation and fast startup to free disk space and improve shutdown behavior.");
                tooltip.SetToolTip(chck6, "Turns off experimental features pushed via the Windows Insider program.");
                tooltip.SetToolTip(chck7, "Prevents Windows from tracking which apps you open to protect privacy.");
                tooltip.SetToolTip(chck8, "Disables CPU power throttling (Intel 6th gen and newer) for full performance.");
                tooltip.SetToolTip(chck9, "Prevents background apps from running to improve performance and battery life.");
                tooltip.SetToolTip(chck10, "Disables Sticky Keys pop-ups that appear when pressing Shift or Ctrl repeatedly.");
                tooltip.SetToolTip(chck11, "Stops Windows from recording your activity history, protecting privacy.");
                tooltip.SetToolTip(chck12, "Prevents Microsoft Store apps from updating automatically in the background.");
                tooltip.SetToolTip(chck13, "Turns off the SmartScreen filter for apps, which checks unknown programs.");
                tooltip.SetToolTip(chck14, "Blocks websites from requesting your physical location for privacy.");
                tooltip.SetToolTip(chck15, "Resets Edge browser settings to default to fix broken configuration.");
                tooltip.SetToolTip(chck16, "Disables all location sensors and services in Windows for maximum privacy.");
                tooltip.SetToolTip(chck17, "Prevents Windows from automatically sharing your Wi-Fi hotspot with others.");
                tooltip.SetToolTip(chck18, "Blocks connections to shared hotspots by others, reducing security risks.");
                tooltip.SetToolTip(chck19, "Makes Windows notify before restarting after updates instead of doing it automatically.");
                tooltip.SetToolTip(chck20, "Limits Windows Update's peer-to-peer sharing to your local network only.");
                tooltip.SetToolTip(chck21, "Reduces the system shutdown delay to speed up power-off time.");
                tooltip.SetToolTip(chck22, "Deletes unused device drivers that take up unnecessary disk space.");
                tooltip.SetToolTip(chck23, "Removes the 'Get even more out of Windows' setup prompt after login.");
                tooltip.SetToolTip(chck24, "Disables the automatic installation of suggested or sponsored apps.");
                tooltip.SetToolTip(chck25, "Removes app ads and suggestions from the Start Menu to declutter it.");
                tooltip.SetToolTip(chck26, "Disables application suggestions in Windows Ink Workspace.");
                tooltip.SetToolTip(chck27, "Turns off legacy or unused Windows components that are rarely needed.");
                tooltip.SetToolTip(chck28, "Lowers Defender’s scheduled scan priority to reduce performance impact.");
                tooltip.SetToolTip(chck29, "Disables some system mitigations for processes to boost performance (use with caution).");
                tooltip.SetToolTip(chck30, "Defragments the indexing service file to improve search performance.");
                tooltip.SetToolTip(chck31, "Disables scheduled tasks related to Microsoft telemetry data collection.");
                tooltip.SetToolTip(chck32, "Removes telemetry services and tracking components from the system.");
                tooltip.SetToolTip(chck33, "Prevents PowerShell from sending usage data to Microsoft.");
                tooltip.SetToolTip(chck34, "Blocks Skype from collecting and sending telemetry data.");
                tooltip.SetToolTip(chck35, "Disables Windows Media Player’s usage tracking reports.");
                tooltip.SetToolTip(chck36, "Turns off Firefox’s built-in telemetry features.");
                tooltip.SetToolTip(chck37, "Prevents apps from using your advertising ID for personalized ads.");
                tooltip.SetToolTip(chck38, "Stops Windows from collecting info about your writing and typing behavior.");
                tooltip.SetToolTip(chck39, "Disables handwriting input recognition and its data collection.");
                tooltip.SetToolTip(chck40, "Blocks automatic malware reports from being sent to Microsoft.");
                tooltip.SetToolTip(chck41, "Prevents Defender from sending diagnostic info about threats.");
                tooltip.SetToolTip(chck42, "Disables submissions to Microsoft MAPS cloud protection service.");
                tooltip.SetToolTip(chck43, "Blocks Windows Defender's 'Spynet' reporting service.");
                tooltip.SetToolTip(chck44, "Prevents automatic submission of suspicious files to Microsoft.");
                tooltip.SetToolTip(chck45, "Blocks collection of keyboard usage data used for text prediction.");
                tooltip.SetToolTip(chck46, "Stops Windows from syncing or sharing your contact information.");
                tooltip.SetToolTip(chck47, "Completely disables Cortana voice assistant and related services.");
                tooltip.SetToolTip(chck48, "Forces Windows to show file extensions for known file types in Explorer.");
                tooltip.SetToolTip(chck49, "Turns off taskbar transparency to reduce GPU usage slightly.");
                tooltip.SetToolTip(chck50, "Disables animations in the UI for a faster and snappier experience.");
                tooltip.SetToolTip(chck51, "Prevents Windows from keeping recent items lists (Jump Lists).");
                tooltip.SetToolTip(chck52, "Changes the Start Menu search box into a compact icon.");
                tooltip.SetToolTip(chck53, "Sets File Explorer to open on 'This PC' instead of 'Quick Access'.");
                tooltip.SetToolTip(chck54, "Removes Xbox Game Bar and DVR background services.");
                tooltip.SetToolTip(chck55, "Applies recommended tweaks to speed up and optimize Windows services.");
                tooltip.SetToolTip(chck56, "Removes preinstalled apps that are unnecessary or considered bloatware.");
                tooltip.SetToolTip(chck57, "Disables unnecessary programs that auto-start with Windows.");
                tooltip.SetToolTip(chck58, "Cleans system cache, temp files, prefetch data, and old logs.");
                tooltip.SetToolTip(chck59, "Removes 'News and Interests' or Widgets panel from the taskbar.");
                tooltip.SetToolTip(chck60, "Completely removes OneDrive from the system, including background sync.");
                tooltip.SetToolTip(chck61, "Turns off Xbox services that are not needed unless you're gaming.");
                tooltip.SetToolTip(chck62, "Sets system DNS to Cloudflare (1.1.1.1) for better speed and privacy.");
                tooltip.SetToolTip(chck63, "Launches AdwCleaner to scan and remove adware from the system.");
                tooltip.SetToolTip(chck64, "Disables Nagle’s algorithm to reduce latency and improve online gaming.");
                tooltip.SetToolTip(chck65, "Optimizes CPU and GPU scheduling for maximum foreground app performance.");
                tooltip.SetToolTip(chck66, "Disables Spectre/Meltdown protections for higher speed (reduces security).");
                tooltip.SetToolTip(chck67, "Fully disables Windows Defender antivirus and all its services.");
                tooltip.SetToolTip(chck68, "Cleans up the WinSxS folder to reclaim disk space from old system files.");
                tooltip.SetToolTip(chck69, "Removes the new Copilot AI assistant from Windows.");
                tooltip.SetToolTip(chck70, "Disables the 'Learn about this photo' feature shown on lock screen.");
                tooltip.SetToolTip(chck71, "Allows Windows to work with long file paths over 260 characters.");
                tooltip.SetToolTip(chck72, "Restores the classic right-click context menu from Windows 10.");
                tooltip.SetToolTip(chck73, "Disables fullscreen optimizations that may interfere with game performance.");
                tooltip.SetToolTip(chck74, "Applies tweaks to improve RAM usage and system responsiveness.");
                tooltip.SetToolTip(chck75, "Blocks known Microsoft telemetry and user experience tracking domains.");
                tooltip.SetToolTip(chck76, "Blocks hostnames related to location data sharing with Microsoft.");
                tooltip.SetToolTip(chck77, "Prevents the system from sending crash reports to Microsoft servers.");



                toolStripLabel1.Text = "Build: Public | " + ETBuild;
            }
            DefaultLang();

            void ChangeLang()
            {

                if (cinfo.Name == "pl-PL")
                {
                    button7.Text = "pl-PL";
                    Console.WriteLine("Wykryto Polski");
                    groupBox1.Text = "Poprawki Wydajności (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Prywatność (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Poprawki Wizualne (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Inne (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Tryb Eksperta (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "Wydajność";
                    button2.Text = "Wizualne";
                    button3.Text = "Prywatność";
                    selectall0 = "Zaznacz Wszystko";
                    selectall1 = "Odznacz Wszystko";

                    button4.Text = "Zaznacz Wszystko";
                    button4.Font = new Font("Consolas", 12, FontStyle.Regular);

                    toolStripButton2.Text = "Kopia Zapasowa";
                    toolStripDropDownButton2.Text = "Przywracanie";
                    registryRestoreToolStripMenuItem.Text = "Przywracanie rejestru";
                    restorePointToolStripMenuItem.Text = "Punkt przywracania";
                    toolStripButton3.Text = "O mnie";
                    toolStripButton4.Text = "Wesprzyj";

                    rebootToSafeModeToolStripMenuItem.Text = "Uruchom w Trybie Awaryjnym";
                    restartExplorerexeToolStripMenuItem.Text = "Restart Explorer.exe";
                    downloadSoftwareToolStripMenuItem.Text = "Pobierz Oprogramowanie";
                    toolStripDropDownButton1.Text = "Dodatki";
                    diskDefragmenterToolStripMenuItem.Text = "Defragmentacja Dysku";
                    controlPanelToolStripMenuItem.Text = "Panel Sterowania";
                    deviceManagerToolStripMenuItem.Text = "Menedżer Urządzeń";
                    uACSettingsToolStripMenuItem.Text = "Ustawienia UAC";
                    servicesToolStripMenuItem.Text = "Usługi";
                    remoteDesktopToolStripMenuItem.Text = "Pulpit Zdalny";
                    eventViewerToolStripMenuItem.Text = "Podgląd Zdarzeń";
                    resetNetworkToolStripMenuItem.Text = "Reset Ustawień Sieci";
                    updateApplicationsToolStripMenuItem.Text = "Aktualizuj Aplikacje";
                    windowsLicenseKeyToolStripMenuItem.Text = "Pokaż Klucz Windows";
                    rebootToBIOSToolStripMenuItem.Text = "Uruchom do BIOSu";
                    makeETISOToolStripMenuItem.Text = "Stwórz Zoptymalizowane .ISO z ET";

                    msgend = "Zakończono. Zalecane jest ponowne uruchomienie.";
                    msgerror = "Nie wybrano żadnej opcji.";
                    msgupdate = "Jest nowsza wersja aplikacji na GitHubie!";
                    isoinfo = "Generowany obraz ISO będzie zawierał następujące funkcje: ET-Optimizer.exe /auto oraz pominięcie wymagań Microsoftu poprzez ominięcie zbierania danych, tworzenia konta lokalnego itp.";

                    toolStripLabel1.Text = "Wersja: Publiczna | " + ETBuild;

                    chck1.Text = "Wyłącz WebWidget Edge";
                    chck2.Text = "Opcja zasilania: Max wydajność";
                    chck3.Text = "Podział progowy dla Svchost";
                    chck4.Text = "Czas dual boot - 3 sekundy";
                    chck5.Text = "Wyłącz hibernację/fastboot";
                    chck6.Text = "Wyłącz eksperymenty Windows Insider";
                    chck7.Text = "Wyłącz śledzenie startu aplikacji";
                    chck8.Text = "Wyłącz Powerthrottling (6gen+)";
                    chck9.Text = "Wyłącz aplikacje działające w tle";
                    chck10.Text = "Wyłącz komunikat klawisze trwałe";
                    chck11.Text = "Wyłącz historię aktywności";
                    chck12.Text = "Wyłącz aktualizacje Sklepu MS";
                    chck13.Text = "Wyłącz SmartScreen dla aplikacji";
                    chck14.Text = "Witryny dostarczają dane lokalnie";
                    chck15.Text = "Napraw ustawienia Microsoft Edge";
                    chck64.Text = "Wyłącz algorytm Nagla (ACK)";
                    chck65.Text = "Dostosowanie priorytetów CPU/GPU";
                    chck16.Text = "Wyłącz czujniki lokalizacji";
                    chck17.Text = "Wyłącz automatyczny HotSpot";
                    chck18.Text = "Wyłącz współdzielenie połącz.";
                    chck19.Text = "Powiadomienia o aktualizacjach";
                    chck20.Text = "Udost. aktualizacji - lokalnie";
                    chck21.Text = "Skróć czas zamykania systemu";
                    chck22.Text = "Usuń stare sterowniki urządzeń";
                    chck23.Text = "Wyłącz Uzyskaj jeszcze więcej od";
                    chck24.Text = "Wyłącz sugerowane aplikacje";
                    chck25.Text = "Wyłącz reklamy/sugestie w Start";
                    chck26.Text = "Wyłącz sugestie Windows Ink";
                    chck27.Text = "Wyłącz zbędne komponenty";
                    chck28.Text = "Ogranicz zaplan. skany Defendera";
                    chck29.Text = "Wyłącz process Mitigation";
                    chck30.Text = "Defragmentacja pliku indeksowania";
                    chck66.Text = "Wyłącz zabez. Spectre/Meltdown";
                    chck67.Text = "Wyłącz Windows Defender";
                    chck31.Text = "Wyłącz zaplan. zadania telemetrii";
                    chck32.Text = "Usuń zbieranie danych/telemetrii";
                    chck33.Text = "Wyłącz telemetrię PowerShell";
                    chck34.Text = "Wyłącz telemetrię Skype";
                    chck35.Text = "Wyłącz raporty Media Playera";
                    chck36.Text = "Wyłącz telemetrię Mozilla";
                    chck37.Text = "Wyłącz używanie mojego ID reklamowego";
                    chck38.Text = "Wyłącz wysyłanie inform. o pisaniu";
                    chck39.Text = "Wyłącz rozpoznawanie pisma";
                    chck40.Text = "Wyłącz raporty Watsona o malware";
                    chck41.Text = "Wyłącz diagnost. dane o malware";
                    chck42.Text = "Wyłącz raportowanie do MS MAPS";
                    chck43.Text = "Wyłącz raportowanie do Spynet";
                    chck44.Text = "Nie wysyłaj próbek malware";
                    chck45.Text = "Wyłącz wysyłanie próbek pisania";
                    chck46.Text = "Wyłącz wysyłanie kontaktów do MS";
                    chck47.Text = "Wyłącz Cortanę";
                    chck48.Text = "Pokaż rozszerzenia plików";
                    chck49.Text = "Wyłącz przezroczystość na pasku";
                    chck50.Text = "Wyłącz animacje Windows";
                    chck51.Text = "Wyłącz listy szybkiego dostępu";
                    chck52.Text = "Ustaw pole wyszukiwania na ikonę";
                    chck53.Text = "Otwieraj domyśl. na Ten komputer";
                    chck54.Text = "Usuń Pasek Gier Windows/DVR";
                    chck55.Text = "Włącz optymalizację usług";
                    chck56.Text = "Usuń zbędne oprogram. (Bloatware)";
                    chck57.Text = "Wyłącz zbędne aplikacje startowe";
                    chck58.Text = "Wyczyść Temp/Cache/Prefetch/Logi";
                    chck59.Text = "Usuń Wiadomości i Zaint./Widżety";
                    chck60.Text = "Usuń Microsoft OneDrive";
                    chck61.Text = "Wyłącz usługi Xbox";
                    chck62.Text = "Włącz szybki/bezpieczny DNS";
                    chck63.Text = "Skanowanie AdwCleaner";
                    chck68.Text = "Wyczyść folder WinSxS";
                    chck69.Text = "Usuń Copilot";
                    chck70.Text = "Wyłącz Dowiedz się o tym zdjęciu";
                    chck71.Text = "Włącz długie ścieżki systemowe";
                    chck72.Text = "Włącz stare menu kontekstowe";
                    chck73.Text = "Wył. optymalizacje pełnoekranowe";
                    chck74.Text = "Włącz optymalizacje pamięci RAM";
                    chck75.Text = "Blokuj hosty telemetry/UX";
                    chck76.Text = "Blokuj hosty lokalizacji";
                    chck77.Text = "Blokuj hosty raportów awarii";
                    chck78.Text = "Wyłącz tło ekranu logowania";

                    tooltip.SetToolTip(chck1, "Wyłącza Edge WebWidget, aby zmniejszyć użycie zasobów i pamięci.");
                    tooltip.SetToolTip(chck2, "Ustawia plan zasilania Windows na Ultimate Performance dla lepszej responsywności.");
                    tooltip.SetToolTip(chck3, "Pozwala usługom działać w oddzielnych procesach svchost, poprawiając stabilność.");
                    tooltip.SetToolTip(chck4, "Skraca czas oczekiwania w menu rozruchu do 3 sekund dla szybszego startu.");
                    tooltip.SetToolTip(chck5, "Wyłącza hibernację i szybkie uruchamianie, zwalniając miejsce na dysku.");
                    tooltip.SetToolTip(chck6, "Wyłącza funkcje eksperymentalne z programu Windows Insider.");
                    tooltip.SetToolTip(chck7, "Zatrzymuje śledzenie przez system, które aplikacje otwierasz.");
                    tooltip.SetToolTip(chck8, "Wyłącza ograniczanie mocy CPU (dla Intel 6. gen i nowszych) – pełna wydajność.");
                    tooltip.SetToolTip(chck9, "Zatrzymuje działanie aplikacji w tle, poprawiając wydajność i oszczędność energii.");
                    tooltip.SetToolTip(chck10, "Wyłącza wyskakujące okienka z klawiszami trwałymi (Sticky Keys).");
                    tooltip.SetToolTip(chck11, "Blokuje zapisywanie historii aktywności w systemie Windows.");
                    tooltip.SetToolTip(chck12, "Zatrzymuje automatyczne aktualizacje aplikacji ze sklepu Microsoft Store.");
                    tooltip.SetToolTip(chck13, "Wyłącza filtr SmartScreen dla aplikacji, który sprawdza nieznane programy.");
                    tooltip.SetToolTip(chck14, "Blokuje dostęp stron internetowych do Twojej lokalizacji.");
                    tooltip.SetToolTip(chck15, "Resetuje ustawienia przeglądarki Edge do domyślnych.");
                    tooltip.SetToolTip(chck16, "Wyłącza czujniki i usługi lokalizacji – maksymalna prywatność.");
                    tooltip.SetToolTip(chck17, "Zabrania automatycznego udostępniania Twojego hotspotu Wi-Fi.");
                    tooltip.SetToolTip(chck18, "Blokuje połączenia z udostępnionymi hotspotami – zwiększa bezpieczeństwo.");
                    tooltip.SetToolTip(chck19, "Wymusza powiadomienia przed restartem po aktualizacjach.");
                    tooltip.SetToolTip(chck20, "Ogranicza współdzielenie aktualizacji tylko do sieci lokalnej.");
                    tooltip.SetToolTip(chck21, "Skraca czas zamykania systemu – szybsze wyłączanie.");
                    tooltip.SetToolTip(chck22, "Usuwa nieużywane sterowniki urządzeń, zwalniając miejsce.");
                    tooltip.SetToolTip(chck23, "Usuwa ekran powitalny 'Wydobądź więcej z systemu Windows'.");
                    tooltip.SetToolTip(chck24, "Blokuje instalowanie sugerowanych i sponsorowanych aplikacji.");
                    tooltip.SetToolTip(chck25, "Usuwa reklamy i sugestie z menu Start.");
                    tooltip.SetToolTip(chck26, "Wyłącza sugestie aplikacji w obszarze Windows Ink.");
                    tooltip.SetToolTip(chck27, "Wyłącza nieużywane składniki systemu Windows.");
                    tooltip.SetToolTip(chck28, "Zmniejsza priorytet skanów Defendera – mniej wpływu na wydajność.");
                    tooltip.SetToolTip(chck29, "Wyłącza niektóre zabezpieczenia procesów – zwiększa wydajność (ostrożnie!).");
                    tooltip.SetToolTip(chck30, "Defragmentuje plik indeksowania – szybsze wyszukiwanie.");
                    tooltip.SetToolTip(chck31, "Wyłącza zadania zaplanowane związane z telemetrią.");
                    tooltip.SetToolTip(chck32, "Usuwa usługi i komponenty zbierające dane telemetryczne.");
                    tooltip.SetToolTip(chck33, "Blokuje PowerShell przed wysyłaniem danych do Microsoftu.");
                    tooltip.SetToolTip(chck34, "Blokuje Skype przed zbieraniem i wysyłaniem danych telemetrycznych.");
                    tooltip.SetToolTip(chck35, "Wyłącza raporty o użyciu Windows Media Player.");
                    tooltip.SetToolTip(chck36, "Wyłącza wbudowaną telemetrię w przeglądarce Firefox.");
                    tooltip.SetToolTip(chck37, "Blokuje aplikacjom dostęp do Twojego identyfikatora reklamowego.");
                    tooltip.SetToolTip(chck38, "Zatrzymuje zbieranie informacji o Twoim stylu pisania.");
                    tooltip.SetToolTip(chck39, "Wyłącza rozpoznawanie pisma odręcznego i jego analizę.");
                    tooltip.SetToolTip(chck40, "Blokuje automatyczne raporty o złośliwym oprogramowaniu do Microsoftu.");
                    tooltip.SetToolTip(chck41, "Blokuje Defendera przed wysyłaniem danych diagnostycznych o zagrożeniach.");
                    tooltip.SetToolTip(chck42, "Wyłącza zgłaszanie do chmurowego systemu MAPS od Microsoftu.");
                    tooltip.SetToolTip(chck43, "Blokuje usługę raportowania Spynet w Windows Defender.");
                    tooltip.SetToolTip(chck44, "Zatrzymuje automatyczne wysyłanie podejrzanych plików do Microsoftu.");
                    tooltip.SetToolTip(chck45, "Blokuje zbieranie danych o wprowadzaniu tekstu przez klawiaturę.");
                    tooltip.SetToolTip(chck46, "Zatrzymuje synchronizację i udostępnianie Twoich kontaktów.");
                    tooltip.SetToolTip(chck47, "Całkowicie wyłącza asystenta głosowego Cortana.");
                    tooltip.SetToolTip(chck48, "Wymusza wyświetlanie rozszerzeń plików w Eksploratorze.");
                    tooltip.SetToolTip(chck49, "Wyłącza przezroczystość paska zadań – mniejsze zużycie GPU.");
                    tooltip.SetToolTip(chck50, "Wyłącza animacje interfejsu – przyspiesza reakcje systemu.");
                    tooltip.SetToolTip(chck51, "Blokuje zapisywanie ostatnio używanych elementów (Jump Lists).");
                    tooltip.SetToolTip(chck52, "Zmienia pole wyszukiwania menu Start na samą ikonę.");
                    tooltip.SetToolTip(chck53, "Ustawia Eksplorator plików, aby otwierał się na 'Ten komputer'.");
                    tooltip.SetToolTip(chck54, "Usuwa pasek gier Xbox i usługi DVR działające w tle.");
                    tooltip.SetToolTip(chck55, "Stosuje bezpieczne optymalizacje usług Windows.");
                    tooltip.SetToolTip(chck56, "Usuwa fabrycznie zainstalowane aplikacje (bloatware).");
                    tooltip.SetToolTip(chck57, "Wyłącza zbędne programy startujące z systemem.");
                    tooltip.SetToolTip(chck58, "Czyści pamięć podręczną, pliki tymczasowe i logi systemowe.");
                    tooltip.SetToolTip(chck59, "Usuwa panel 'Wiadomości i zainteresowania' z paska zadań.");
                    tooltip.SetToolTip(chck60, "Całkowicie usuwa OneDrive z systemu, wraz z synchronizacją.");
                    tooltip.SetToolTip(chck61, "Wyłącza usługi Xbox – zalecane, jeśli nie grasz.");
                    tooltip.SetToolTip(chck62, "Ustawia szybki i bezpieczny DNS od Cloudflare (1.1.1.1).");
                    tooltip.SetToolTip(chck63, "Uruchamia AdwCleaner do wykrywania i usuwania adware.");
                    tooltip.SetToolTip(chck64, "Wyłącza algorytm Nagle’a – zmniejsza opóźnienia w grach online.");
                    tooltip.SetToolTip(chck65, "Optymalizuje zarządzanie CPU i GPU dla lepszej wydajności aplikacji.");
                    tooltip.SetToolTip(chck66, "Wyłącza zabezpieczenia Spectre/Meltdown – zwiększa wydajność (mniej bezpieczne).");
                    tooltip.SetToolTip(chck67, "Całkowicie wyłącza program antywirusowy Windows Defender.");
                    tooltip.SetToolTip(chck68, "Czyści folder WinSxS – odzyskuje miejsce zajęte przez stare pliki systemowe.");
                    tooltip.SetToolTip(chck69, "Usuwa asystenta AI Copilot z systemu Windows.");
                    tooltip.SetToolTip(chck70, "Wyłącza funkcję 'Dowiedz się więcej o tym zdjęciu' na ekranie blokady.");
                    tooltip.SetToolTip(chck71, "Umożliwia korzystanie z długich ścieżek plików (>260 znaków).");
                    tooltip.SetToolTip(chck72, "Przywraca klasyczne menu kontekstowe (jak w Windows 10).");
                    tooltip.SetToolTip(chck73, "Wyłącza optymalizacje pełnoekranowe – lepsza płynność w grach.");
                    tooltip.SetToolTip(chck74, "Wprowadza poprawki zwiększające wydajność pamięci RAM.");
                    tooltip.SetToolTip(chck75, "Blokuje znane adresy telemetryczne i śledzące Microsoftu.");
                    tooltip.SetToolTip(chck76, "Blokuje hosty udostępniające dane o lokalizacji.");
                    tooltip.SetToolTip(chck77, "Zatrzymuje wysyłanie raportów o awariach do Microsoftu.");

                }

                if (cinfo.Name == "ru-RU" || cinfo.Name == "be-BY")
                {
                    button7.Text = "ru-RU";
                    Console.WriteLine("Russian detected");
                    groupBox1.Text = "Настройки производительности (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Конфиденциальность (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Визуальные настройки (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Другие (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Экспертный режим (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "Производительность";
                    button1.Font = new Font("Consolas", 12, FontStyle.Regular);
                    button2.Text = "Визуальные настройки";
                    button2.Font = new Font("Consolas", 12, FontStyle.Regular);
                    button3.Text = "Конфиденциальность";
                    button3.Font = new Font("Consolas", 12, FontStyle.Regular);
                    button5.Text = "Применить";
                    selectall0 = "Выбрать все";
                    selectall1 = "Отменить всё";

                    button4.Text = "Выбрать все";
                    button4.Font = new Font("Consolas", 13, FontStyle.Regular);

                    toolStripButton2.Text = "Резервная копия";
                    toolStripDropDownButton2.Text = "Восстановление";
                    registryRestoreToolStripMenuItem.Text = "Восстановление реестра";
                    restorePointToolStripMenuItem.Text = "Точка восстановления";
                    toolStripButton3.Text = "О программе";
                    toolStripButton4.Text = "Пожертвовать";
                    rebootToSafeModeToolStripMenuItem.Text = "Загрузитесь в безопасном режиме";
                    restartExplorerexeToolStripMenuItem.Text = "Перезапустите Explorer.exe";
                    downloadSoftwareToolStripMenuItem.Text = "Загрузите программу";
                    toolStripDropDownButton1.Text = "Дополнительно";
                    diskDefragmenterToolStripMenuItem.Text = "Дефрагментация диска";
                    controlPanelToolStripMenuItem.Text = "Панель управления";
                    deviceManagerToolStripMenuItem.Text = "Диспетчер устройств";
                    uACSettingsToolStripMenuItem.Text = "Настройки UAC";
                    servicesToolStripMenuItem.Text = "Услуги";
                    remoteDesktopToolStripMenuItem.Text = "Удаленный рабочий стол";
                    eventViewerToolStripMenuItem.Text = "Просмотр событий";
                    resetNetworkToolStripMenuItem.Text = "Сброс сетевых настроек";
                    updateApplicationsToolStripMenuItem.Text = "Обновление приложений";
                    windowsLicenseKeyToolStripMenuItem.Text = "Показать лицензионный ключ Windows";
                    rebootToBIOSToolStripMenuItem.Text = "Запуск BIOS";
                    makeETISOToolStripMenuItem.Text = "Сделать ET-оптимизированный .ISO";

                    msgend = "Завершено. Рекомендуется перезапуск.";
                    msgerror = "Ни один вариант не был выбран.";
                    msgupdate = "На GitHub доступна более новая версия приложения!";
                    isoinfo = "Сгенерированный ISO-файл будет включать следующие функции: ET-Optimizer.exe /auto, а также обход требований Microsoft путём пропуска сбора данных, создания локальной учётной записи и т. д.";

                    toolStripLabel1.Text = "Build: Public | " + ETBuild;

                    chck1.Text = "Отключить виджет Edge WebWidget";
                    chck2.Text = "Энергопитание: максимальная производительность";
                    chck3.Text = "Порог разделения процессов Svchost";
                    chck4.Text = "Время двойной загрузки — 3 секунды";
                    chck5.Text = "Отключить гибернацию / быструю загрузку";
                    chck6.Text = "Отключить эксперименты Windows Insider";
                    chck7.Text = "Отключить отслеживание запуска приложений";
                    chck8.Text = "Отключить PowerThrottling (6-е поколение и выше)";
                    chck9.Text = "Отключить фоновые приложения";
                    chck10.Text = "Отключить уведомление о залипающих клавишах";
                    chck11.Text = "Отключить журнал активности";
                    chck12.Text = "Отключить обновления Microsoft Store";
                    chck13.Text = "Отключить SmartScreen для приложений";
                    chck14.Text = "Сайты предоставляют локальные данные";
                    chck15.Text = "Восстановить настройки Microsoft Edge";
                    chck64.Text = "Отключить алгоритм Nagl (ACK)";
                    chck65.Text = "Настроить приоритеты CPU/GPU";
                    chck16.Text = "Отключить датчики геолокации";
                    chck17.Text = "Отключить автоматический хотспот";
                    chck18.Text = "Отключить совместное подключение";
                    chck19.Text = "Уведомления об обновлениях";
                    chck20.Text = "Раздача обновлений — локально";
                    chck21.Text = "Сократить время выключения системы";
                    chck22.Text = "Удалить старые драйверы устройств";
                    chck23.Text = "Отключить 'Получите ещё больше от...'";
                    chck24.Text = "Отключить рекомендуемые приложения";
                    chck25.Text = "Отключить рекламу/предложения в меню 'Пуск'";
                    chck26.Text = "Отключить предложения Windows Ink";
                    chck27.Text = "Отключить ненужные компоненты";
                    chck28.Text = "Ограничить запланированные сканирования Defender";
                    chck29.Text = "Отключить защиту процессов (Mitigation)";
                    chck30.Text = "Дефрагментация файла индексации";
                    chck66.Text = "Отключить защиту Spectre/Meltdown";
                    chck67.Text = "Отключить Защитник Windows";
                    chck31.Text = "Отключить задачи телеметрии";
                    chck32.Text = "Удалить сбор данных / телеметрию";
                    chck33.Text = "Отключить телеметрию PowerShell";
                    chck34.Text = "Отключить телеметрию Skype";
                    chck35.Text = "Отключить отчёты Windows Media Player";
                    chck36.Text = "Отключить телеметрию Mozilla";
                    chck37.Text = "Отключить рекламный идентификатор";
                    chck38.Text = "Отключить отправку информации о вводе текста";
                    chck39.Text = "Отключить распознавание почерка";
                    chck40.Text = "Отключить отчёты Watson о вредоносных программах";
                    chck41.Text = "Отключить диагностические данные о вредоносном ПО";
                    chck42.Text = "Отключить отчётность в MS MAPS";
                    chck43.Text = "Отключить отчётность в Spynet";
                    chck44.Text = "Не отправлять образцы вредоносных программ";
                    chck45.Text = "Отключить отправку образцов ввода";
                    chck46.Text = "Отключить отправку контактов в Microsoft";
                    chck47.Text = "Отключить Кортану";
                    chck48.Text = "Показать расширения файлов";
                    chck49.Text = "Отключить прозрачность панели задач";
                    chck50.Text = "Отключить анимации Windows";
                    chck51.Text = "Отключить списки быстрого доступа";
                    chck52.Text = "Заменить поле поиска на иконку";
                    chck53.Text = "Открывать проводник в 'Этот компьютер'";
                    chck54.Text = "Удалить игровую панель Windows / DVR";
                    chck55.Text = "Включить оптимизацию служб";
                    chck56.Text = "Удалить лишнее ПО (Bloatware)";
                    chck57.Text = "Отключить лишние автозапускаемые приложения";
                    chck58.Text = "Очистить Temp / Кэш / Prefetch / Логи";
                    chck59.Text = "Удалить Новости и Виджеты";
                    chck60.Text = "Удалить Microsoft OneDrive";
                    chck61.Text = "Отключить службы Xbox";
                    chck62.Text = "Включить быстрый и безопасный DNS";
                    chck63.Text = "Сканирование через AdwCleaner";
                    chck68.Text = "Очистить папку WinSxS";
                    chck69.Text = "Удалить Copilot";
                    chck70.Text = "Отключить 'Узнать об этом изображении'";
                    chck71.Text = "Включить длинные системные пути";
                    chck72.Text = "Включить старое контекстное меню";
                    chck73.Text = "Отключить оптимизации для полноэкранного режима";
                    chck74.Text = "Включить оптимизацию оперативной памяти";
                    chck75.Text = "Блок хостов телеметрии/UX";
                    chck76.Text = "Блок хостов геоданных";
                    chck77.Text = "Блок хостов с отчётами сбоев";
                    chck78.Text = "Отключить фоновое изображение входа";

                    tooltip.SetToolTip(chck1, "Отключает Edge WebWidget для снижения использования ресурсов и памяти.");
                    tooltip.SetToolTip(chck2, "Устанавливает план питания Windows на Ultimate Performance для лучшей отзывчивости.");
                    tooltip.SetToolTip(chck3, "Позволяет службам работать в отдельных процессах svchost, улучшая стабильность.");
                    tooltip.SetToolTip(chck4, "Сокращает время ожидания в меню загрузки до 3 секунд для более быстрого старта.");
                    tooltip.SetToolTip(chck5, "Отключает гибернацию и быстрый запуск, освобождая место на диске.");
                    tooltip.SetToolTip(chck6, "Отключает экспериментальные функции из программы Windows Insider.");
                    tooltip.SetToolTip(chck7, "Останавливает отслеживание системой, какие приложения вы открываете.");
                    tooltip.SetToolTip(chck8, "Отключает ограничение мощности ЦПУ (для Intel 6-го поколения и новее) — полная производительность.");
                    tooltip.SetToolTip(chck9, "Останавливает работу приложений в фоне, улучшая производительность и экономию энергии.");
                    tooltip.SetToolTip(chck10, "Отключает всплывающие окна с залипающими клавишами (Sticky Keys).");
                    tooltip.SetToolTip(chck11, "Блокирует сохранение истории активности в Windows.");
                    tooltip.SetToolTip(chck12, "Останавливает автоматические обновления приложений из Microsoft Store.");
                    tooltip.SetToolTip(chck13, "Отключает фильтр SmartScreen для приложений, проверяющий неизвестные программы.");
                    tooltip.SetToolTip(chck14, "Блокирует доступ веб-сайтов к вашему местоположению.");
                    tooltip.SetToolTip(chck15, "Сбрасывает настройки браузера Edge к значениям по умолчанию.");
                    tooltip.SetToolTip(chck16, "Отключает датчики и службы определения местоположения — максимальная приватность.");
                    tooltip.SetToolTip(chck17, "Запрещает автоматическое совместное использование вашей точки доступа Wi-Fi.");
                    tooltip.SetToolTip(chck18, "Блокирует подключения к общим точкам доступа — повышает безопасность.");
                    tooltip.SetToolTip(chck19, "Принуждает к уведомлениям перед перезагрузкой после обновлений.");
                    tooltip.SetToolTip(chck20, "Ограничивает совместное использование обновлений только локальной сетью.");
                    tooltip.SetToolTip(chck21, "Сокращает время завершения работы системы — быстрее выключение.");
                    tooltip.SetToolTip(chck22, "Удаляет неиспользуемые драйверы устройств, освобождая место.");
                    tooltip.SetToolTip(chck23, "Удаляет приветственный экран 'Получите больше от Windows'.");
                    tooltip.SetToolTip(chck24, "Блокирует установку рекомендованных и спонсируемых приложений.");
                    tooltip.SetToolTip(chck25, "Удаляет рекламу и предложения из меню Пуск.");
                    tooltip.SetToolTip(chck26, "Отключает предложения приложений в области Windows Ink.");
                    tooltip.SetToolTip(chck27, "Отключает неиспользуемые компоненты Windows.");
                    tooltip.SetToolTip(chck28, "Уменьшает приоритет сканирования Defender — меньше влияния на производительность.");
                    tooltip.SetToolTip(chck29, "Отключает некоторые защиты процессов — повышает производительность (осторожно!).");
                    tooltip.SetToolTip(chck30, "Дефрагментирует файл индексирования — ускоряет поиск.");
                    tooltip.SetToolTip(chck31, "Отключает запланированные задачи, связанные с телеметрией.");
                    tooltip.SetToolTip(chck32, "Удаляет службы и компоненты сбора телеметрических данных.");
                    tooltip.SetToolTip(chck33, "Блокирует PowerShell от отправки данных в Microsoft.");
                    tooltip.SetToolTip(chck34, "Блокирует Skype от сбора и отправки телеметрических данных.");
                    tooltip.SetToolTip(chck35, "Отключает отчёты об использовании Windows Media Player.");
                    tooltip.SetToolTip(chck36, "Отключает встроенную телеметрию в браузере Firefox.");
                    tooltip.SetToolTip(chck37, "Блокирует приложениям доступ к вашему рекламному идентификатору.");
                    tooltip.SetToolTip(chck38, "Останавливает сбор информации о вашем стиле печати.");
                    tooltip.SetToolTip(chck39, "Отключает распознавание рукописного ввода и его анализ.");
                    tooltip.SetToolTip(chck40, "Блокирует автоматические отчёты о вредоносном ПО в Microsoft.");
                    tooltip.SetToolTip(chck41, "Блокирует Defender от отправки диагностических данных о угрозах.");
                    tooltip.SetToolTip(chck42, "Отключает отчёты в облачную систему MAPS от Microsoft.");
                    tooltip.SetToolTip(chck43, "Блокирует службу отчётов Spynet в Windows Defender.");
                    tooltip.SetToolTip(chck44, "Останавливает автоматическую отправку подозрительных файлов в Microsoft.");
                    tooltip.SetToolTip(chck45, "Блокирует сбор данных о вводе текста с клавиатуры.");
                    tooltip.SetToolTip(chck46, "Останавливает синхронизацию и совместное использование ваших контактов.");
                    tooltip.SetToolTip(chck47, "Полностью отключает голосового помощника Cortana.");
                    tooltip.SetToolTip(chck48, "Принуждает отображение расширений файлов в Проводнике.");
                    tooltip.SetToolTip(chck49, "Отключает прозрачность панели задач — снижает нагрузку на GPU.");
                    tooltip.SetToolTip(chck50, "Отключает анимации интерфейса — ускоряет отклик системы.");
                    tooltip.SetToolTip(chck51, "Блокирует сохранение недавно использованных элементов (Jump Lists).");
                    tooltip.SetToolTip(chck52, "Меняет поле поиска в меню Пуск на иконку.");
                    tooltip.SetToolTip(chck53, "Настраивает Проводник на открытие на 'Этот компьютер'.");
                    tooltip.SetToolTip(chck54, "Удаляет панель Xbox Game Bar и фоновые службы DVR.");
                    tooltip.SetToolTip(chck55, "Применяет безопасные оптимизации служб Windows.");
                    tooltip.SetToolTip(chck56, "Удаляет предустановленные приложения (bloatware).");
                    tooltip.SetToolTip(chck57, "Отключает ненужные программы автозагрузки.");
                    tooltip.SetToolTip(chck58, "Очищает кэш, временные файлы и системные логи.");
                    tooltip.SetToolTip(chck59, "Удаляет панель 'Новости и интересы' с панели задач.");
                    tooltip.SetToolTip(chck60, "Полностью удаляет OneDrive из системы вместе с синхронизацией.");
                    tooltip.SetToolTip(chck61, "Отключает службы Xbox — рекомендуется, если вы не играете.");
                    tooltip.SetToolTip(chck62, "Настраивает быстрый и безопасный DNS от Cloudflare (1.1.1.1).");
                    tooltip.SetToolTip(chck63, "Запускает AdwCleaner для обнаружения и удаления рекламного ПО.");
                    tooltip.SetToolTip(chck64, "Отключает алгоритм Nagle — уменьшает задержки в онлайн-играх.");
                    tooltip.SetToolTip(chck65, "Оптимизирует управление ЦПУ и GPU для лучшей производительности приложений.");
                    tooltip.SetToolTip(chck66, "Отключает защиты Spectre/Meltdown — повышает производительность (менее безопасно).");
                    tooltip.SetToolTip(chck67, "Полностью отключает антивирус Windows Defender.");
                    tooltip.SetToolTip(chck68, "Очищает папку WinSxS — освобождает место от старых системных файлов.");
                    tooltip.SetToolTip(chck69, "Удаляет AI помощника Copilot из Windows.");
                    tooltip.SetToolTip(chck70, "Отключает функцию 'Узнайте больше об этом фото' на экране блокировки.");
                    tooltip.SetToolTip(chck71, "Позволяет использовать длинные пути файлов (>260 символов).");
                    tooltip.SetToolTip(chck72, "Восстанавливает классическое контекстное меню (как в Windows 10).");
                    tooltip.SetToolTip(chck73, "Отключает полноэкранные оптимизации — лучшая плавность в играх.");
                    tooltip.SetToolTip(chck74, "Внедряет исправления для повышения производительности оперативной памяти.");
                    tooltip.SetToolTip(chck75, "Блокирует известные адреса телеметрии и слежки Microsoft.");
                    tooltip.SetToolTip(chck76, "Блокирует хосты, предоставляющие данные о местоположении.");
                    tooltip.SetToolTip(chck77, "Останавливает отправку отчётов о сбоях в Microsoft.");


                }

                if (cinfo.Name == "de-DE")
                {
                    button7.Text = "de-DE";
                    Console.WriteLine("German detected");
                    groupBox1.Text = "Leistungs-Optim. (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Privatsphäre (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Visuelle Tweaks (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Andere (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Expertenmodus (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "Leistung";
                    button1.Font = new Font("Consolas", 11, FontStyle.Regular);
                    button2.Text = "Visuelle";
                    button2.Font = new Font("Consolas", 11, FontStyle.Regular);
                    button3.Text = "Privatsphäre";
                    button3.Font = new Font("Consolas", 11, FontStyle.Regular);
                    selectall0 = "Alle auswählen";
                    selectall1 = "Alle abwählen";

                    button4.Text = "Alle auswählen";
                    button4.Font = new Font("Consolas", 12, FontStyle.Regular);

                    toolStripButton2.Text = "Backup";
                    toolStripDropDownButton2.Text = "Wiederherst.";
                    registryRestoreToolStripMenuItem.Text = "Registrierung wiederherstellen";
                    restorePointToolStripMenuItem.Text = "Wiederherstellungspunkt";
                    toolStripButton3.Text = "Über mich";
                    toolStripButton4.Text = "Support";

                    rebootToSafeModeToolStripMenuItem.Text = "Im abges. Modus starten";
                    restartExplorerexeToolStripMenuItem.Text = "Explorer.exe neu starten";
                    downloadSoftwareToolStripMenuItem.Text = "Die Software herunterladen";
                    toolStripDropDownButton1.Text = "Extras";
                    diskDefragmenterToolStripMenuItem.Text = "Defragmentierung";
                    controlPanelToolStripMenuItem.Text = "Systemsteuerung";
                    deviceManagerToolStripMenuItem.Text = "Geräte-Manager";
                    uACSettingsToolStripMenuItem.Text = "UAC-Einstell.";
                    servicesToolStripMenuItem.Text = "Dienste";
                    remoteDesktopToolStripMenuItem.Text = "Remotedesktop";
                    eventViewerToolStripMenuItem.Text = "Ereignisanzeige";
                    resetNetworkToolStripMenuItem.Text = "Netzwerk zurücksetzen";
                    updateApplicationsToolStripMenuItem.Text = "Apps aktualis.";
                    windowsLicenseKeyToolStripMenuItem.Text = "Windows-Key anzeigen";
                    rebootToBIOSToolStripMenuItem.Text = "In BIOS starten";
                    makeETISOToolStripMenuItem.Text = "Erstellen Sie eine ET-optimierte .ISO-Datei";

                    msgend = "Abgeschlossen. Neustart empfohlen.";
                    msgerror = "Keine Option gewählt.";
                    msgupdate = "Eine neuere Version der Anwendung ist auf GitHub verfügbar!";
                    isoinfo = "Die erstellte ISO-Datei wird folgende Funktionen enthalten: ET-Optimizer.exe /auto und das Umgehen der Microsoft-Anforderungen durch Überspringen der Datenerfassung, lokales Konto usw.";

                    chck1.Text = "Edge-WebWidget aus";
                    chck2.Text = "Ultimate Power-Modus";
                    chck3.Text = "Svchost-Schwelle teilen";
                    chck4.Text = "Dualboot Timeout 3 Sek.";
                    chck5.Text = "Ruhezustand/Schnellstart aus";
                    chck6.Text = "Windows-Insider-Programm aus";
                    chck7.Text = "App-Tracking aus";
                    chck8.Text = "Powerthrottle (6 Gen+) aus";
                    chck9.Text = "Hintergrundapps aus";
                    chck10.Text = "Sticky-Keys-Hinweis aus";
                    chck11.Text = "Aktivitätsverlauf aus";
                    chck12.Text = "Microsoft-Store-Updates aus";
                    chck13.Text = "SmartScreen-Apps aus";
                    chck14.Text = "Berechtigungen für Websites erlau.";
                    chck15.Text = "Edge-Einstellungen wiederherstell.";
                    chck64.Text = "Nagling (ACKs) aus";
                    chck65.Text = "CPU/GPU-Priorität optimieren";
                    chck16.Text = "Standortsensoren aus";
                    chck17.Text = "HotSpot automatisch teilen aus";
                    chck18.Text = "HotSpot teilen aus";
                    chck19.Text = "Update: Neustart planen";
                    chck20.Text = "P2P auf LAN setzen";
                    chck21.Text = "Shutdown-Zeit 2 Sek.";
                    chck22.Text = "Alte Treiber löschen";
                    chck23.Text = "„Mehr erfahren“ aus";
                    chck24.Text = "Vorgeschlagene Apps aus";
                    chck25.Text = "Startmenu Werbung aus";
                    chck26.Text = "Windows-Ink-App Vorschläge aus";
                    chck27.Text = "Unnötige Komponene aus";
                    chck28.Text = "Defender-Scan begrenzen";
                    chck29.Text = "Prozessschutz aus";
                    chck30.Text = "Index Defragmentaion";
                    chck66.Text = "Spectre/Meltdown aus";
                    chck67.Text = "Defender deaktivieren";
                    chck31.Text = "Telemetrie-Tasks aus";
                    chck32.Text = "Daten/Telemtrie sammeln aus";
                    chck33.Text = "PowerShell Telemetrie aus";
                    chck34.Text = "Skype-Telemetrie aus";
                    chck35.Text = "MediaPlayer Berichte aus";
                    chck36.Text = "Mozilla-Telemetrie aus";
                    chck37.Text = "Werbe-ID-Nutzung aus";
                    chck38.Text = "Schreibdaten aus";
                    chck39.Text = "Handschrift aus";
                    chck40.Text = "Watson-Malware aus";
                    chck41.Text = "Malware-Daten aus";
                    chck42.Text = "Berichte an MAPS aus";
                    chck43.Text = "SpyNet-Defender aus";
                    chck44.Text = "Malware-Proben aus";
                    chck45.Text = "Tipp-Proben aus";
                    chck46.Text = "Kontakte senden aus";
                    chck47.Text = "Cortana deaktivieren";
                    chck48.Text = "Dateiendungen zeigen";
                    chck49.Text = "Taskbar-Transparent aus";
                    chck50.Text = "Animationen aus";
                    chck51.Text = "Sprunglisten aus";
                    chck52.Text = "Suche: Nur Icon";
                    chck53.Text = "Explorer auf 'Dieser PC' ";
                    chck54.Text = "Game Bar/DVR entfernen";
                    chck55.Text = "Dienste optimieren";
                    chck56.Text = "Bloatware entfernen";
                    chck57.Text = "Autostart-Apps aus";
                    chck58.Text = "Temp/Cache säubern";
                    chck59.Text = "News/Widgets aus";
                    chck60.Text = "OneDrive entfernen";
                    chck61.Text = "Xbox-Dienste aus";
                    chck62.Text = "Sichere DNS aktiv.";
                    chck63.Text = "Adware scannen (AdwCl)";
                    chck68.Text = "WinSxS Ordner säubern";
                    chck69.Text = "Copilot löschen";
                    chck70.Text = "'Über Bild mehr erfahren' aus";
                    chck71.Text = "Lange Pfade aktivieren";
                    chck72.Text = "Altes Kontextmenü aktivieren";
                    chck73.Text = "Vollbild-Opt. deaktivieren";
                    chck74.Text = "RAM-Speicheranpassungen";
                    chck75.Text = "Telemetry/UX-Hosts blockieren";
                    chck76.Text = "Standortdaten-Hosts blocken";
                    chck77.Text = "Crashreport-Hosts blockieren";
                    chck78.Text = "Anmeldehintergrund ausblenden";

                    tooltip.SetToolTip(chck1, "Deaktiviert Edge WebWidget, um Ressourcennutzung und Speicherverbrauch zu reduzieren.");
                    tooltip.SetToolTip(chck2, "Setzt den Windows-Energieplan auf Ultimate Performance für bessere Reaktionsfähigkeit.");
                    tooltip.SetToolTip(chck3, "Erlaubt Diensten, in separaten svchost-Prozessen zu laufen, verbessert die Stabilität.");
                    tooltip.SetToolTip(chck4, "Verkürzt die Wartezeit im Boot-Menü auf 3 Sekunden für einen schnelleren Start.");
                    tooltip.SetToolTip(chck5, "Deaktiviert den Ruhezustand und den Schnellstart, um Speicherplatz freizugeben.");
                    tooltip.SetToolTip(chck6, "Deaktiviert experimentelle Funktionen aus dem Windows Insider-Programm.");
                    tooltip.SetToolTip(chck7, "Stoppt die Systemverfolgung, welche Apps Sie öffnen.");
                    tooltip.SetToolTip(chck8, "Deaktiviert die CPU-Leistungsbegrenzung (für Intel 6. Gen und neuer) – volle Leistung.");
                    tooltip.SetToolTip(chck9, "Stoppt Hintergrund-Apps, verbessert Leistung und Energieeffizienz.");
                    tooltip.SetToolTip(chck10, "Deaktiviert Popups für dauerhafte Tasten (Sticky Keys).");
                    tooltip.SetToolTip(chck11, "Blockiert das Speichern der Aktivitätsverlauf in Windows.");
                    tooltip.SetToolTip(chck12, "Stoppt automatische Updates von Apps aus dem Microsoft Store.");
                    tooltip.SetToolTip(chck13, "Deaktiviert den SmartScreen-Filter für Apps, der unbekannte Programme prüft.");
                    tooltip.SetToolTip(chck14, "Blockiert den Zugriff von Webseiten auf Ihren Standort.");
                    tooltip.SetToolTip(chck15, "Setzt die Edge-Browsereinstellungen auf Standard zurück.");
                    tooltip.SetToolTip(chck16, "Deaktiviert Sensoren und Ortungsdienste – maximale Privatsphäre.");
                    tooltip.SetToolTip(chck17, "Verhindert das automatische Teilen Ihres Wi-Fi-Hotspots.");
                    tooltip.SetToolTip(chck18, "Blockiert Verbindungen zu geteilten Hotspots – erhöht die Sicherheit.");
                    tooltip.SetToolTip(chck19, "Erzwingt Benachrichtigungen vor einem Neustart nach Updates.");
                    tooltip.SetToolTip(chck20, "Begrenzt Update-Freigaben nur auf das lokale Netzwerk.");
                    tooltip.SetToolTip(chck21, "Verkürzt die Systemabschaltzeit – schnelleres Herunterfahren.");
                    tooltip.SetToolTip(chck22, "Entfernt ungenutzte Gerätetreiber, gibt Speicher frei.");
                    tooltip.SetToolTip(chck23, "Entfernt den Begrüßungsbildschirm 'Mehr aus Windows herausholen'.");
                    tooltip.SetToolTip(chck24, "Blockiert die Installation von empfohlenen und gesponserten Apps.");
                    tooltip.SetToolTip(chck25, "Entfernt Werbung und Vorschläge aus dem Startmenü.");
                    tooltip.SetToolTip(chck26, "Deaktiviert App-Vorschläge im Windows Ink-Bereich.");
                    tooltip.SetToolTip(chck27, "Deaktiviert ungenutzte Windows-Komponenten.");
                    tooltip.SetToolTip(chck28, "Reduziert die Priorität der Defender-Scans – weniger Einfluss auf die Leistung.");
                    tooltip.SetToolTip(chck29, "Deaktiviert einige Prozessschutzmaßnahmen – erhöht die Leistung (vorsichtig!).");
                    tooltip.SetToolTip(chck30, "Defragmentiert die Indexdatei – schnelleres Suchen.");
                    tooltip.SetToolTip(chck31, "Deaktiviert geplante Aufgaben im Zusammenhang mit Telemetrie.");
                    tooltip.SetToolTip(chck32, "Entfernt Dienste und Komponenten zur Telemetriedatenerfassung.");
                    tooltip.SetToolTip(chck33, "Blockiert PowerShell daran, Daten an Microsoft zu senden.");
                    tooltip.SetToolTip(chck34, "Blockiert Skype beim Sammeln und Senden von Telemetriedaten.");
                    tooltip.SetToolTip(chck35, "Deaktiviert Nutzungsberichte für den Windows Media Player.");
                    tooltip.SetToolTip(chck36, "Deaktiviert eingebaute Telemetrie im Firefox-Browser.");
                    tooltip.SetToolTip(chck37, "Blockiert Apps den Zugriff auf Ihre Werbe-ID.");
                    tooltip.SetToolTip(chck38, "Stoppt die Erfassung Ihrer Tippgewohnheiten.");
                    tooltip.SetToolTip(chck39, "Deaktiviert Handschrifterkennung und Analyse.");
                    tooltip.SetToolTip(chck40, "Blockiert automatische Malware-Berichte an Microsoft.");
                    tooltip.SetToolTip(chck41, "Blockiert Defender daran, Diagnosedaten zu Bedrohungen zu senden.");
                    tooltip.SetToolTip(chck42, "Deaktiviert Berichte an das cloudbasierte Microsoft MAPS-System.");
                    tooltip.SetToolTip(chck43, "Blockiert den Spynet-Berichtsdienst in Windows Defender.");
                    tooltip.SetToolTip(chck44, "Stoppt das automatische Senden verdächtiger Dateien an Microsoft.");
                    tooltip.SetToolTip(chck45, "Blockiert die Erfassung von Texteingabedaten über die Tastatur.");
                    tooltip.SetToolTip(chck46, "Stoppt die Synchronisation und Freigabe Ihrer Kontakte.");
                    tooltip.SetToolTip(chck47, "Schaltet den Sprachassistenten Cortana komplett aus.");
                    tooltip.SetToolTip(chck48, "Erzwingt die Anzeige von Dateierweiterungen im Explorer.");
                    tooltip.SetToolTip(chck49, "Deaktiviert die Transparenz der Taskleiste – geringerer GPU-Verbrauch.");
                    tooltip.SetToolTip(chck50, "Deaktiviert UI-Animationen – beschleunigt die Systemreaktion.");
                    tooltip.SetToolTip(chck51, "Blockiert das Speichern der zuletzt verwendeten Elemente (Jump Lists).");
                    tooltip.SetToolTip(chck52, "Ändert das Suchfeld im Startmenü in ein Symbol.");
                    tooltip.SetToolTip(chck53, "Stellt den Explorer so ein, dass er 'Dieser PC' öffnet.");
                    tooltip.SetToolTip(chck54, "Entfernt die Xbox-Spielleiste und Hintergrund-DVR-Dienste.");
                    tooltip.SetToolTip(chck55, "Wendet sichere Optimierungen für Windows-Dienste an.");
                    tooltip.SetToolTip(chck56, "Entfernt vorinstallierte Anwendungen (Bloatware).");
                    tooltip.SetToolTip(chck57, "Deaktiviert unnötige Autostart-Programme.");
                    tooltip.SetToolTip(chck58, "Reinigt Cache, temporäre Dateien und Systemprotokolle.");
                    tooltip.SetToolTip(chck59, "Entfernt das 'Nachrichten und Interessen'-Panel von der Taskleiste.");
                    tooltip.SetToolTip(chck60, "Entfernt OneDrive komplett aus dem System inklusive Synchronisation.");
                    tooltip.SetToolTip(chck61, "Deaktiviert Xbox-Dienste – empfohlen, wenn Sie nicht spielen.");
                    tooltip.SetToolTip(chck62, "Setzt schnellen und sicheren DNS von Cloudflare (1.1.1.1).");
                    tooltip.SetToolTip(chck63, "Startet AdwCleaner zur Erkennung und Entfernung von Adware.");
                    tooltip.SetToolTip(chck64, "Deaktiviert den Nagle-Algorithmus – reduziert Lags in Online-Spielen.");
                    tooltip.SetToolTip(chck65, "Optimiert CPU- und GPU-Management für bessere Anwendungsleistung.");
                    tooltip.SetToolTip(chck66, "Deaktiviert Spectre/Meltdown-Sicherheitsmechanismen – erhöht Leistung (weniger sicher).");
                    tooltip.SetToolTip(chck67, "Schaltet den Windows Defender Antivirenschutz komplett aus.");
                    tooltip.SetToolTip(chck68, "Reinigt den WinSxS-Ordner – gibt Speicherplatz durch alte Systemdateien frei.");
                    tooltip.SetToolTip(chck69, "Entfernt den AI-Assistenten Copilot aus Windows.");
                    tooltip.SetToolTip(chck70, "Deaktiviert die Funktion 'Mehr über dieses Bild erfahren' auf dem Sperrbildschirm.");
                    tooltip.SetToolTip(chck71, "Erlaubt die Nutzung langer Dateipfade (>260 Zeichen).");
                    tooltip.SetToolTip(chck72, "Stellt das klassische Kontextmenü (wie in Windows 10) wieder her.");
                    tooltip.SetToolTip(chck73, "Deaktiviert Vollbildoptimierungen – bessere Performance in Spielen.");
                    tooltip.SetToolTip(chck74, "Führt Verbesserungen zur Steigerung der RAM-Leistung ein.");
                    tooltip.SetToolTip(chck75, "Blockiert bekannte Microsoft-Telemetrie- und Tracking-Adressen.");
                    tooltip.SetToolTip(chck76, "Blockiert Hosts, die Standortdaten bereitstellen.");
                    tooltip.SetToolTip(chck77, "Stoppt das Senden von Absturzberichten an Microsoft.");


                }

                if (cinfo.Name == "pt-BR")
                {
                    button7.Text = "pt-BR";
                    Console.WriteLine("Portuguese - Brazil detected");
                    toolStripButton2.Text = "Backup";
                    toolStripDropDownButton2.Text = "Restaurando";
                    registryRestoreToolStripMenuItem.Text = "Restauração do Registro";
                    restorePointToolStripMenuItem.Text = "Ponto de Restauração";
                    toolStripDropDownButton1.Text = "Extras";
                    toolStripButton3.Text = "Sobre mim";
                    toolStripButton4.Text = "Doar";

                    button1.Text = "Desempehno";
                    button2.Text = "Visuais";
                    button3.Text = "Privacidade";
                    button3.Font = new Font("Consolas", 12, FontStyle.Regular);
                    selectall0 = "Selecione Tudo";
                    selectall1 = "Desmarcar Tudo";

                    button4.Text = "Selecione Tudo";
                    button4.Font = new Font("Consolas", 12, FontStyle.Regular);

                    groupBox1.Text = "Ajustes de desempenho (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Privacidade (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Ajustes visuais (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Outros (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Modo especialista (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    msgend = "Tudo foi concluído. É recomendável reiniciar.";
                    msgerror = "Nenhuma opção selecionada.";
                    msgupdate = "Uma nova versão do aplicativo está disponível no GitHub!";
                    isoinfo = "A ISO gerada terá os seguintes recursos: ET-Optimizer.exe /auto e ignorará os requisitos da Microsoft, pulando a coleta de dados, conta local, etc.";

                    chck1.Text = "Desabilitar WebWidget Edge";
                    chck2.Text = "Energia: desempenho máximo";
                    chck3.Text = "Limite p/ divisão proc. Svchost";
                    chck4.Text = "Tempo limite inic. dupla: 3s";
                    chck5.Text = "Desabilitar hibernação/inic. ráp.";
                    chck6.Text = "Desabilitar exp. Windows Insider";
                    chck7.Text = "Desabilitar rastreamento inic. app";
                    chck8.Text = "Desabilitar PowerThrottling Intel";
                    chck9.Text = "Desabilitar apps 2º plano";
                    chck10.Text = "Desabilitar teclas aderência";
                    chck11.Text = "Desabilitar histórico atividades";
                    chck12.Text = "Desabilitar updates MS Store";
                    chck13.Text = "Desabilitar filtro SmartScreen";
                    chck14.Text = "Permitir conteúdo local sites";
                    chck15.Text = "Corrigir config. Microsoft Edge";
                    chck64.Text = "Desabilitar alg. Nagle (ACKs)";
                    chck65.Text = "Ajustar prioridade CPU/GPU";
                    chck16.Text = "Desabilitar sensores localização";
                    chck17.Text = "Desabilitar Auto HotSpot WiFi";
                    chck18.Text = "Desabilitar HotSpot Compartilhado";
                    chck19.Text = "Notificação updates reinício";
                    chck20.Text = "Update P2P apenas LAN";
                    chck21.Text = "Desligamento rápido (2s)";
                    chck22.Text = "Remover drivers antigos";
                    chck23.Text = "Desabilitar 'Aproveite Mais'";
                    chck24.Text = "Desabilitar apps sugeridos";
                    chck25.Text = "Desabilitar anúncios menu iniciar";
                    chck26.Text = "Desabilitar apps sugeridos Ink";
                    chck27.Text = "Desabilitar componentes extras";
                    chck28.Text = "Reduzir prioridade verifs. Defender";
                    chck29.Text = "Desabilitar mitigação processos";
                    chck30.Text = "Desfragmentar serviço indexação";
                    chck66.Text = "Desabilitar Spectre/Meltdown";
                    chck67.Text = "Desabilitar Windows Defender";
                    chck31.Text = "Desabilitar tarefas telemetria";
                    chck32.Text = "Remover telemetria/coleta dados";
                    chck33.Text = "Desab. telemetria PowerShell";
                    chck34.Text = "Desabilitar telemetria Skype";
                    chck35.Text = "Desabilitar rel. uso Media Player";
                    chck36.Text = "Desabilitar telemetria Mozilla";
                    chck37.Text = "Desativar apps c/ ID publicidade";
                    chck38.Text = "Desabilitar envio info. escrita";
                    chck39.Text = "Desabilitar reconhecimento escrita";
                    chck40.Text = "Desabilitar rel. malware Watson";
                    chck41.Text = "Desabilitar dados diag. malware";
                    chck42.Text = "Desabilitar relatórios MS MAPS";
                    chck43.Text = "Desabilitar rel. Spynet Defender";
                    chck44.Text = "Não enviar amostras malware";
                    chck45.Text = "Desabilitar envio amostras digitação";
                    chck46.Text = "Desabilitar envio contatos MS";
                    chck47.Text = "Desabilitar Cortana";
                    chck48.Text = "Mostrar extensões arquivos";
                    chck49.Text = "Desabilitar transparência barra";
                    chck50.Text = "Desabilitar animações Windows";
                    chck51.Text = "Desabilitar listas MRU (atalhos)";
                    chck52.Text = "Definir pesquisa só ícones";
                    chck53.Text = "'Explorer' iniciar neste PC";
                    chck54.Text = "Remover barra jogos/DVR";
                    chck55.Text = "Habilitar ajustes serviço";
                    chck56.Text = "Remover bloatware pré-instalado";
                    chck57.Text = "Desativar apps inicialização inúteis";
                    chck58.Text = "Limpar temp/cache/pré-busca/logs";
                    chck59.Text = "Remover widgets notícias";
                    chck60.Text = "Remover Microsoft OneDrive";
                    chck61.Text = "Desabilitar serviços Xbox";
                    chck62.Text = "Habilitar DNS rápido/seguro";
                    chck63.Text = "Verificar adware (AdwCleaner)";
                    chck68.Text = "Limpar pasta WinSxS";
                    chck69.Text = "Remover Copilot";
                    chck70.Text = "Remover 'Saiba mais foto'";
                    chck71.Text = "Ativar caminhos longos";
                    chck72.Text = "Habilitar menu de contexto antigo";
                    chck73.Text = "Desat. otim. tela cheia";
                    chck74.Text = "Ajustes de Memória RAM";
                    chck75.Text = "Bloquear hosts de telemetria/UX";
                    chck76.Text = "Bloquear hosts de localização";
                    chck77.Text = "Bloquear hosts de erros do Win";
                    chck78.Text = "Desativar imagem de fundo da tela de login";

                    tooltip.SetToolTip(chck1, "Desativa o Edge WebWidget para reduzir o uso de recursos e memória.");
                    tooltip.SetToolTip(chck2, "Define o plano de energia do Windows para Desempenho Máximo para melhor responsividade.");
                    tooltip.SetToolTip(chck3, "Permite que serviços rodem em processos svchost separados, melhorando a estabilidade.");
                    tooltip.SetToolTip(chck4, "Reduz o tempo de espera no menu de inicialização para 3 segundos, para um boot mais rápido.");
                    tooltip.SetToolTip(chck5, "Desativa a hibernação e a inicialização rápida, liberando espaço no disco.");
                    tooltip.SetToolTip(chck6, "Desativa recursos experimentais do programa Windows Insider.");
                    tooltip.SetToolTip(chck7, "Para o sistema de rastreamento de quais aplicativos você abre.");
                    tooltip.SetToolTip(chck8, "Desativa o limite de potência da CPU (para Intel 6ª geração e posteriores) – desempenho máximo.");
                    tooltip.SetToolTip(chck9, "Para aplicativos rodando em segundo plano, melhorando performance e economia de energia.");
                    tooltip.SetToolTip(chck10, "Desativa janelas pop-up das Teclas de Aderência (Sticky Keys).");
                    tooltip.SetToolTip(chck11, "Bloqueia o salvamento do histórico de atividades no Windows.");
                    tooltip.SetToolTip(chck12, "Para atualizações automáticas de aplicativos da Microsoft Store.");
                    tooltip.SetToolTip(chck13, "Desativa o filtro SmartScreen para apps, que verifica programas desconhecidos.");
                    tooltip.SetToolTip(chck14, "Bloqueia o acesso de sites à sua localização.");
                    tooltip.SetToolTip(chck15, "Reseta as configurações do navegador Edge para o padrão.");
                    tooltip.SetToolTip(chck16, "Desativa sensores e serviços de localização – máxima privacidade.");
                    tooltip.SetToolTip(chck17, "Impede o compartilhamento automático do seu hotspot Wi-Fi.");
                    tooltip.SetToolTip(chck18, "Bloqueia conexões a hotspots compartilhados – aumenta a segurança.");
                    tooltip.SetToolTip(chck19, "Exige notificações antes de reiniciar após atualizações.");
                    tooltip.SetToolTip(chck20, "Limita o compartilhamento de atualizações apenas para a rede local.");
                    tooltip.SetToolTip(chck21, "Reduz o tempo de desligamento do sistema – desligamento mais rápido.");
                    tooltip.SetToolTip(chck22, "Remove drivers de dispositivos não usados, liberando espaço.");
                    tooltip.SetToolTip(chck23, "Remove a tela de boas-vindas 'Aproveite mais do Windows'.");
                    tooltip.SetToolTip(chck24, "Bloqueia a instalação de apps sugeridos e patrocinados.");
                    tooltip.SetToolTip(chck25, "Remove anúncios e sugestões do menu Iniciar.");
                    tooltip.SetToolTip(chck26, "Desativa sugestões de aplicativos na área do Windows Ink.");
                    tooltip.SetToolTip(chck27, "Desativa componentes do Windows que não são usados.");
                    tooltip.SetToolTip(chck28, "Reduz a prioridade das varreduras do Defender – menos impacto na performance.");
                    tooltip.SetToolTip(chck29, "Desativa algumas proteções de processos – aumenta o desempenho (cuidado!).");
                    tooltip.SetToolTip(chck30, "Desfragmenta o arquivo de indexação – busca mais rápida.");
                    tooltip.SetToolTip(chck31, "Desativa tarefas agendadas relacionadas à telemetria.");
                    tooltip.SetToolTip(chck32, "Remove serviços e componentes que coletam dados de telemetria.");
                    tooltip.SetToolTip(chck33, "Bloqueia o PowerShell de enviar dados para a Microsoft.");
                    tooltip.SetToolTip(chck34, "Bloqueia o Skype de coletar e enviar dados de telemetria.");
                    tooltip.SetToolTip(chck35, "Desativa relatórios de uso do Windows Media Player.");
                    tooltip.SetToolTip(chck36, "Desativa a telemetria embutida no navegador Firefox.");
                    tooltip.SetToolTip(chck37, "Bloqueia aplicativos de acessar seu ID de publicidade.");
                    tooltip.SetToolTip(chck38, "Para a coleta de informações sobre seu estilo de digitação.");
                    tooltip.SetToolTip(chck39, "Desativa reconhecimento e análise de escrita manual.");
                    tooltip.SetToolTip(chck40, "Bloqueia relatórios automáticos de malware para a Microsoft.");
                    tooltip.SetToolTip(chck41, "Bloqueia o Defender de enviar dados diagnósticos de ameaças.");
                    tooltip.SetToolTip(chck42, "Desativa o envio de relatórios para o sistema em nuvem MAPS da Microsoft.");
                    tooltip.SetToolTip(chck43, "Bloqueia o serviço de relatório Spynet do Windows Defender.");
                    tooltip.SetToolTip(chck44, "Para o envio automático de arquivos suspeitos para a Microsoft.");
                    tooltip.SetToolTip(chck45, "Bloqueia a coleta de dados de entrada de texto via teclado.");
                    tooltip.SetToolTip(chck46, "Para a sincronização e compartilhamento dos seus contatos.");
                    tooltip.SetToolTip(chck47, "Desativa completamente a assistente de voz Cortana.");
                    tooltip.SetToolTip(chck48, "Força a exibição de extensões de arquivos no Explorador.");
                    tooltip.SetToolTip(chck49, "Desativa a transparência da barra de tarefas – menor uso de GPU.");
                    tooltip.SetToolTip(chck50, "Desativa animações da interface – acelera respostas do sistema.");
                    tooltip.SetToolTip(chck51, "Bloqueia o salvamento dos itens usados recentemente (Jump Lists).");
                    tooltip.SetToolTip(chck52, "Altera a caixa de busca do menu Iniciar para apenas o ícone.");
                    tooltip.SetToolTip(chck53, "Configura o Explorador de arquivos para abrir em 'Este Computador'.");
                    tooltip.SetToolTip(chck54, "Remove a barra de jogos Xbox e serviços DVR em segundo plano.");
                    tooltip.SetToolTip(chck55, "Aplica otimizações seguras nos serviços do Windows.");
                    tooltip.SetToolTip(chck56, "Remove aplicativos pré-instalados (bloatware).");
                    tooltip.SetToolTip(chck57, "Desativa programas desnecessários que iniciam com o sistema.");
                    tooltip.SetToolTip(chck58, "Limpa cache, arquivos temporários e logs do sistema.");
                    tooltip.SetToolTip(chck59, "Remove o painel 'Notícias e Interesses' da barra de tarefas.");
                    tooltip.SetToolTip(chck60, "Remove completamente o OneDrive do sistema, junto com a sincronização.");
                    tooltip.SetToolTip(chck61, "Desativa serviços do Xbox – recomendado se você não joga.");
                    tooltip.SetToolTip(chck62, "Configura DNS rápido e seguro da Cloudflare (1.1.1.1).");
                    tooltip.SetToolTip(chck63, "Executa o AdwCleaner para detectar e remover adware.");
                    tooltip.SetToolTip(chck64, "Desativa o algoritmo de Nagle – reduz atrasos em jogos online.");
                    tooltip.SetToolTip(chck65, "Otimiza o gerenciamento de CPU e GPU para melhor desempenho de apps.");
                    tooltip.SetToolTip(chck66, "Desativa proteções Spectre/Meltdown – aumenta desempenho (menos seguro).");
                    tooltip.SetToolTip(chck67, "Desativa completamente o antivírus Windows Defender.");
                    tooltip.SetToolTip(chck68, "Limpa a pasta WinSxS – recupera espaço usado por arquivos antigos do sistema.");
                    tooltip.SetToolTip(chck69, "Remove o assistente AI Copilot do Windows.");
                    tooltip.SetToolTip(chck70, "Desativa a função 'Saiba mais sobre esta foto' na tela de bloqueio.");
                    tooltip.SetToolTip(chck71, "Permite o uso de caminhos longos para arquivos (>260 caracteres).");
                    tooltip.SetToolTip(chck72, "Restaura o menu de contexto clássico (como no Windows 10).");
                    tooltip.SetToolTip(chck73, "Desativa otimizações de tela cheia – melhora a fluidez nos jogos.");
                    tooltip.SetToolTip(chck74, "Aplica melhorias para aumentar o desempenho da memória RAM.");
                    tooltip.SetToolTip(chck75, "Bloqueia endereços conhecidos de telemetria e rastreamento da Microsoft.");
                    tooltip.SetToolTip(chck76, "Bloqueia hosts que compartilham dados de localização.");
                    tooltip.SetToolTip(chck77, "Para o envio de relatórios de falhas para a Microsoft.");


                }
                if (cinfo.Name == "fr-FR")
                {
                    button7.Text = "fr-FR";
                    Console.WriteLine("French detected");
                    groupBox1.Text = "Améliorations de Performance (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Confidentialité (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Améliorations Visuelles (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Autres (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Mode Expert (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "Performance";
                    button2.Text = "Visuel";
                    button3.Text = "Confid.";
                    selectall0 = "Tout Sélectionner";
                    selectall1 = "Tout Désélectionner";

                    button4.Text = "Tout Sélectionner";
                    button4.Font = new Font("Consolas", 12, FontStyle.Regular);

                    toolStripButton2.Text = "Sauvegarde";
                    toolStripDropDownButton2.Text = "Restauration";
                    registryRestoreToolStripMenuItem.Text = "Restauration du registre";
                    restorePointToolStripMenuItem.Text = "Point de restauration";
                    toolStripButton3.Text = "À propos";
                    toolStripButton4.Text = "Support";

                    rebootToSafeModeToolStripMenuItem.Text = "Redémarrer en Mode Sans Échec";
                    restartExplorerexeToolStripMenuItem.Text = "Redémarrer Explorer.exe";
                    downloadSoftwareToolStripMenuItem.Text = "Télécharger le Logiciel";
                    toolStripDropDownButton1.Text = "Compléments";
                    diskDefragmenterToolStripMenuItem.Text = "Défragmentation du Disque";
                    controlPanelToolStripMenuItem.Text = "Panneau de Configuration";
                    deviceManagerToolStripMenuItem.Text = "Gestionnaire de Périphériques";
                    uACSettingsToolStripMenuItem.Text = "Paramètres UAC";
                    servicesToolStripMenuItem.Text = "Services";
                    remoteDesktopToolStripMenuItem.Text = "Bureau à Distance";
                    eventViewerToolStripMenuItem.Text = "Observateur d'Événements";
                    resetNetworkToolStripMenuItem.Text = "Réinitialiser le Réseau";
                    updateApplicationsToolStripMenuItem.Text = "Mettre à Jour les Applications";
                    windowsLicenseKeyToolStripMenuItem.Text = "Afficher la Clé Windows";
                    rebootToBIOSToolStripMenuItem.Text = "Démarrer dans le BIOS";
                    makeETISOToolStripMenuItem.Text = "Créer un fichier ISO optimisé avec ET";

                    msgend = "Terminé. Un redémarrage est recommandé.";
                    msgerror = "Aucune option sélectionnée.";
                    msgupdate = "Une nouvelle version de l'application est disponible sur GitHub !";
                    isoinfo = "L’image ISO générée comportera les fonctionnalités suivantes : ET-Optimizer.exe /auto et contournement des exigences de Microsoft en évitant la collecte de données, le compte local, etc.";

                    toolStripLabel1.Text = "Version : Publique | " + ETBuild;

                    chck1.Text = "Désactiver WebWidget Edge";
                    chck2.Text = "Alimentation : Perf. maximale";
                    chck3.Text = "Division seuil pour Svchost";
                    chck4.Text = "Double démarrage - 3 sec";
                    chck5.Text = "Désactiver hibernation/fastboot";
                    chck6.Text = "Désactiver exp. Windows Insider";
                    chck7.Text = "Désactiver suivi démarrage applis";
                    chck8.Text = "Désactiver Powerthrottling";
                    chck9.Text = "Désactiver applis arrière-plan";
                    chck10.Text = "Désactiver alerte touches";
                    chck11.Text = "Désactiver hist. activités";
                    chck12.Text = "Désactiver maj Microsoft Store";
                    chck13.Text = "Désactiver SmartScreen applis";
                    chck14.Text = "Sites fournissent données locale";
                    chck15.Text = "Réparer paramètres Edge";
                    chck64.Text = "Désactiver algorithme Nagle";
                    chck65.Text = "Ajuster priorités CPU/GPU";
                    chck16.Text = "Désactiver capteurs localisation";
                    chck17.Text = "Désactiver HotSpot auto";
                    chck18.Text = "Désactiver partage connexion";
                    chck19.Text = "Notifications mise à jour";
                    chck20.Text = "Partage maj - local";
                    chck21.Text = "Réduire temps arrêt système";
                    chck22.Text = "Supprimer anciens pilotes";
                    chck23.Text = "Désactiver 'Encore plus de...'";
                    chck24.Text = "Désactiver applis suggérées";
                    chck25.Text = "Désactiver pubs/sugg. Start";
                    chck26.Text = "Désactiver sugg. Windows Ink";
                    chck27.Text = "Désactiver composants inutiles";
                    chck28.Text = "Limiter analyses Defender";
                    chck29.Text = "Désactiver mitigation processus";
                    chck30.Text = "Défragmenter fichier index";
                    chck66.Text = "Désactiver prot. Spectre/Meltdown";
                    chck67.Text = "Désactiver Windows Defender";
                    chck31.Text = "Désactiver tâches télémétrie";
                    chck32.Text = "Supprimer collecte données";
                    chck33.Text = "Désactiver télémétrie PowerShell";
                    chck34.Text = "Désactiver télémétrie Skype";
                    chck35.Text = "Désactiver rapports Media Player";
                    chck36.Text = "Désactiver télémétrie Mozilla";
                    chck37.Text = "Désactiver ID publicitaire";
                    chck38.Text = "Désactiver envoi frappe";
                    chck39.Text = "Désactiver reco. écriture";
                    chck40.Text = "Désactiver rapports Watson";
                    chck41.Text = "Désactiver diag. malwares";
                    chck42.Text = "Désactiver rapports MS MAPS";
                    chck43.Text = "Désactiver rapports Spynet";
                    chck44.Text = "Ne pas envoyer échantillons";
                    chck45.Text = "Désactiver échantillons frappe";
                    chck46.Text = "Désactiver envoi contacts MS";
                    chck47.Text = "Désactiver Cortana";
                    chck48.Text = "Afficher extensions fichiers";
                    chck49.Text = "Désactiver transparence barre";
                    chck50.Text = "Désactiver animations Windows";
                    chck51.Text = "Désactiver listes accès rapide";
                    chck52.Text = "Recherche en icône";
                    chck53.Text = "Ouvrir par défaut 'Ce PC'";
                    chck54.Text = "Supprimer Barre Jeux Windows";
                    chck55.Text = "Activer optimisation services";
                    chck56.Text = "Supprimer logiciels inutiles";
                    chck57.Text = "Désactiver applis démarrage";
                    chck58.Text = "Nettoyer Temp/Cache/Logs";
                    chck59.Text = "Supprimer Actu. et Widgets";
                    chck60.Text = "Supprimer Microsoft OneDrive";
                    chck61.Text = "Désactiver services Xbox";
                    chck62.Text = "Activer DNS rapide/sécurisé";
                    chck63.Text = "Analyse AdwCleaner";
                    chck68.Text = "Nettoyer dossier WinSxS";
                    chck69.Text = "Supprimer Copilot";
                    chck70.Text = "Désactiver 'En savoir plus'";
                    chck71.Text = "Activer les chemins longs";
                    chck72.Text = "Activer l'ancien menu contextuel";
                    chck73.Text = "Désact. opt. plein écran";
                    chck74.Text = "Optimisations de la RAM";
                    chck75.Text = "Bloquer hôtes télémétrie/UX";
                    chck76.Text = "Bloquer hôtes localisation";
                    chck77.Text = "Bloquer hôtes rapports crash";
                    chck78.Text = "Désactiver fond de connexion";


                    tooltip.SetToolTip(chck1, "Désactive Edge WebWidget pour réduire l'utilisation des ressources et de la mémoire.");
                    tooltip.SetToolTip(chck2, "Configure le plan d'alimentation Windows sur Performance Ultime pour une meilleure réactivité.");
                    tooltip.SetToolTip(chck3, "Permet aux services de fonctionner dans des processus svchost séparés, améliorant la stabilité.");
                    tooltip.SetToolTip(chck4, "Réduit le temps d'attente dans le menu de démarrage à 3 secondes pour un démarrage plus rapide.");
                    tooltip.SetToolTip(chck5, "Désactive l'hibernation et le démarrage rapide, libérant de l'espace disque.");
                    tooltip.SetToolTip(chck6, "Désactive les fonctionnalités expérimentales du programme Windows Insider.");
                    tooltip.SetToolTip(chck7, "Arrête le suivi par le système des applications que vous ouvrez.");
                    tooltip.SetToolTip(chck8, "Désactive la limitation de puissance CPU (pour Intel 6ème génération et plus) – performance maximale.");
                    tooltip.SetToolTip(chck9, "Arrête les applications en arrière-plan, améliorant les performances et l'économie d'énergie.");
                    tooltip.SetToolTip(chck10, "Désactive les fenêtres contextuelles des touches rémanentes (Sticky Keys).");
                    tooltip.SetToolTip(chck11, "Bloque l'enregistrement de l'historique des activités dans Windows.");
                    tooltip.SetToolTip(chck12, "Arrête les mises à jour automatiques des applications du Microsoft Store.");
                    tooltip.SetToolTip(chck13, "Désactive le filtre SmartScreen pour les applications, qui vérifie les programmes inconnus.");
                    tooltip.SetToolTip(chck14, "Bloque l'accès des sites web à votre localisation.");
                    tooltip.SetToolTip(chck15, "Réinitialise les paramètres du navigateur Edge à leurs valeurs par défaut.");
                    tooltip.SetToolTip(chck16, "Désactive les capteurs et services de localisation – confidentialité maximale.");
                    tooltip.SetToolTip(chck17, "Empêche le partage automatique de votre hotspot Wi-Fi.");
                    tooltip.SetToolTip(chck18, "Bloque les connexions aux hotspots partagés – augmente la sécurité.");
                    tooltip.SetToolTip(chck19, "Force les notifications avant redémarrage après mises à jour.");
                    tooltip.SetToolTip(chck20, "Limite le partage des mises à jour uniquement au réseau local.");
                    tooltip.SetToolTip(chck21, "Réduit le temps d'arrêt du système – extinction plus rapide.");
                    tooltip.SetToolTip(chck22, "Supprime les pilotes de périphériques inutilisés, libérant de l'espace.");
                    tooltip.SetToolTip(chck23, "Supprime l'écran de bienvenue 'Tirez le meilleur parti de Windows'.");
                    tooltip.SetToolTip(chck24, "Bloque l'installation d'applications suggérées et sponsorisées.");
                    tooltip.SetToolTip(chck25, "Supprime les publicités et suggestions dans le menu Démarrer.");
                    tooltip.SetToolTip(chck26, "Désactive les suggestions d'applications dans la zone Windows Ink.");
                    tooltip.SetToolTip(chck27, "Désactive les composants Windows inutilisés.");
                    tooltip.SetToolTip(chck28, "Réduit la priorité des analyses Defender – moins d'impact sur les performances.");
                    tooltip.SetToolTip(chck29, "Désactive certaines protections des processus – augmente les performances (à utiliser avec précaution!).");
                    tooltip.SetToolTip(chck30, "Défragmente le fichier d'indexation – recherche plus rapide.");
                    tooltip.SetToolTip(chck31, "Désactive les tâches planifiées liées à la télémétrie.");
                    tooltip.SetToolTip(chck32, "Supprime les services et composants collectant des données télémétriques.");
                    tooltip.SetToolTip(chck33, "Bloque PowerShell d'envoyer des données à Microsoft.");
                    tooltip.SetToolTip(chck34, "Bloque Skype de collecter et envoyer des données télémétriques.");
                    tooltip.SetToolTip(chck35, "Désactive les rapports d'utilisation de Windows Media Player.");
                    tooltip.SetToolTip(chck36, "Désactive la télémétrie intégrée dans le navigateur Firefox.");
                    tooltip.SetToolTip(chck37, "Bloque les applications d'accéder à votre identifiant publicitaire.");
                    tooltip.SetToolTip(chck38, "Arrête la collecte d'informations sur votre style de frappe.");
                    tooltip.SetToolTip(chck39, "Désactive la reconnaissance et l'analyse de l'écriture manuscrite.");
                    tooltip.SetToolTip(chck40, "Bloque les rapports automatiques de logiciels malveillants à Microsoft.");
                    tooltip.SetToolTip(chck41, "Bloque Defender d'envoyer des données diagnostiques sur les menaces.");
                    tooltip.SetToolTip(chck42, "Désactive l'envoi de rapports au système cloud MAPS de Microsoft.");
                    tooltip.SetToolTip(chck43, "Bloque le service de rapport Spynet dans Windows Defender.");
                    tooltip.SetToolTip(chck44, "Arrête l'envoi automatique de fichiers suspects à Microsoft.");
                    tooltip.SetToolTip(chck45, "Bloque la collecte des données de saisie au clavier.");
                    tooltip.SetToolTip(chck46, "Arrête la synchronisation et le partage de vos contacts.");
                    tooltip.SetToolTip(chck47, "Désactive complètement l'assistant vocal Cortana.");
                    tooltip.SetToolTip(chck48, "Force l'affichage des extensions de fichiers dans l'Explorateur.");
                    tooltip.SetToolTip(chck49, "Désactive la transparence de la barre des tâches – moins d'utilisation du GPU.");
                    tooltip.SetToolTip(chck50, "Désactive les animations de l'interface – accélère la réactivité du système.");
                    tooltip.SetToolTip(chck51, "Bloque l'enregistrement des éléments récemment utilisés (Jump Lists).");
                    tooltip.SetToolTip(chck52, "Change la barre de recherche du menu Démarrer en icône seule.");
                    tooltip.SetToolTip(chck53, "Configure l'Explorateur de fichiers pour s'ouvrir sur 'Ce PC'.");
                    tooltip.SetToolTip(chck54, "Supprime la barre de jeu Xbox et les services DVR en arrière-plan.");
                    tooltip.SetToolTip(chck55, "Applique des optimisations sécurisées aux services Windows.");
                    tooltip.SetToolTip(chck56, "Supprime les applications préinstallées (bloatware).");
                    tooltip.SetToolTip(chck57, "Désactive les programmes inutiles au démarrage du système.");
                    tooltip.SetToolTip(chck58, "Nettoie le cache, fichiers temporaires et journaux système.");
                    tooltip.SetToolTip(chck59, "Supprime le panneau 'Actualités et intérêts' de la barre des tâches.");
                    tooltip.SetToolTip(chck60, "Supprime complètement OneDrive du système, y compris la synchronisation.");
                    tooltip.SetToolTip(chck61, "Désactive les services Xbox – recommandé si vous ne jouez pas.");
                    tooltip.SetToolTip(chck62, "Configure un DNS rapide et sécurisé de Cloudflare (1.1.1.1).");
                    tooltip.SetToolTip(chck63, "Lance AdwCleaner pour détecter et supprimer les adwares.");
                    tooltip.SetToolTip(chck64, "Désactive l'algorithme de Nagle – réduit la latence dans les jeux en ligne.");
                    tooltip.SetToolTip(chck65, "Optimise la gestion CPU et GPU pour de meilleures performances des applications.");
                    tooltip.SetToolTip(chck66, "Désactive les protections Spectre/Meltdown – augmente les performances (moins sûr).");
                    tooltip.SetToolTip(chck67, "Désactive complètement l'antivirus Windows Defender.");
                    tooltip.SetToolTip(chck68, "Nettoie le dossier WinSxS – récupère de l'espace occupé par d'anciens fichiers système.");
                    tooltip.SetToolTip(chck69, "Supprime l'assistant AI Copilot de Windows.");
                    tooltip.SetToolTip(chck70, "Désactive la fonction 'En savoir plus sur cette image' sur l'écran de verrouillage.");
                    tooltip.SetToolTip(chck71, "Permet l'utilisation de chemins de fichiers longs (>260 caractères).");
                    tooltip.SetToolTip(chck72, "Restaure le menu contextuel classique (comme sous Windows 10).");
                    tooltip.SetToolTip(chck73, "Désactive les optimisations plein écran – meilleure fluidité dans les jeux.");
                    tooltip.SetToolTip(chck74, "Applique des correctifs améliorant la performance de la mémoire RAM.");
                    tooltip.SetToolTip(chck75, "Bloque les adresses connues de télémétrie et de suivi de Microsoft.");
                    tooltip.SetToolTip(chck76, "Bloque les hôtes partageant des données de localisation.");
                    tooltip.SetToolTip(chck77, "Arrête l'envoi des rapports de plantage à Microsoft.");


                }
                if (cinfo.Name == "ko-KR")
                {
                    button7.Text = "ko-KR";
                    Console.WriteLine("Korean detected");
                    groupBox1.Text = "성능 조정 (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "개인 정보 (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "시각 효과 조정 (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "기타 (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "전문가 모드 (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "성능";
                    button2.Text = "시각 효과";
                    button3.Text = "개인 정보";
                    selectall0 = "모두 선택";
                    selectall1 = "모두 해제";

                    button4.Text = "모두 선택";
                    button5.Text = "시작";

                    button1.Font = new Font("Consolas", 16, FontStyle.Regular);
                    button2.Font = new Font("Consolas", 16, FontStyle.Regular);
                    button3.Font = new Font("Consolas", 16, FontStyle.Regular);
                    button4.Font = new Font("Consolas", 16, FontStyle.Regular);
                    button5.Font = new Font("Consolas", 16, FontStyle.Regular);
                    panel1.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel2.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel3.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel4.Font = new Font("Consolas", 12, FontStyle.Regular);
                    panel5.Font = new Font("Consolas", 12, FontStyle.Regular);
                    groupBox1.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox2.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox3.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox4.Font = new Font("Consolas", 13, FontStyle.Bold);
                    groupBox5.Font = new Font("Consolas", 13, FontStyle.Bold);
                    customGroup6.Font= new Font("Consolas", 13, FontStyle.Bold);
                    toolStrip1.Font = new Font("Consolas", 12, FontStyle.Regular);

                    toolStripButton2.Text = "백업";
                    toolStripDropDownButton2.Text = "복원";
                    registryRestoreToolStripMenuItem.Text = "레지스트리 복원";
                    restorePointToolStripMenuItem.Text = "복원 지점";
                    toolStripButton3.Text = "정보";
                    toolStripButton4.Text = "기부하기";

                    msgend = "모든 작업이 완료되었습니다. 재부팅을 권장합니다.";
                    msgerror = "선택된 옵션이 없습니다.";
                    msgupdate = "이 애플리케이션의 최신 버전을 GitHub에서 이용할 수 있습니다!";
                    isoinfo = "생성된 ISO에는 다음 기능이 포함됩니다: ET-Optimizer.exe /auto 및 데이터 수집, 로컬 계정 등을 건너뛰어 Microsoft 요구 사항을 우회합니다.";

                    rebootToSafeModeToolStripMenuItem.Text = "안전 모드로 재부팅";
                    restartExplorerexeToolStripMenuItem.Text = "Explorer.exe 재시작";
                    downloadSoftwareToolStripMenuItem.Text = "소프트웨어 다운로드";
                    toolStripDropDownButton1.Text = "추가 기능";
                    diskDefragmenterToolStripMenuItem.Text = "디스크 조각 모음";
                    controlPanelToolStripMenuItem.Text = "제어판";
                    deviceManagerToolStripMenuItem.Text = "장치 관리자";
                    uACSettingsToolStripMenuItem.Text = "UAC 설정";
                    servicesToolStripMenuItem.Text = "서비스";
                    remoteDesktopToolStripMenuItem.Text = "원격 데스크톱";
                    eventViewerToolStripMenuItem.Text = "이벤트 뷰어";
                    resetNetworkToolStripMenuItem.Text = "네트워크 재설정";
                    updateApplicationsToolStripMenuItem.Text = "애플리케이션 업데이트";
                    windowsLicenseKeyToolStripMenuItem.Text = "Windows 라이선스 키";
                    rebootToBIOSToolStripMenuItem.Text = "BIOS로 재부팅";
                    makeETISOToolStripMenuItem.Text = "ET-최적화된 .ISO 만들기";

                    chck1.Text = "Edge WebWidget 비활성화";
                    chck2.Text = "전원 옵션을 고성능으로 설정";
                    chck3.Text = "Svchost에 대한 분할 임계값";
                    chck4.Text = "듀얼 부팅 시간 초과 3초";
                    chck5.Text = "최대 절전 모드/빠른 시작 비활성화";
                    chck6.Text = "Windows 참가자 실험 비활성화";
                    chck7.Text = "앱 실행 추적 비활성화";
                    chck8.Text = "전원 제한 끔 (인텔 6세대↑)";
                    chck9.Text = "백그라운드 앱 끄기";
                    chck10.Text = "고정 키 프롬프트 비활성화";
                    chck11.Text = "활동 기록 비활성화";
                    chck12.Text = "MS Store 앱 업데이트 비활성화";
                    chck13.Text = "앱용 SmartScreen 필터 비활성화";
                    chck14.Text = "웹에서 내 언어 콘텐츠 끔";
                    chck15.Text = "Microsoft Edge 설정 수정";
                    chck64.Text = "Nagle 끔 (지연 ACK)";
                    chck65.Text = "CPU/GPU 우선순위 조정";
                    chck16.Text = "위치 센서 비활성화";
                    chck17.Text = "WiFi 핫스팟 자동 공유 비활성화";
                    chck18.Text = "공유 핫스팟 연결 비활성화";
                    chck19.Text = "업데이트 일정 재시작 알림";
                    chck20.Text = "로컬 P2P 업데이트 설정";
                    chck21.Text = "더 빠른 종료시간 설정(2초)";
                    chck22.Text = "오래된 장치 드라이버 제거";
                    chck23.Text = "기능 홍보 화면 끔";
                    chck24.Text = "추천 앱 설치 비활성화";
                    chck25.Text = "시작 메뉴 광고/제안 비활성화";
                    chck26.Text = "추천 앱 Windows Ink 비활성화";
                    chck27.Text = "불필요한 구성 요소 비활성화";
                    chck28.Text = "Defender 예약 검사 완화";
                    chck29.Text = "프로세스 완화 비활성화";
                    chck30.Text = "인덱싱 서비스 파일 조각 모음";
                    chck66.Text = "스펙터/멜트다운 비활성화";
                    chck67.Text = "Windows Defender 비활성화";
                    chck31.Text = "원격 분석 예약 작업 비활성화";
                    chck32.Text = "원격 분석/데이터 수집 제거";
                    chck33.Text = "PowerShell 원격 분석 비활성화";
                    chck34.Text = "Skype 원격 분석 비활성화";
                    chck35.Text = "미디어 사용 보고 끔";
                    chck36.Text = "Mozilla 원격 분석 비활성화";
                    chck37.Text = "앱이 내 광고 ID를 사용 비활성화";
                    chck38.Text = "글쓰기에 대한 정보 전송 비활성화";
                    chck39.Text = "필기 인식 비활성화";
                    chck40.Text = "Watson 악성코드 보고 비활성화";
                    chck41.Text = "악성코드 진단 데이터 비활성화";
                    chck42.Text = "MS MAPS에 대한 보고 비활성화";
                    chck43.Text = "Spynet 보고 끔";
                    chck44.Text = "악성코드 샘플 전송 안 함";
                    chck45.Text = "타이핑 샘플 전송 비활성화";
                    chck46.Text = "MS로 연락처 전송 비활성화";
                    chck47.Text = "Cortana 비활성화";
                    chck48.Text = "탐색기에 파일 확장자 표시";
                    chck49.Text = "작업 표시줄의 투명도 비활성화";
                    chck50.Text = "창 애니메이션 비활성화";
                    chck51.Text = "MRU 목록(점프 목록) 비활성화";
                    chck52.Text = "검색 상자를 아이콘으로만 설정";
                    chck53.Text = "시작 시 드라이브 표시";
                    chck54.Text = "Windows 게임 바/DVR 제거";
                    chck55.Text = "서비스 조정 활성화";
                    chck56.Text = "블로트웨어(사전 설치 앱) 제거";
                    chck57.Text = "불필요한 시작 앱 비활성화";
                    chck58.Text = "임시/캐시/프리페치/로그 정리";
                    chck59.Text = "뉴스 및 관심사/위젯 제거";
                    chck60.Text = "Microsoft OneDrive 제거";
                    chck61.Text = "Xbox 서비스 비활성화";
                    chck62.Text = "Cloudflare DNS(1.1.1.1) 설정";
                    chck63.Text = "애드웨어 스캔 (AdwCleaner)";
                    chck68.Text = "WinSxS 폴더 정리";
                    chck69.Text = "Copilot 제거";
                    chck70.Text = "이 사진에 대해 자세히 알아보기 제거";
                    chck71.Text = "긴 시스템 경로 활성화";
                    chck72.Text = "이전 컨텍스트 메뉴 활성화";
                    chck73.Text = "전체 화면 최적화 비활성화";
                    chck74.Text = "RAM 메모리 조정 활성화";
                    chck75.Text = "텔레메트리/UX 호스트 차단";
                    chck76.Text = "위치 정보 호스트 차단";
                    chck77.Text = "충돌 보고 호스트 차단";
                    chck78.Text = "로그인 배경 끄기";

                    tooltip.SetToolTip(chck1, "Edge WebWidget를 비활성화하여 리소스와 메모리 사용을 줄입니다.");
                    tooltip.SetToolTip(chck2, "Windows 전원 계획을 최고의 성능(Ultimate Performance)으로 설정하여 응답성을 향상시킵니다.");
                    tooltip.SetToolTip(chck3, "서비스가 별도의 svchost 프로세스에서 실행되도록 하여 안정성을 개선합니다.");
                    tooltip.SetToolTip(chck4, "부팅 메뉴 대기 시간을 3초로 단축하여 더 빠른 시작을 제공합니다.");
                    tooltip.SetToolTip(chck5, "최대 절전 모드와 빠른 시작을 비활성화하여 디스크 공간을 확보합니다.");
                    tooltip.SetToolTip(chck6, "Windows Insider 프로그램의 실험적 기능을 비활성화합니다.");
                    tooltip.SetToolTip(chck7, "시스템이 열리는 앱을 추적하는 것을 중지합니다.");
                    tooltip.SetToolTip(chck8, "CPU 전력 제한을 해제합니다(Intel 6세대 이상) – 최대 성능 제공.");
                    tooltip.SetToolTip(chck9, "백그라운드 앱 실행을 중지하여 성능과 전력 효율을 향상시킵니다.");
                    tooltip.SetToolTip(chck10, "고정키(Sticky Keys) 팝업 창을 비활성화합니다.");
                    tooltip.SetToolTip(chck11, "Windows 활동 기록 저장을 차단합니다.");
                    tooltip.SetToolTip(chck12, "Microsoft Store 앱의 자동 업데이트를 중지합니다.");
                    tooltip.SetToolTip(chck13, "알 수 없는 프로그램을 검사하는 앱용 SmartScreen 필터를 비활성화합니다.");
                    tooltip.SetToolTip(chck14, "웹사이트가 위치 정보에 접근하는 것을 차단합니다.");
                    tooltip.SetToolTip(chck15, "Edge 브라우저 설정을 기본값으로 재설정합니다.");
                    tooltip.SetToolTip(chck16, "센서와 위치 서비스를 비활성화하여 최대한의 개인정보 보호를 제공합니다.");
                    tooltip.SetToolTip(chck17, "Wi-Fi 핫스팟 자동 공유를 금지합니다.");
                    tooltip.SetToolTip(chck18, "공유된 핫스팟 연결을 차단하여 보안을 강화합니다.");
                    tooltip.SetToolTip(chck19, "업데이트 후 재시작 전에 알림을 강제 표시합니다.");
                    tooltip.SetToolTip(chck20, "업데이트 공유를 로컬 네트워크로 제한합니다.");
                    tooltip.SetToolTip(chck21, "시스템 종료 시간을 단축하여 빠른 종료를 가능하게 합니다.");
                    tooltip.SetToolTip(chck22, "사용하지 않는 장치 드라이버를 제거하여 공간을 확보합니다.");
                    tooltip.SetToolTip(chck23, "'Windows 더 많이 활용하기' 환영 화면을 제거합니다.");
                    tooltip.SetToolTip(chck24, "추천 및 스폰서 앱 설치를 차단합니다.");
                    tooltip.SetToolTip(chck25, "시작 메뉴의 광고 및 제안을 제거합니다.");
                    tooltip.SetToolTip(chck26, "Windows Ink 영역의 앱 제안을 비활성화합니다.");
                    tooltip.SetToolTip(chck27, "사용하지 않는 Windows 구성 요소를 비활성화합니다.");
                    tooltip.SetToolTip(chck28, "Defender 검사 우선순위를 낮춰 성능 영향을 줄입니다.");
                    tooltip.SetToolTip(chck29, "일부 프로세스 보호 기능을 비활성화하여 성능을 향상시킵니다(주의!).");
                    tooltip.SetToolTip(chck30, "인덱싱 파일을 조각 모음하여 검색 속도를 높입니다.");
                    tooltip.SetToolTip(chck31, "텔레메트리 관련 예약 작업을 비활성화합니다.");
                    tooltip.SetToolTip(chck32, "데이터 수집 텔레메트리 서비스와 구성 요소를 제거합니다.");
                    tooltip.SetToolTip(chck33, "PowerShell이 Microsoft로 데이터를 전송하는 것을 차단합니다.");
                    tooltip.SetToolTip(chck34, "Skype가 텔레메트리 데이터를 수집하고 전송하는 것을 차단합니다.");
                    tooltip.SetToolTip(chck35, "Windows Media Player 사용 보고를 비활성화합니다.");
                    tooltip.SetToolTip(chck36, "Firefox 브라우저 내장 텔레메트리를 비활성화합니다.");
                    tooltip.SetToolTip(chck37, "앱이 광고 ID에 접근하는 것을 차단합니다.");
                    tooltip.SetToolTip(chck38, "타자 스타일 정보 수집을 중지합니다.");
                    tooltip.SetToolTip(chck39, "필기 인식 및 분석 기능을 비활성화합니다.");
                    tooltip.SetToolTip(chck40, "악성코드 자동 보고를 Microsoft로 보내는 것을 차단합니다.");
                    tooltip.SetToolTip(chck41, "Defender가 위협 진단 데이터를 전송하는 것을 차단합니다.");
                    tooltip.SetToolTip(chck42, "Microsoft 클라우드 MAPS 보고 기능을 비활성화합니다.");
                    tooltip.SetToolTip(chck43, "Windows Defender의 Spynet 보고 서비스를 차단합니다.");
                    tooltip.SetToolTip(chck44, "의심 파일을 Microsoft로 자동 전송하는 것을 중지합니다.");
                    tooltip.SetToolTip(chck45, "키보드 입력 데이터 수집을 차단합니다.");
                    tooltip.SetToolTip(chck46, "연락처 동기화 및 공유를 중지합니다.");
                    tooltip.SetToolTip(chck47, "음성 비서 Cortana를 완전히 비활성화합니다.");
                    tooltip.SetToolTip(chck48, "파일 탐색기에서 파일 확장자를 항상 표시하도록 강제합니다.");
                    tooltip.SetToolTip(chck49, "작업 표시줄 투명 효과를 비활성화하여 GPU 사용량을 줄입니다.");
                    tooltip.SetToolTip(chck50, "인터페이스 애니메이션을 비활성화하여 시스템 반응 속도를 높입니다.");
                    tooltip.SetToolTip(chck51, "최근 사용 항목(Jump Lists) 저장을 차단합니다.");
                    tooltip.SetToolTip(chck52, "시작 메뉴 검색창을 아이콘만 표시하도록 변경합니다.");
                    tooltip.SetToolTip(chck53, "파일 탐색기가 '내 PC'에서 열리도록 설정합니다.");
                    tooltip.SetToolTip(chck54, "Xbox 게임 바와 백그라운드 DVR 서비스를 제거합니다.");
                    tooltip.SetToolTip(chck55, "Windows 서비스에 안전한 최적화를 적용합니다.");
                    tooltip.SetToolTip(chck56, "사전 설치된 불필요한 앱(블로트웨어)을 제거합니다.");
                    tooltip.SetToolTip(chck57, "시작 프로그램에서 불필요한 앱을 비활성화합니다.");
                    tooltip.SetToolTip(chck58, "캐시, 임시 파일 및 시스템 로그를 정리합니다.");
                    tooltip.SetToolTip(chck59, "'뉴스 및 관심사' 패널을 작업 표시줄에서 제거합니다.");
                    tooltip.SetToolTip(chck60, "OneDrive와 동기화를 시스템에서 완전히 제거합니다.");
                    tooltip.SetToolTip(chck61, "Xbox 서비스를 비활성화합니다 – 게임을 하지 않는 경우 권장.");
                    tooltip.SetToolTip(chck62, "빠르고 안전한 Cloudflare DNS(1.1.1.1)를 설정합니다.");
                    tooltip.SetToolTip(chck63, "AdwCleaner를 실행하여 애드웨어를 탐지 및 제거합니다.");
                    tooltip.SetToolTip(chck64, "Nagle 알고리즘을 비활성화하여 온라인 게임 지연을 줄입니다.");
                    tooltip.SetToolTip(chck65, "CPU 및 GPU 관리를 최적화하여 앱 성능을 향상시킵니다.");
                    tooltip.SetToolTip(chck66, "Spectre/Meltdown 보호를 비활성화하여 성능을 높입니다(보안성 감소).");
                    tooltip.SetToolTip(chck67, "Windows Defender 백신을 완전히 비활성화합니다.");
                    tooltip.SetToolTip(chck68, "WinSxS 폴더를 정리하여 오래된 시스템 파일 공간을 회복합니다.");
                    tooltip.SetToolTip(chck69, "Windows AI Copilot 보조 기능을 제거합니다.");
                    tooltip.SetToolTip(chck70, "잠금 화면의 '이 사진에 대해 자세히 알아보기' 기능을 비활성화합니다.");
                    tooltip.SetToolTip(chck71, "260자 이상 긴 파일 경로 사용을 가능하게 합니다.");
                    tooltip.SetToolTip(chck72, "클래식 컨텍스트 메뉴(Windows 10 스타일)를 복원합니다.");
                    tooltip.SetToolTip(chck73, "전체 화면 최적화를 비활성화하여 게임에서 더 부드러운 화면을 제공합니다.");
                    tooltip.SetToolTip(chck74, "RAM 성능 향상을 위한 수정 사항을 적용합니다.");
                    tooltip.SetToolTip(chck75, "Microsoft의 알려진 텔레메트리 및 추적 주소를 차단합니다.");
                    tooltip.SetToolTip(chck76, "위치 데이터 공유 호스트를 차단합니다.");
                    tooltip.SetToolTip(chck77, "Microsoft로의 충돌 보고 전송을 중지합니다.");


                    toolStripLabel1.Text = "빌드: 공개 | " + ETBuild;
                }
                if (cinfo.Name == "tr-TR")
                {
                    button7.Text = "tr-TR";
                    Console.WriteLine("Turkish detected");

                    groupBox1.Text = "Performans Ayarları (" + panel1.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox2.Text = "Gizlilik (" + panel2.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox3.Text = "Görsel Ayarları (" + panel3.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox4.Text = "Diğer (" + panel4.Controls.OfType<CheckBox>().Count() + ")";
                    groupBox5.Text = "Uzman Modu (" + panel5.Controls.OfType<CheckBox>().Count() + ")";

                    button1.Text = "Performans";
                    button2.Text = "Görsel";
                    button3.Text = "Gizlilik";
                    selectall0 = "Tümünü Seç";
                    selectall1 = "Tüm Seçimi Kaldır";

                    button4.Text = "Tümünü Seç";
                    button5.Text = "Başlat";

                    toolStripButton2.Text = "Yedekle";
                    toolStripDropDownButton2.Text = "Geri Yükle";
                    registryRestoreToolStripMenuItem.Text = "Kayıt Defterini Geri Yükle";
                    restorePointToolStripMenuItem.Text = "Geri Yükleme Noktası";
                    toolStripButton3.Text = "Hakkında";
                    toolStripButton4.Text = "Bağış Yap";

                    msgend = "Her şey tamamlandı.Yeniden başlatmanız önerilir.";
                    msgerror = "Hiçbir seçenek seçilmedi.";
                    msgupdate = "GitHub'da uygulamanın daha yeni bir sürümü mevcut!";
                    isoinfo = "Oluşturulan ISO aşağıdaki özelliklere sahip olacaktır: ET-Optimizer.exe /auto ve veri toplama, yerel hesap vb. adımları atlayarak Microsoft gereksinimlerini baypas etme.";

                    rebootToSafeModeToolStripMenuItem.Text = "Güvenli Modda Yeniden Başlat";
                    restartExplorerexeToolStripMenuItem.Text = "Explorer.exe'yi Yeniden Başlat";
                    downloadSoftwareToolStripMenuItem.Text = "Yazılımı İndir";

                    toolStripDropDownButton1.Text = "Ekstralar";
                    diskDefragmenterToolStripMenuItem.Text = "Disk Birleştirici";
                    controlPanelToolStripMenuItem.Text = "Denetim Masası";
                    deviceManagerToolStripMenuItem.Text = "Aygıt Yöneticisi";
                    uACSettingsToolStripMenuItem.Text = "UAC Ayarları";
                    servicesToolStripMenuItem.Text = "Hizmetler";
                    remoteDesktopToolStripMenuItem.Text = "Uzak Masaüstü";
                    eventViewerToolStripMenuItem.Text = "Olay Görüntüleyicisi";
                    resetNetworkToolStripMenuItem.Text = "Ağı Sıfırla";

                    updateApplicationsToolStripMenuItem.Text = "Uygulamaları Güncelle";
                    windowsLicenseKeyToolStripMenuItem.Text = "Windows Lisans Anahtarı";
                    rebootToBIOSToolStripMenuItem.Text = "BIOS Yeniden Başlat";
                    makeETISOToolStripMenuItem.Text = "ET Optimizer Uygulanmış.ISO Oluştur";

                    chck1.Text = "Edge WebWidget'ı Devre Dışı Bırak";
                    chck2.Text = "En Üst Düzey Performans Güç Seçen.";
                    chck3.Text = "Svchost için Eşik Bölme";
                    chck4.Text = "Çift Önyükleme Zaman Aşımı 3 sn";
                    chck5.Text = "Hazırda Bekletme/Hızlı Bşl Kapat";
                    chck6.Text = "Windows Insider Deneyler Kapat";
                    chck7.Text = "Uygulama Başlatma İzleme Kapat";
                    chck8.Text = "Güç Kısıtlama Kapat (Intel 6gen+)";
                    chck9.Text = "Arka Plan Uygulamalarını Kapat";
                    chck10.Text = "Yapışkan Tuşlar İstemi Kapat";
                    chck11.Text = "Etkinlik Geçmişini Kapat";
                    chck12.Text = "MS Store Uygulama Güncel. Kapat";
                    chck13.Text = "Uygulamalar SmartScreen Kapat";
                    chck14.Text = "Web Sitesi Yerel Sağlama İzin Ver";
                    chck15.Text = "Microsoft Edge Ayarlarını Düzelt";
                    chck16.Text = "Konum Sensörlerini Kapat";
                    chck17.Text = "WiFi HotSpot Otomatik Paylaş Kapat";
                    chck18.Text = "Paylaşılan HotSpot Bağlantı Kapat";
                    chck19.Text = "Güncelleme Planlanmış Yeniden";
                    chck20.Text = "P2P Güncelleme LAN (yerel) Yap";
                    chck21.Text = "Daha Düşük Kapatma Süresi 2sn";
                    chck22.Text = "Eski Aygıt Sürücülerini Kaldır";
                    chck23.Text = "Daha Fazlasını Al. Özellik Kapat";
                    chck24.Text = "Önerilen Uygulama Yükleme Kapat";
                    chck25.Text = "Başlat Menüsü Reklamları Kapat";
                    chck26.Text = "WindowsInk Uygulama Öneri Kapat";
                    chck27.Text = "Gereksiz Bileşenleri Kapat";
                    chck28.Text = "Defender Zamanlanmış Tarama";
                    chck29.Text = "İşlem Azaltmayı Kapat";
                    chck30.Text = "Dizin Oluşturma Hizmeti Birleştir";
                    chck31.Text = "Telemetri Zamanlanmış Görev Kap";
                    chck32.Text = "Telemetri/Veri Toplamayı Kaldır";
                    chck33.Text = "PowerShell Telemetrisini Kapat";
                    chck34.Text = "Skype Telemetrisini Kapat";
                    chck35.Text = "Medya Oynatıcı Kullanım Rap Kapat";
                    chck36.Text = "Mozilla Telemetrisini Kapat";
                    chck37.Text = "Reklam Kimliğimi Kullanım Kapat";
                    chck38.Text = "Yazma Hakkında Bilgi Gönder Kapat";
                    chck39.Text = "El Yazısı Tanımayı Kapat";
                    chck40.Text = "Watson Kötü Yazılım Rapor Kapat";
                    chck41.Text = "Kötü Yazılım Teşhis Veri Kapat";
                    chck42.Text = "MS MAPS'e Raporlamayı Kapat";
                    chck43.Text = "Spynet Defender Rapor Kapat";
                    chck44.Text = "Kötü Yazılım Örneklerini Gönderme";
                    chck45.Text = "Yazma Örneklerini Gönderme Kapat";
                    chck46.Text = "MS'ye Kişi Göndermeyi Kapat";
                    chck47.Text = "Cortana'yı Kapat";
                    chck48.Text = "Explorer'da Dosya Uzantısı Göster";
                    chck49.Text = "Görev Çubuğu Şeffaflığı Kapat";
                    chck50.Text = "Windows Animasyonlarını Kapat";
                    chck51.Text = "MRU listelerini (atlama) Kapat";
                    chck52.Text = "Arama Kutusu Yalnızca Simge";
                    chck53.Text = "Bu Bilgisayarda Explorer Açık";
                    chck54.Text = "Windows Oyun Çubuğu/DVR Kaldır";
                    chck55.Text = "Hizmet Ayarlamalarını Etkinleştir";
                    chck56.Text = "Bloatware'i (Önceden Yük) Kaldır";
                    chck57.Text = "Gereksiz Başlangıç Uygulamaları";
                    chck58.Text = "Geçici Dosya/Önbellek/Günlük Tmz.";
                    chck59.Text = "Haberler ve İlgi/Widget Kaldır";
                    chck60.Text = "Microsoft OneDrive'ı kaldır";
                    chck61.Text = "Xbox Hizmetlerini devre dışı bırak";
                    chck62.Text = "Hızlı/Güvenli DNS (1.1.1.1)";
                    chck63.Text = "Reklam Yazılımları Tara (AdwCl)";
                    chck64.Text = "Nagle's Alg. (Gecikmeli ACK) Kapat";
                    chck65.Text = "CPU/GPU Öncelik Ayarlamaları";
                    chck66.Text = "Spectre/Meltdown'u Kapat";
                    chck67.Text = "Windows Defender'ı Kapat";
                    chck68.Text = "WinSxS Klasörünü Temizle";
                    chck69.Text = "Copilot'u kaldır";
                    chck70.Text = "Bu fotoğraf hakkında bilgi kald";
                    chck71.Text = "Uzun Sistem Yollarını Etkinleştir";
                    chck72.Text = "Eski Bağlam Menüsünü Etkinleştir";
                    chck73.Text = "Tam Ekran Optimizasyonları Kapat";
                    chck74.Text = "RAM Bellek Ayarlarını Etkinleştir";
                    chck75.Text = "Telemetri ve kullanıcı sunucuları engelle";
                    chck76.Text = "Konum paylaşım sunucularını engelle";
                    chck77.Text = "Windows çökme raporu sunucularını engelle";
                    chck78.Text = "Giriş arka planını kapat";


                    tooltip.SetToolTip(chck1, "Edge WebWidget'i devre dışı bırakarak kaynak ve bellek kullanımını azaltır.");
                    tooltip.SetToolTip(chck2, "Windows güç planını Ultimate Performance olarak ayarlayarak daha iyi yanıt süresi sağlar.");
                    tooltip.SetToolTip(chck3, "Hizmetlerin ayrı svchost süreçlerinde çalışmasına izin vererek kararlılığı artırır.");
                    tooltip.SetToolTip(chck4, "Önyükleme menüsü bekleme süresini 3 saniyeye indirir, böylece daha hızlı başlatma sağlar.");
                    tooltip.SetToolTip(chck5, "Hibernasyon ve hızlı başlatmayı devre dışı bırakarak disk alanı boşaltır.");
                    tooltip.SetToolTip(chck6, "Windows Insider programındaki deneysel özellikleri kapatır.");
                    tooltip.SetToolTip(chck7, "Sistemin hangi uygulamaları açtığınızı izlemesini durdurur.");
                    tooltip.SetToolTip(chck8, "CPU güç kısıtlamasını devre dışı bırakır (Intel 6. nesil ve sonrası) – tam performans sağlar.");
                    tooltip.SetToolTip(chck9, "Arka plandaki uygulamaların çalışmasını durdurarak performans ve enerji tasarrufu sağlar.");
                    tooltip.SetToolTip(chck10, "Yapışkan Tuşlar (Sticky Keys) açılır pencerelerini kapatır.");
                    tooltip.SetToolTip(chck11, "Windows etkinlik geçmişinin kaydedilmesini engeller.");
                    tooltip.SetToolTip(chck12, "Microsoft Store uygulamalarının otomatik güncellemelerini durdurur.");
                    tooltip.SetToolTip(chck13, "Bilinmeyen programları kontrol eden uygulamalar için SmartScreen filtresini kapatır.");
                    tooltip.SetToolTip(chck14, "Web sitelerinin konumunuza erişimini engeller.");
                    tooltip.SetToolTip(chck15, "Edge tarayıcısının ayarlarını varsayılana sıfırlar.");
                    tooltip.SetToolTip(chck16, "Sensörleri ve konum servislerini kapatarak maksimum gizlilik sağlar.");
                    tooltip.SetToolTip(chck17, "Wi-Fi hotspot'unuzun otomatik paylaşımını yasaklar.");
                    tooltip.SetToolTip(chck18, "Paylaşılan hotspot bağlantılarını engelleyerek güvenliği artırır.");
                    tooltip.SetToolTip(chck19, "Güncellemelerden sonra yeniden başlatma öncesi bildirim zorunlu kılar.");
                    tooltip.SetToolTip(chck20, "Güncelleme paylaşımını sadece yerel ağ ile sınırlar.");
                    tooltip.SetToolTip(chck21, "Sistemin kapanma süresini kısaltır – daha hızlı kapanma sağlar.");
                    tooltip.SetToolTip(chck22, "Kullanılmayan cihaz sürücülerini kaldırarak yer açar.");
                    tooltip.SetToolTip(chck23, "'Windows'tan Daha Fazlasını Edinin' karşılama ekranını kaldırır.");
                    tooltip.SetToolTip(chck24, "Önerilen ve sponsorlu uygulamaların kurulmasını engeller.");
                    tooltip.SetToolTip(chck25, "Başlat menüsündeki reklamları ve önerileri kaldırır.");
                    tooltip.SetToolTip(chck26, "Windows Ink alanındaki uygulama önerilerini kapatır.");
                    tooltip.SetToolTip(chck27, "Kullanılmayan Windows bileşenlerini devre dışı bırakır.");
                    tooltip.SetToolTip(chck28, "Defender taramalarının önceliğini düşürerek performans etkisini azaltır.");
                    tooltip.SetToolTip(chck29, "Bazı süreç korumalarını kapatarak performansı artırır (dikkat!).");
                    tooltip.SetToolTip(chck30, "İndeksleme dosyasını birleştirerek aramayı hızlandırır.");
                    tooltip.SetToolTip(chck31, "Telemetri ile ilgili zamanlanmış görevleri kapatır.");
                    tooltip.SetToolTip(chck32, "Telemetri verilerini toplayan servisleri ve bileşenleri kaldırır.");
                    tooltip.SetToolTip(chck33, "PowerShell'in Microsoft'a veri göndermesini engeller.");
                    tooltip.SetToolTip(chck34, "Skype'ın telemetri verisi toplamasını ve göndermesini engeller.");
                    tooltip.SetToolTip(chck35, "Windows Media Player kullanım raporlarını kapatır.");
                    tooltip.SetToolTip(chck36, "Firefox tarayıcısındaki yerleşik telemetriyi kapatır.");
                    tooltip.SetToolTip(chck37, "Uygulamaların reklam kimliğinize erişimini engeller.");
                    tooltip.SetToolTip(chck38, "Yazma stilinizle ilgili bilgi toplamasını durdurur.");
                    tooltip.SetToolTip(chck39, "El yazısı tanıma ve analizini kapatır.");
                    tooltip.SetToolTip(chck40, "Microsoft'a kötü amaçlı yazılım otomatik raporlarını engeller.");
                    tooltip.SetToolTip(chck41, "Defender'ın tehdit tanı verilerini göndermesini engeller.");
                    tooltip.SetToolTip(chck42, "Microsoft'un bulut tabanlı MAPS raporlamasını kapatır.");
                    tooltip.SetToolTip(chck43, "Windows Defender'daki Spynet raporlama servisini engeller.");
                    tooltip.SetToolTip(chck44, "Şüpheli dosyaların Microsoft'a otomatik gönderimini durdurur.");
                    tooltip.SetToolTip(chck45, "Klavye ile yazılan metin verilerinin toplanmasını engeller.");
                    tooltip.SetToolTip(chck46, "Kişi senkronizasyonu ve paylaşımını durdurur.");
                    tooltip.SetToolTip(chck47, "Sesli asistan Cortana'yı tamamen kapatır.");
                    tooltip.SetToolTip(chck48, "Dosya Gezgini'nde dosya uzantılarının gösterilmesini zorunlu kılar.");
                    tooltip.SetToolTip(chck49, "Görev çubuğu şeffaflığını kapatarak GPU kullanımını azaltır.");
                    tooltip.SetToolTip(chck50, "Arayüz animasyonlarını kapatarak sistem tepkisini hızlandırır.");
                    tooltip.SetToolTip(chck51, "Son kullanılan öğeler (Jump Lists) kaydedilmesini engeller.");
                    tooltip.SetToolTip(chck52, "Başlat menüsü arama kutusunu sadece simge olarak değiştirir.");
                    tooltip.SetToolTip(chck53, "Dosya Gezgini'nin 'Bu Bilgisayar' klasöründe açılmasını sağlar.");
                    tooltip.SetToolTip(chck54, "Xbox oyun çubuğu ve arka plandaki DVR servislerini kaldırır.");
                    tooltip.SetToolTip(chck55, "Windows servislerine güvenli optimizasyonlar uygular.");
                    tooltip.SetToolTip(chck56, "Önceden yüklenmiş gereksiz uygulamaları (bloatware) kaldırır.");
                    tooltip.SetToolTip(chck57, "Başlangıçta gereksiz programları devre dışı bırakır.");
                    tooltip.SetToolTip(chck58, "Önbellek, geçici dosyalar ve sistem günlüklerini temizler.");
                    tooltip.SetToolTip(chck59, "Görev çubuğundaki 'Haberler ve İlgi Alanları' panelini kaldırır.");
                    tooltip.SetToolTip(chck60, "OneDrive'ı ve senkronizasyonu sistemden tamamen kaldırır.");
                    tooltip.SetToolTip(chck61, "Xbox servislerini kapatır – oyun oynamıyorsanız önerilir.");
                    tooltip.SetToolTip(chck62, "Hızlı ve güvenli Cloudflare DNS (1.1.1.1) ayarlar.");
                    tooltip.SetToolTip(chck63, "AdwCleaner'ı başlatarak reklam yazılımlarını tespit ve kaldırır.");
                    tooltip.SetToolTip(chck64, "Nagle algoritmasını kapatarak çevrimiçi oyun gecikmesini azaltır.");
                    tooltip.SetToolTip(chck65, "CPU ve GPU yönetimini optimize ederek uygulama performansını artırır.");
                    tooltip.SetToolTip(chck66, "Spectre/Meltdown korumalarını kapatarak performansı artırır (daha az güvenli).");
                    tooltip.SetToolTip(chck67, "Windows Defender antivirüsünü tamamen kapatır.");
                    tooltip.SetToolTip(chck68, "WinSxS klasörünü temizleyerek eski sistem dosyalarının kapladığı alanı boşaltır.");
                    tooltip.SetToolTip(chck69, "Windows AI Copilot asistanını sistemden kaldırır.");
                    tooltip.SetToolTip(chck70, "Kilit ekranındaki 'Bu fotoğraf hakkında daha fazla bilgi edin' özelliğini kapatır.");
                    tooltip.SetToolTip(chck71, "260 karakterden uzun dosya yollarını kullanmanıza izin verir.");
                    tooltip.SetToolTip(chck72, "Klasik bağlam menüsünü (Windows 10 tarzı) geri getirir.");
                    tooltip.SetToolTip(chck73, "Tam ekran optimizasyonlarını kapatarak oyunlarda daha akıcı performans sağlar.");
                    tooltip.SetToolTip(chck74, "RAM performansını artıran düzeltmeleri uygular.");
                    tooltip.SetToolTip(chck75, "Microsoft'un bilinen telemetri ve takip adreslerini engeller.");
                    tooltip.SetToolTip(chck76, "Konum verisi paylaşan sunucuları engeller.");
                    tooltip.SetToolTip(chck77, "Microsoft'a çökme raporu gönderimini durdurur.");


                    toolStripLabel1.Text = "Derleme: Genel | " + ETBuild;
                }
                if (args != null && args.Length > 0)
                {
                    if (args.Contains("/english") || args.Contains("/eng") || args.Contains("-english") || args.Contains("-eng"))
                    {
                        engforced = true;
                        DefaultLang();
                    }
                }
                if (cinfo.Name != "pl-PL" && cinfo.Name != "ru-RU" && cinfo.Name != "be-BY" && cinfo.Name != "de-DE" && cinfo.Name != "pt-BR" && cinfo.Name != "fr-FR" && cinfo.Name != "ko-KR" && cinfo.Name != "tr-TR")
                {
                    button7.Enabled = false;
                    button7.Visible = false;
                }
                groupBox6.Text = chck56.Text;
                customGroup6.Text = chck56.Text;
            }
            ChangeLang();

            groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button2.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);

            groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button3.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);

            groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);

            groupBox6.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            customGroup6.ForeColor = System.Drawing.ColorTranslator.FromHtml("#bdc3c7");


            if (args.Contains("/auto") || args.Contains("-auto") || args.Contains("auto"))
            {
                isswitch = true;
                button5_Click(null, EventArgs.Empty);
            }
            else
            {
                if (args.Contains("/all") || args.Contains("-all") || args.Contains("all"))
                {
                    isswitch = true;
                    button4_Click(null, EventArgs.Empty);
                    button5_Click(null, EventArgs.Empty);

                }
                else
                {
                    if (args.Contains("/expert") || args.Contains("-expert") || args.Contains("expert"))
                    {
                        isswitch = true;
                        chck61.Checked = true;
                        chck62.Checked = true;
                        chck60.Checked = true;
                        chck66.Checked = true;
                        chck29.Checked = true;
                        chck67.Checked = true;
                        button4_Click(null, EventArgs.Empty);
                        button5_Click(null, EventArgs.Empty);

                    }
                    else
                    {
                        if (args.Contains("/sillent") || args.Contains("-sillent") || args.Contains("sillent"))
                        {
                            isswitch = true;
                            issillent = true;
                            button5_Click(null, EventArgs.Empty);
                        }
                    }

                }
            }
        }

        private async Task CheckUpdateET()
        {
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.UserAgent.ParseAdd("check-app");

                try
                {
                    var response = await client.GetStringAsync("https://api.github.com/repos/semazurek/ET-Optimizer");
                    var json = JObject.Parse(response);

                    var updatedAt = DateTime.Parse(json["pushed_at"]?.ToString() ?? "").ToLocalTime();
                    var localDate = File.GetLastWriteTime(System.Reflection.Assembly.GetExecutingAssembly().Location);

                    if (updatedAt > localDate)
                    {
                        var resultUET = MessageBox.Show(msgupdate, ETVersion, MessageBoxButtons.OKCancel, MessageBoxIcon.Information);
                        if (resultUET == DialogResult.OK)
                        {
                            Process.Start("https://github.com/semazurek/ET-Optimizer/releases/latest");
                        }
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Update check failed: " + ex.Message);
                }
            }
        }
        public Form BuildSplashForm()
        {
            Form splash = new Form();
            splash.FormBorderStyle = FormBorderStyle.None;
            splash.StartPosition = FormStartPosition.CenterScreen;
            splash.BackColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
            splash.Width = 400;
            splash.Height = 240;
            splash.TopMost = true;
            splash.ShowInTaskbar = false;
            splash.ControlBox = false;

            PictureBox logoBox = new PictureBox()
            {
                Image = Properties.Resources.ET_LOGO_BIG,
                SizeMode = PictureBoxSizeMode.Zoom,
                Size = new Size(150, 150),
                Location = new Point((splash.ClientSize.Width - 150) / 2, 30)
            };
            splash.Controls.Add(logoBox);

            ProgressBar progressBar = new ProgressBar()
            {
                Style = ProgressBarStyle.Marquee,
                MarqueeAnimationSpeed = 30,
                Size = new Size(400, 20),
                Location = new Point(0, 220),
                ForeColor = Color.FromArgb(52, 152, 219)
            };
            splash.Controls.Add(progressBar);


            return splash;
        }

        private Form splashForm;
        private async void Form1_Load(object sender, EventArgs e)
        {
            centergroup();
            Relocatecheck(panel1);
            Relocatecheck(panel2);
            Relocatecheck(panel3);
            Relocatecheck(panel4);
            Relocatecheck(panel5);
            Relocatecheck(panel5);


            this.panelmain.DoubleClick += Panelmain_DoubleClick;

            this.Hide();

            this.FormBorderStyle = FormBorderStyle.None;

            this.ShowInTaskbar = false;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            string programDataPath = Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData);
            string fileName = "ET-lunched.txt";
            string fullPath = Path.Combine(programDataPath, fileName);
            if (!File.Exists(fullPath))
            {
                File.WriteAllText(fullPath, "This file indicates for ET doesnt need to create more restorepoints.");

                if (issillent == false)
                {
                    Thread splashThread = new Thread(new ThreadStart(() =>
                    {
                        splashForm = BuildSplashForm();
                        Application.Run(splashForm);
                    }));

                    splashThread.SetApartmentState(ApartmentState.STA);
                    splashThread.Start();

                    await Task.Delay(500);

                    await Task.Run(() => BackItUp());

                    if (splashForm != null && !splashForm.IsDisposed)
                    {
                        splashForm.Invoke(new Action(() =>
                        {
                            splashForm.Close();

                        }));
                    }

                    System.Threading.Thread.Sleep(1000);
                    this.Show();

                    this.Opacity = 1;
                    this.Enabled = true;
                    this.BringToFront();
                    this.Activate();
                    this.ShowInTaskbar = true;
                }
                else
                {
                    CreateRestorePoint("ET_BACKUP-APPLICATION_INSTALL", 0);
                    CreateRestorePoint("ET_BACKUP-DEVICE_DRIVER_INSTALL", 10);
                    CreateRestorePoint("ET_BACKUP-MODIFY_SETTINGS", 12);

                }
            }
            else
            {
                this.Show();

                this.Opacity = 1;
                this.Enabled = true;
                this.BringToFront();
                this.Activate();
                this.ShowInTaskbar = true;
            }

            string msconfigPath = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "bcdedit.exe"
);

            if (!File.Exists(msconfigPath))
            {
                msconfigPath = Path.Combine(Environment.SystemDirectory, "bcdedit.exe");
            }
            Process.Start(new ProcessStartInfo
            {
                Arguments = "/deletevalue {current} safeboot",
                FileName = msconfigPath,
                UseShellExecute = true
            });

            await CheckUpdateET();

        }

        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void ToolStrip1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void label1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void label1_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }


        private void panelmain_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        public void doengine()
        {

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            Application.VisualStyleState = VisualStyleState.NonClientAreaEnabled;
            button5.Enabled = false;
            groupBox1.Visible = false;
            groupBox2.Visible = false;
            groupBox3.Visible = false;
            groupBox4.Visible = false;
            groupBox5.Visible = false;
            groupBox6.Visible = false;
            button1.Visible = false;
            button2.Visible = false;
            button3.Visible = false;
            button4.Visible = false;
            button5.Visible = false;
            pictureBox4.Visible = true;
            textBox1.Visible = true;
            progressBar1.BringToFront();
            textBox1.BringToFront();

            int alltodo = 0; //max 78
            int done = 0;
            foreach (CheckBox checkbox in panel1.Controls)
            {
                if (checkbox.Checked)
                {
                    alltodo++;
                }
            }
            foreach (CheckBox checkbox in panel2.Controls)
            {
                if (checkbox.Checked)
                {
                    alltodo++;
                }
            }
            foreach (CheckBox checkbox in panel3.Controls)
            {
                if (checkbox.Checked)
                {
                    alltodo++;
                }
            }
            foreach (CheckBox checkbox in panel4.Controls)
            {
                if (checkbox.Checked)
                {
                    alltodo++;
                }
            }
            foreach (CheckBox checkbox in panel5.Controls)
            {
                if (checkbox.Checked)
                {
                    alltodo++;
                }
            }
            progressBar1.Visible = true;
            progressBar1.Minimum = 0;
            progressBar1.Maximum = alltodo;
            progressBar1.Value = done;

            //Performance Panel
            foreach (CheckBox checkBox in panel1.Controls)
            {

                progressBar1.Value = done;
                if (checkBox.Checked)
                {
                    checkBox.Checked = false;
                    string timelog = DateTime.Now.ToString("[HH:mm:ss] ");
                    textBox1.Text += timelog + checkBox.Text + Environment.NewLine;
                    textBox1.SelectionStart = textBox1.TextLength;
                    textBox1.ScrollToCaret();
                    string caseSwitch = checkBox.Tag as string;

                    switch (caseSwitch)
                    {
                        case "Disable Edge WebWidget":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "WebWidgetAllowed", 0, RegistryValueKind.DWord);

                            break;
                        case "Power Option to Ultimate Perform.":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg -setactive scheme_min";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg /S ceb6bfc7-d55c-4d56-ae37-ff264aade12d";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg /X standby-timeout-ac 0";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg /X standby-timeout-dc 0";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Dual Boot Timeout 3sec":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C bcdedit /set timeout 3";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            string msconfigPath2 = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "bcdedit.exe"
);

                            if (!File.Exists(msconfigPath2))
                            {
                                msconfigPath2 = Path.Combine(Environment.SystemDirectory, "bcdedit.exe");
                            }
                            Process.Start(new ProcessStartInfo
                            {
                                Arguments = "/set timeout 3",
                                FileName = msconfigPath2,
                                UseShellExecute = true
                            });
                            break;
                        case "Disable Hibernation/Fast Startup":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg -hibernate off";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Windows Insider Experiments":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System\", "AllowExperimentation", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation\", "value", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable App Launch Tracking":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "Start_TrackProgs", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Powerthrottling (Intel 6gen+)":
                            done++;

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling\", "PowerThrottlingOff", 1, RegistryValueKind.DWord);
                            break;
                        case "Turn Off Background Apps":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy\", "LetAppsRunInBackground", 2, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\", "GlobalUserDisabled", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Search\", "BackgroundAppGlobalToggle", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\", "BackgroundServicesPriority", 10, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\", "SystemResponsiveness", 10, RegistryValueKind.DWord);
                            break;
                        case "Disable Sticky Keys Prompt":
                            done++;

                            SetRegistryValue(@"HKCU\Control Panel\Accessibility\StickyKeys\", "Flags", @"506", RegistryValueKind.String);
                            break;
                        case "Disable Activity History":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\System\", "PublishUserActivities", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Updates for MS Store Apps":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\WindowsStore\", "AutoDownload", 2, RegistryValueKind.DWord);
                            break;
                        case "SmartScreen Filter for Apps Disable":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost\", "EnableWebContentEvaluation", 0, RegistryValueKind.DWord);
                            break;
                        case "Let Websites Provide Locally":
                            done++;

                            SetRegistryValue(@"HKCU\Control Panel\International\User Profile\", "HttpAcceptLanguageOptOut", 1, RegistryValueKind.DWord);
                            break;
                        case "Fix Microsoft Edge Settings":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main\", "AllowPrelaunch", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "WalletDonationEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "CryptoWalletEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "EdgeAssetDeliveryServiceEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "DiagnosticData", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "WebWidgetAllowed", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "ShowMicrosoftRewards", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "MicrosoftEdgeInsiderPromotionEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "EdgeShoppingAssistantEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "EdgeFollowEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "EdgeCollectionsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "AlternateErrorPagesEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "ConfigureDoNotTrack", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "UserFeedbackAllowed", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "EdgeEnhanceImagesEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "PersonalizationReportingEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "ShowRecommendationsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main\", "DoNotTrack", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes\", "ShowSearchSuggestionsGlobal", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead\", "FPEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter\", "EnabledV9", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "HideFirstRunExperience", 1, RegistryValueKind.DWord);
                            break;
                        case "Disable Nagle's Alg. (Delayed ACKs)":
                            done++;

                            SetRegistryValue(@"HKLM\Software\Microsoft\MSMQ\Parameters\", "TcpNoDelay", 1, RegistryValueKind.DWord);
                            break;
                        case "CPU/GPU Priority Tweaks":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\DirectX\GraphicsSettings\", "SwapEffectUpgradeCache", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\DirectX\UserGpuPreferences\", "DirectXUserGlobalSettings", @"SwapEffectUpgradeEnable=1", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters\", "ThreadPriority", 31, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters\", "ThreadPriority", 31, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters\", "ThreadPriority", 31, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\", "ThreadPriority", 31, RegistryValueKind.DWord);

                            string numProc = Environment.GetEnvironmentVariable("NUMBER_OF_PROCESSORS");

                            string msconfigPath = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "bcdedit.exe"
);

                            if (!File.Exists(msconfigPath))
                            {
                                msconfigPath = Path.Combine(Environment.SystemDirectory, "bcdedit.exe");
                            }
                            Process.Start(new ProcessStartInfo
                            {
                                Arguments = $"/set {{current}} numproc {numProc}",
                                FileName = msconfigPath,
                                UseShellExecute = true
                            });
                    

                    startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-WmiObject win32_Processor | findstr /r \"Intel\" > NOLPi.txt";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();


                            string NOLPi = File.ReadAllText("NOLPi.txt");
                            if (NOLPi is null)
                            {
                                Console.WriteLine("amd");

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "GPU Priority", 8, RegistryValueKind.DWord);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Priority", 6, RegistryValueKind.DWord);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Scheduling Category", @"High", RegistryValueKind.String);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "FIO Priority", @"High", RegistryValueKind.String);
                            }
                            else
                            {
                                Console.WriteLine("intel");

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Affinity", 0, RegistryValueKind.DWord);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Background Only", @"False", RegistryValueKind.String);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Scheduling Category", @"High", RegistryValueKind.String);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "SFIO Priority", @"High", RegistryValueKind.String);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "GPU Priority", 8, RegistryValueKind.DWord);

                                SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games\", "Priority", 6, RegistryValueKind.DWord);

                            }
                            if (File.Exists("NOLPi.txt"))
                            {
                                File.Delete("NOLPi.txt");
                            }

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wininit.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Battle.net.exe\PerfOptions", "CpuPriorityClass", 5, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Agent.exe\PerfOptions", "CpuPriorityClass", 5, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Steam.exe\PerfOptions", "CpuPriorityClass", 5, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EpicGamesLauncher.exe\PerfOptions", "CpuPriorityClass", 5, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EADesktop.exe\PerfOptions", "CpuPriorityClass", 5, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QtWebEngineProcess.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\QtWebEngineProcess.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamservice.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EABackgroundService.exe\PerfOptions", "CpuPriorityClass", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EABackgroundService.exe\PerfOptions", "IoPriority", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dllhost.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Intelligent standby list cleaner ISLC.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Overwatch.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\starwarsbattlefrontii.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\bfv.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ModernWarfare.exe", "UseLargePages", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BF2042.exe", "UseLargePages", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters", "ThreadPriority", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters", "ThreadPriority", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters", "ThreadPriority", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters", "ThreadPriority", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters", "ThreadPriority", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters", "ThreadPriority", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile", "AlwaysOn", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile", "IdleDetectionCycles", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile", "SystemResponsiveness", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile", "NoLazyMode", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile", "LazyModeTimeout", 10000, RegistryValueKind.DWord);


                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog", "Start", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "DpcWatchdogProfileOffset", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "MaximumSharedReadyQueueSize", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "DisableAutoBoost", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "DpcTimeout", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "IdealDpcRate", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "MaximumDpcQueueDepth", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "MinimumDpcRate", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "ThreadDpcEnable", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "AdjustDpcThreshold", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "DpcWatchdogPeriod", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "GlobalTimerResolutionRequests", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "SplitLargeCaches", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "DistributeTimers", 4, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel", "InterruptSteeringDisabled", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System", "PassiveIntRealTimeWorkerPriority", 18, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\mlx4_bus\Parameters", "ThreadDpcEnable", 4, RegistryValueKind.DWord);

                            break;
                        case "Disable Location Sensors":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}\", "SensorPermissionState", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable WiFi HotSpot Auto-Sharing":
                            done++;

                            SetRegistryValue(@"HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting\", "value", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Shared HotSpot Connect":
                            done++;

                            SetRegistryValue(@"HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots\", "value", 0, RegistryValueKind.DWord);
                            break;
                        case "Updates Notify to Sched. Restart":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings\", "UxOption", 1, RegistryValueKind.DWord);
                            break;
                        case "P2P Update Setting to LAN (local)":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config\", "DODownloadMode", 0, RegistryValueKind.DWord);
                            break;
                        case "Set Lower Shutdown Time (2sec)":
                            done++;

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\", "WaitToKillServiceTimeout", @"2000", RegistryValueKind.String);
                            break;
                        case "Remove Old Device Drivers":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C SET DEVMGR_SHOW_NONPRESENT_DEVICES=1";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Get Even More Out of...":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-310093Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-314559Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-314563Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338387Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338388Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338389Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338393Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-353698Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338388Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338389Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-353694Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement\", "ScoobeSystemSettingEnabled", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Installing Suggested Apps":
                            done++;

                            Registry.CurrentUser.DeleteSubKeyTree(@"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions", false);

                            Registry.CurrentUser.DeleteSubKeyTree(@"Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps", false);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent\", "DisableWindowsConsumerFeatures", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\PushToInstall\", "DisablePushToInstall", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-353696Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-353694Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338393Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338388Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-310093Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContentEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "RemediationRequired", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SoftLandingEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "ContentDeliveryAllowed", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "OemPreInstalledAppsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "PreInstalledAppsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "PreInstalledAppsEverEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SilentInstalledAppsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "FeatureManagementEnabled", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Start Menu Ads/Suggestions":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SubscribedContent-338387Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "RotatingLockScreenOverlayEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "RotatingLockScreenEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\", "SystemPaneSuggestionsEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "ShowSyncProviderNotifications", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start\", "HideRecommendedSection", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education\", "IsEducationEnvoironment", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Explorer\", "HideRecommendedSection", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Policies\Microsoft\Windows\Explorer\", "HideRecommendedSection", 1, RegistryValueKind.DWord);
                            break;
                        case "Disable Suggest Apps WindowsInk":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\PolicyManager\default\WindowsInkWorkspace\AllowSuggestedAppsInWindowsInkWorkspace\", "value", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Unnecessary Components":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command disable-windowsoptionalfeature -online -featureName Printing-XPSServices-Features -NoRestart; disable-windowsoptionalfeature -online -featureName Xps-Foundation-Xps-Viewer -NoRestart; disable-windowsoptionalfeature -online -featureName Recall -NoRestart";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Defender Scheduled Scan Nerf":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Scheduled Scan\" /RL LIMITED";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Defragment Indexing Service File":
                            done++;

                            StopService("wsearch");


                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C esentutl /d %programdata%\\ProgramData\\Microsoft\\Search\\Data\\Applications\\Windows\\Windows.edb";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            StartService("wsearch");

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-Volume | Optimize-Volume -defrag -ReTrim";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Enable Service Tweaks":
                            done++;

                            string[] toDisable = { "DiagTrack", "diagnosticshub.standardcollector.service", "dmwappushservice", "RemoteRegistry", "RemoteAccess", "SCardSvr", "SCPolicySvc", "fax", "WerSvc", "NvTelemetryContainer", "gadjservice", "AdobeARMservice", "PSI_SVC_2", "lfsvc", "WalletService", "RetailDemo", "SEMgrSvc", "diagsvc", "AJRouter", "amdfendr", "amdfendrmgr" };
                            string[] toManuall = { "BITS", "SamSs", "TapiSrv", "seclogon", "wuauserv", "PhoneSvc", "lmhosts", "iphlpsvc", "gupdate", "gupdatem", "edgeupdate", "edgeupdatem", "MapsBroker", "PnkBstrA", "brave", "bravem", "asus", "asusm", "adobeupdateservice", "adobeflashplayerupdatesvc", "WSearch", "CCleanerPerformanceOptimizerService" };

                            foreach (string s in toDisable)
                            {
                                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                                startInfo.FileName = "cmd.exe";
                                startInfo.Arguments = "/C sc stop " + s;
                                process.StartInfo = startInfo;
                                process.Start(); process.WaitForExit();

                                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                                startInfo.FileName = "cmd.exe";
                                startInfo.Arguments = "/C sc config " + s + " start= disabled";
                                process.StartInfo = startInfo;
                                process.Start(); process.WaitForExit();
                            }

                            foreach (string s in toManuall)
                            {
                                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                                startInfo.FileName = "cmd.exe";
                                startInfo.Arguments = "/C sc config " + s + " start= demand";
                                process.StartInfo = startInfo;
                                process.Start(); process.WaitForExit();
                            }

                            SetRegistryValue(@"HKCU\Software\Microsoft\GameBar\", "AutoGameModeEnabled", 1, RegistryValueKind.DWord);
                            break;
                        case "Disable Fullscreen Optimizations":
                            done++;

                            SetRegistryValue(@"HKCU\System\GameConfigStore\", "GameDVR_DXGIHonorFSEWindowsCompatible", 1, RegistryValueKind.DWord);

                            break;
                        case "RAM Memory Tweaks":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Disable-MMAgent -MemoryCompression -PageCombining";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Enable-MMAgent -ApplicationPreLaunch";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "DisablePagingExecutive", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager", "DisablePagingExecutive", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "LargeSystemCache", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\FTH", "Enabled", 0, RegistryValueKind.DWord);
                            Registry.LocalMachine.DeleteSubKeyTree(@"SOFTWARE\Microsoft\FTH\State\", false);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "DisablePageCombining", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "DisablePagingCombining", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager", "HeapDeCommitFreeBlockThreshold", 40000, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "CacheUnmapBehindLengthInMB", 100, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "ModifiedWriteMaximum", 20, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "ClearPageFileAtShutdown", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "NonPagedPoolQuota", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "NonPagedPoolSize", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "PagedPoolQuota", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "PagedPoolSize", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "SecondLevelDataCache", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "PhysicalAddressExtension", 1, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "SimulateCommitSavings", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "TrackLockedPages", 0, RegistryValueKind.DWord);
                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management", "TrackPtes", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager", "AlpcWakePolicy", 1, RegistryValueKind.DWord);

                            break;
                        case "Remove Bloatware (Preinstalled)":
                            done++;
                            SaveUncheckedToWhitelist();
                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications\", "ConfigureChatAutoInstall", 0, RegistryValueKind.DWord);

                            string whitelistFile = "whitelist.txt";
                            if (File.Exists(whitelistFile))
                            {
                                var additional = File.ReadAllLines(whitelistFile)
                                                     .Where(line => !string.IsNullOrWhiteSpace(line))
                                                     .Select(line => line.Trim());
                                foreach (var app in additional)
                                    whitelistapps.Add(app);
                            }

                            string psCommand = @"
$allApps = Get-AppxPackage -AllUsers | Select-Object -ExpandProperty Name;
$whitelist = @(" + string.Join(",", whitelistapps.Select(w => "'" + w.Replace("'", "''") + "'")) + @");
$whitelist = $whitelist | ForEach-Object { $_.ToLowerInvariant().Trim() };

foreach ($app in $allApps) {
    if ($whitelist -notcontains $app.ToLowerInvariant().Trim()) {
        try {
            Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue;
        } catch {}
        try {
            Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $app } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue;
        } catch {}
    }
}
";

                            ProcessStartInfo startInfoB = new ProcessStartInfo()
                            {
                                FileName = "powershell.exe",
                                Arguments = $"-Command \"{psCommand}\"",
                                WindowStyle = ProcessWindowStyle.Hidden,
                                UseShellExecute = false,
                                CreateNoWindow = true,
                                Verb = "runas"
                            };

                            using (var processB = new Process())
                            {
                                processB.StartInfo = startInfoB;
                                processB.Start();
                                processB.WaitForExit();
                            }
                            panel6.Controls.Clear();
                            LoadAppxPackages();
                            if (File.Exists("whitelist.txt"))
                            {
                                File.Delete("whitelist.txt");
                            }
                            break;
                        case "Disable Unnecessary Startup Apps":
                            done++;

                            string[] keysToClean =
                            {
    @"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run|SunJavaUpdateSched",
    @"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|SunJavaUpdateSched",
    @"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MTPW",
    @"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run|TeamsMachineInstaller",
    @"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|TeamsMachineInstaller",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|CiscoMeetingDaemon",
    @"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run|Adobe Reader Speed Launcher",
    @"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Adobe Reader Speed Launcher",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|CCleaner Smart Cleaning",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|CCleaner Monitor",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Spotify Web Helper",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Gaijin.Net Updater",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|com.squirrel.Teams.Teams",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Google Update",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|BitTorrent Bleep",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Skype",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|adobeAAMUpdater-1.0",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|AdobeAAMUpdater",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|iTunesHelper",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|UpdatePPShortCut",
    @"HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run|Live Update",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Live Update",
    @"HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run|Wondershare Helper Compact",
    @"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Wondershare Helper Compact",
    @"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run|Cisco AnyConnect Secure Mobility Agent for Windows",
    @"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Cisco AnyConnect Secure Mobility Agent for Windows",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Opera Browser Assistant",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Steam",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|EADM",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|EpicGamesLauncher",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|GogGalaxy",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Skype for Desktop",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Wargaming.net Game Center",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|ut",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Lync",
    @"HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components|Google Chrome",
    @"HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components|Microsoft Edge",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MicrosoftEdgeAutoLaunch_E9C49D8E9BDC4095F482C844743B9E82",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MicrosoftEdgeAutoLaunch_D3AB3F7FBB44621987441AECEC1156AD",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MicrosoftEdgeAutoLaunch_31CF12C7FD715D87B15C2DF57BBF8D3E",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MicrosoftEdgeAutoLaunch",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Microsoft Edge Update",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|MicrosoftEdgeAutoLaunch_31CF12C7FD715D87B15C2DF57BBF8D3E",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Discord",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|Ubisoft Game Launcher",
    @"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run|com.blitz.app",
    @"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SearchIndexer.exe",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|searchapp.exe",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|CoolWebSearch",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Crossrider",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|MediaNewTab",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Vosteran",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SweetIM",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SweetPacks",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|BabylonToolbar",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|ico8ca4.exe",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|ShopperPro",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|ASCTray",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|ASC",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SAntivirus",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Segurazo",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|WinZipDriverUpdater",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SlimDrivers",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|DriverMax",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SuperOptimizer",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|PCOptimizerPro",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|WebCompanion",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|Wajam",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|MyWebSearch",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|FunWebProducts",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|rk.exe",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|RelevantKnowledge",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|DriverBooster",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|SearchProtect",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|AnyDesk",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|TeamViewer",
@"HKCU\Software\Microsoft\Windows\CurrentVersion\Run|EdgeUI",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SearchIndexer.exe",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|searchapp.exe",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|CoolWebSearch",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Crossrider",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|MediaNewTab",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Vosteran",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SweetIM",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SweetPacks",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|BabylonToolbar",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|ico8ca4.exe",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|ShopperPro",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|ASCTray",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|ASC",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SAntivirus",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Segurazo",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|WinZipDriverUpdater",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SlimDrivers",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|DriverMax",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SuperOptimizer",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|PCOptimizerPro",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|WebCompanion",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|Wajam",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|MyWebSearch",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|FunWebProducts",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|rk.exe",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|RelevantKnowledge",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|DriverBooster",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|SearchProtect",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|AnyDesk",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|TeamViewer",
@"HKLM\Software\Microsoft\Windows\CurrentVersion\Run|EdgeUI",
@"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run|Discord"
};

                            foreach (var entry in keysToClean)
                            {
                                try
                                {
                                    string[] parts = entry.Split('|');
                                    string keyPath = parts[0];
                                    string valueName = parts[1];

                                    RegistryKey baseKey;
                                    string subKeyPath;

                                    if (keyPath.StartsWith("HKCU"))
                                    {
                                        baseKey = Registry.CurrentUser;
                                        subKeyPath = keyPath.Substring("HKCU\\".Length);
                                    }
                                    else if (keyPath.StartsWith("HKLM"))
                                    {
                                        baseKey = Registry.LocalMachine;
                                        subKeyPath = keyPath.Substring("HKLM\\".Length);
                                    }
                                    else
                                    {
                                        continue;
                                    }

                                    using (var keydel = baseKey.OpenSubKey(subKeyPath, writable: true))
                                    {
                                        keydel?.DeleteValue(valueName, throwOnMissingValue: false);
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"Error when deleting {entry}: {ex.Message}");
                                }
                            }

                            break;
                        case "Enable Long Paths":
                            done++;

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\", "LongPathsEnabled", 1, RegistryValueKind.DWord);
                            break;
                    }
                }
            }

            //Privacy Panel
            foreach (CheckBox checkBox in panel2.Controls)
            {
                progressBar1.Value = done;
                if (checkBox.Checked)
                {
                    checkBox.Checked = false;
                    string timelog = DateTime.Now.ToString("[HH:mm:ss] ");
                    textBox1.Text += timelog + checkBox.Text + Environment.NewLine;
                    textBox1.SelectionStart = textBox1.TextLength;
                    textBox1.ScrollToCaret();
                    string caseSwitch = checkBox.Tag as string;

                    switch (caseSwitch)
                    {
                        case "Disable Telemetry Scheduled Tasks":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\AppID\\SmartScreenSpecific\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\Microsoft Compatibility Appraiser\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\ProgramDataUpdater\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\StartupAppTask\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\Consolidator\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\KernelCeipTask\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\UsbCeip\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\DiskDiagnostic\\Microsoft-Windows-DiskDiagnosticDataCollector\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\MemoryDiagnostic\\ProcessMemoryDiagnosticEvent\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Power Efficiency Diagnostics\\AnalyzeSystem\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\Uploader\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Shell\\FamilySafetyUpload\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentLogOn\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentFallBack\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentFallBack2016\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentLogOn2016\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office 15 Subscription Heartbeat\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office 16 Subscription Heartbeat\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Windows Error Reporting\\QueueReporting\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\WindowsUpdate\\Automatic App Update\" /Disable && schtasks /Change /TN \"NIUpdateServiceStartupTask\" /Disable && schtasks /Change /TN \"CCleaner Update\" /Disable && schtasks /Change /TN \"CCleanerCrashReportings\" /Disable && schtasks /Change /TN \"CCleanerSkipUAC - $env:username\" /Disable && schtasks /Change /TN \"updater\" /Disable && schtasks /Change /TN \"Adobe Acrobat Update Task\" /Disable && schtasks /Change /TN \"MicrosoftEdgeUpdateTaskMachineCore\" /Disable && schtasks /Change /TN \"MicrosoftEdgeUpdateTaskMachineUA\" /Disable && schtasks /Change /TN \"MiniToolPartitionWizard\" /Disable && schtasks /Change /TN \"AMDLinkUpdate\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Automatic Updates 2.0\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Feature Updates\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Feature Updates Logon\" /Disable && schtasks /Change /TN \"GoogleUpdateTaskMachineCore\" /Disable && schtasks /Change /TN \"GoogleUpdateTaskMachineUA\" /Disable && schtasks /DELETE /TN \"AMDInstallLauncher\" /f && schtasks /DELETE /TN \"AMDLinkUpdate\" /f && schtasks /DELETE /TN \"AMDRyzenMasterSDKTask\" /f && schtasks /DELETE /TN \"DUpdaterTask\" /f && schtasks /DELETE /TN \"ModifyLinkUpdate\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Telemetry/Data Collection":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del /q %temp%\\NVIDIA Corporation\\NV_Cache\\* && del /q %programdata%\\NVIDIA Corporation\\NV_Cache\\*";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();


                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C sc stop VSStandardCollectorService150 && sc config VSStandardCollectorService150 start= disabled && taskkill /f /im ccleaner.exe && cmd /c taskkill /f /im ccleaner64.exe";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", @"(Cfg)SoftwareUpdaterIpm", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", @"(Cfg)SoftwareUpdater", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", @"(Cfg)QuickCleanIpm", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", @"(Cfg)QuickClean", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", @"(Cfg)HealthCheck", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "CheckTrialOffer", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "UpdateCheck", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "UpdateAuto", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "SystemMonitoring", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "HelpImproveCCleaner", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "Monitoring", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner\", "HomeScreen", 2, RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Google\Chrome\", "MetricsReportingEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Google\Chrome\", "ChromeCleanupReportingEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Google\Chrome\", "ChromeCleanupEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Google\Chrome\", "MetricsReportingEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\VisualStudio\Feedback\", "DisableScreenshotCapture", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\VisualStudio\Feedback\", "DisableEmailInput", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\VisualStudio\Feedback\", "DisableFeedbackDialog", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\VisualStudio\Telemetry\", "TurnOffSwitch", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\VSCommon\17.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\VSCommon\16.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\VSCommon\15.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\VSCommon\14.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Wow6432Node\Microsoft\VSCommon\17.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Wow6432Node\Microsoft\VSCommon\16.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Wow6432Node\Microsoft\VSCommon\15.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Wow6432Node\Microsoft\VSCommon\14.0\SQM\", "OptIn", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\17.0\Common\", "QMEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Common\", "QMEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\15.0\Common\", "QMEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Feedback\", "Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\15.0\Common\Feedback\", "Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Office\17.0\OSM\", "EnableUpload", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM\", "EnableUpload", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM\", "EnableUpload", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\OSM\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Office\15.0\OSM\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\17.0\Word\Options\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Word\Options\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\15.0\Word\Options\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Calendar\", "EnableCalendarLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Calendar\", "EnableCalendarLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\15.0\Outlook\Options\Mail\", "EnableLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry\", "VerboseLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry\", "VerboseLogging", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\17.0\Common\ClientTelemetry\", "DisableTelemetry", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry\", "DisableTelemetry", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\Common\ClientTelemetry\", "DisableTelemetry", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\DiagTrack\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\dmwappushservice\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener\", "Start", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy\", "TailoredExperiencesWithDiagnosticDataEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger\", "Start", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener\", "Start", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\", "AllowTelemetry", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\", "DisableUAR", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat\", "AITEnable", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows\", "CEIPEnable", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\MRT\", "DontOfferThroughWUAU", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows\DataCollection\", "AllowTelemetry", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection\", "AllowTelemetry", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata\", "PreventDeviceMetadataFromNetwork", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe\", "Debugger", @"%windir%\System32\taskkill.exe", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry\", "DeviceDumpEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0\", "NoActiveHelp", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer\", "HideRecentlyAddedApps", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter\", "EnabledV9", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\", "SmartScreenEnabled", @"Off", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\", "AllowDeviceNameInTelemetry", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\", "DoNotShowFeedbackNotifications", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports\", "PreventHandwritingErrorReports", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoInstrumentation", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client\", "OptInOrOutPreference", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS\", "EnableRID44231", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS\", "EnableRID64640", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS\", "EnableRID66610", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Services\NvTelemetryContainer\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\", "NoInstrumentation", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe", "Debugger", @"%windir%\System32\taskkill.exe", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\Software\Piriform\CCleaner", "Monitoring", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection", "AllowTelemetry", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Office\16.0\Common\ClientTelemetry", "DisableTelemetry", 1, RegistryValueKind.DWord);

                            break;
                        case "Disable PowerShell Telemetry":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C setx POWERSHELL_TELEMETRY_OPTOUT 1";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Skype Telemetry":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW\", "WPPFilePath", @"%SYSTEMDRIVE%\TEMP\WPPMedia\", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\", "WPPFilePath", @"%SYSTEMDRIVE%\TEMP\Tracing\WPPMedia\", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\SOFTWARE\\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW\", "EnableTracing", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\\Microsoft\Tracing\WPPMediaPerApp\Skype\", "EnableTracing", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Tracing\WPPMediaPerApp\Skype\ETW\", "TraceLevelThreshold", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Media Player Usage Reports":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences\", "UsageTracking", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Mozilla Telemetry":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Mozilla\Firefox", "DisableTelemetry", 2, RegistryValueKind.DWord);
                            break;
                        case "Disable Apps Use My Advertising ID":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics\", "Value", @"Deny", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics\", "Value", @"Deny", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\AdvertisingInfo\", "Value", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo\", "Enabled", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Send Info About Writing":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Input\TIPC\", "Enabled", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Handwriting Recognition":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\InputPersonalization\", "RestrictImplicitTextCollection", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\InputPersonalization\", "RestrictImplicitInkCollection", 1, RegistryValueKind.DWord);
                            break;
                        case "Disable Watson Malware Reports":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting\", "DisableGenericReports", 2, RegistryValueKind.DWord);
                            break;
                        case "Disable Malware Diagnostic Data":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\MRT\", "DontReportInfectionInformation", 2, RegistryValueKind.DWord);
                            break;
                        case "Disable Reporting to MS MAPS":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\\Microsoft\Windows Defender\Spynet\", "LocalSettingOverrideSpynetReporting", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Spynet Defender Reporting":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet\", "SpynetReporting", 0, RegistryValueKind.DWord);
                            break;
                        case "Do Not Send Malware Samples":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet\", "SubmitSamplesConsent", 2, RegistryValueKind.DWord);
                            break;
                        case "Disable Sending Typing Samples":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Personalization\Settings\", "AcceptedPrivacyPolicy", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Sending Contacts to MS":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore\", "HarvestContacts", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Cortana":
                            done++;

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\", "AllowCortana", 0, RegistryValueKind.DWord);
                            break;
                        case "Remove Copilot":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\Shell\Copilot\BingChat\", "IsUserEligible", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\", "AutoOpenCopilotLargeScreens", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows\WindowsCopilot\", "TurnOffWindowsCopilot", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "ShowCopilotButton", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows\WindowsCopilot\", "TurnOffWindowsCopilot", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Edge\", "HubsSidebarEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer\", "DisableSearchBoxSuggestions", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer\", "DisableSearchBoxSuggestions", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Policies\Microsoft\Windows\WindowsAI\", "DisableAIDataAnalysis", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows\WindowsAI\", "DisableAIDataAnalysis", 1, RegistryValueKind.DWord);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxPackage -AllUsers | Where-Object {$_.Name -Like '*Microsoft.Copilot*'} | Remove-AppxPackage -AllUsers -ErrorAction Continue";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Block telemetry and user experience hosts":
                            done++;
                            string[] domains1 = new[]
                            {
                "functional.events.data.microsoft.com",
                "browser.events.data.msn.com",
                "self.events.data.microsoft.com",
                "v10.events.data.microsoft.com",
                "v10c.events.data.microsoft.com",
                "us-v10c.events.data.microsoft.com",
                "eu-v10c.events.data.microsoft.com",
                "v10.vortex-win.data.microsoft.com",
                "vortex-win.data.microsoft.com",
                "telecommand.telemetry.microsoft.com",
                "www.telecommandsvc.microsoft.com",
                "umwatson.events.data.microsoft.com",
                "watsonc.events.data.microsoft.com",
                "eu-watsonc.events.data.microsoft.com"
            };

              EditHosts(domains1);
                            break;
                        case "Block location data sharing hosts":
                            done++;
                            string[] domains2 = new[]
                            {
                "inference.location.live.net",
                "location-inference-westus.cloudapp.nets"
            };

                            EditHosts(domains2);
                            break;
                        case "Block Windows crash report hosts":
                            done++;
                            string[] domains3 = new[]
                            {
                "oca.telemetry.microsoft.com",
                "oca.microsoft.com",
                "kmwatsonc.events.data.microsoft.com",
                "watson.telemetry.microsoft.com",
                "umwatsonc.events.data.microsoft.com",
                "ceuswatcab01.blob.core.windows.net",
                "ceuswatcab02.blob.core.windows.net",
                "eaus2watcab01.blob.core.windows.net",
                "eaus2watcab02.blob.core.windows.net",
                "weus2watcab01.blob.core.windows.net",
                "weus2watcab02.blob.core.windows.net",
                "co4.telecommand.telemetry.microsoft.com",
                "cs11.wpc.v0cdn.net",
                "cs1137.wpc.gammacdn.net",
                "modern.watson.data.microsoft.com"
            };

                            EditHosts(domains3);
                            break;

                    }
                }
            }

            //Visual Panel
            foreach (CheckBox checkBox in panel3.Controls)
            {
                progressBar1.Value = done;
                if (checkBox.Checked)
                {
                    checkBox.Checked = false;
                    string timelog = DateTime.Now.ToString("[HH:mm:ss] ");
                    textBox1.Text += timelog + checkBox.Text + Environment.NewLine;
                    textBox1.SelectionStart = textBox1.TextLength;
                    textBox1.ScrollToCaret();
                    string caseSwitch = checkBox.Tag as string;

                    switch (caseSwitch)
                    {
                        case "Show File Extensions in Explorer":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "HideFileExt", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Transparency on Taskbar":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\", "EnableTransparency", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\Themes\Personalize\", "EnableTransparency", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable Windows Animations":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimation\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ControlAnimations\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\ComboBoxAnimation\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\AnimateMinMax\", "DefaultApplied", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Control Panel\Desktop\WindowMetrics\", "MinAnimate", 0, RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\", "VisualFXSetting", 2, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Control Panel\Desktop\", "AnimationDuration", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Control Panel\Desktop\", "UserPreferencesMask", 9012038010000000, RegistryValueKind.Binary);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "TaskbarAnimations", 0, RegistryValueKind.DWord);
                            break;
                        case "Disable MRU lists (jump lists)":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "Start_TrackDocs", 0, RegistryValueKind.DWord);
                            break;
                        case "Set Search Box to Icon Only":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\", "SearchboxTaskbarMode", 1, RegistryValueKind.DWord);
                            break;
                        case "Explorer on Start on This PC":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "LaunchTo", 1, RegistryValueKind.DWord);
                            break;
                        case "Remove Learn about this photo":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\", "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}", 1, RegistryValueKind.DWord);
                            break;
                        case "Enable Old Context Menu":
                            done++;

                            SetRegistryValue(@"HKCU\SOFTWARE\CLASSES\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32\", @"", @"", RegistryValueKind.String);
                            break;
                        case "Disable Logon Background Image":
                            done++;

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows\System\", "DisableLogonBackgroundImage", 1, RegistryValueKind.DWord);
                            break;

                    }
                }
            }

            //Others Panel
            foreach (CheckBox checkBox in panel4.Controls)
            {
                progressBar1.Value = done;
                if (checkBox.Checked)
                {
                    checkBox.Checked = false;
                    string timelog = DateTime.Now.ToString("[HH:mm:ss] ");
                    textBox1.Text += timelog + checkBox.Text + Environment.NewLine;
                    textBox1.SelectionStart = textBox1.TextLength;
                    textBox1.ScrollToCaret();
                    string caseSwitch = checkBox.Tag as string;

                    switch (caseSwitch)
                    {
                        case "Split Threshold for Svchost":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb; Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control' -Name 'SvcHostSplitThresholdInKB' -Type DWord -Value $ram -Force ";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Windows Game Bar/DVR":
                            done++;

                            SetRegistryValue(@"HKCU\System\GameConfigStore\", "GameDVR_Enabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR\", "AppCaptureEnabled", 0, RegistryValueKind.DWord);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage; Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage; Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Clean Temp/Cache/Prefetch/Logs":
                            done++;

                            DeleteFilesInFolder(Environment.ExpandEnvironmentVariables("%temp%\\NVIDIA Corporation\\NV_Cache"));
                            DeleteFilesInFolder(Environment.ExpandEnvironmentVariables("%programdata%\\NVIDIA Corporation\\NV_Cache"));

                            DeleteFilesInFolder(Environment.ExpandEnvironmentVariables("%userprofile%\\Recent"));

                            DeleteFilesInFolder(Environment.ExpandEnvironmentVariables("%systemdrive%\\Windows\\SoftwareDistribution"));
                            DeleteFolder(Environment.ExpandEnvironmentVariables("%systemdrive%\\Windows\\SoftwareDistribution"));

                            string[] pathsToDelete = new string[]
                            {
            "%localappdata%\\Microsoft\\Windows\\WebCache",
            "%programdata%\\GOG.com\\Galaxy\\logs",
            "%programdata%\\GOG.com\\Galaxy\\webcache",
            "%appdata%\\Microsoft\\Teams\\Cache",
            "%localappdata%\\Yarn\\Cache",
            "%temp%\\VSTelem.Out",
            "%temp%\\VSTelem",
            "%temp%\\VSRemoteControl",
            "%temp%\\VSFeedbackVSRTCLogs",
            "%temp%\\VSFeedbackPerfWatsonData",
            "%temp%\\VSFaultInfo",
            "%temp%\\Microsoft\\VSApplicationInsights",
            "%ProgramData%\\Microsoft\\VSApplicationInsights",
            "%LocalAppData%\\Microsoft\\VSApplicationInsights",
            "%AppData%\\vstelemetry",
            "%windir%\\Prefetch",
            "%LocalAppData%\\IconCache.db",
            "%LocalAppData%\\Microsoft\\Windows\\Explorer",
            "%WinDir%\\System32\\catroot2",
            "%WinDir%\\DISM",
            "%WinDir%\\System32\\SleepStudy",
            "%WinDir%\\SysNative\\SleepStudy",
            "%WinDir%\\System32\\LogFiles\\HTTPERR",
            "%WinDir%\\Logs\\WindowsBackup",
            "%WinDir%\\Logs\\CBS",
            "%SystemDrive%\\PerfLogs\\System\\Diagnostics",
            "%WinDir%\\ServiceProfiles\\LocalService\\AppData\\Local\\FontCache",
            "%WinDir%\\debug\\WIA"
                            };

                            foreach (var path in pathsToDelete)
                            {
                                var fullPath = Environment.ExpandEnvironmentVariables(path);
                                if (File.Exists(fullPath))
                                    TryDeleteFile(fullPath);
                                else if (Directory.Exists(fullPath))
                                    DeleteFilesInFolder(fullPath);
                            }

                            StopService("FontCache3.0.0.0");
                            StopService("FontCache");

                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\ServiceProfiles\\LocalService\\AppData\\Local\\FontCache"), "*.dat");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\SysNative"), "FNTCACHE.DAT");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\System32"), "FNTCACHE.DAT");

                            StartService("FontCache");
                            StartService("FontCache3.0.0.0");

                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Panther\\UnattendGC"), "diagwrn.xml");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Panther\\UnattendGC"), "diagerr.xml");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\repair"), "setup.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Panther"), "DDACLSys.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Panther"), "cbs.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%LocalAppData%\\Microsoft\\Windows\\WebCache"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Logs"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\ServiceProfiles\\NetworkService\\AppData\\Local\\Temp"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Logs\\DPX"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\system32\\wbem\\Logs"), "*.lo_");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\system32\\wbem\\Logs"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\APPLOG"), "*.*");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%"), "*.log.txt");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Logs\\DISM"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%"), "setuplog.txt");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%"), "OEWABLog.txt");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%"), "*.bak");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Debug\\UserMode"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Debug\\UserMode"), "*.bak");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\Debug"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\security\\logs"), "*.log");
                            DeleteFilesByPattern(Environment.ExpandEnvironmentVariables("%WinDir%\\security\\logs"), "*.old");

                            Process.Start("cleanmgr.exe", "/sagerun:5");
                            break;
                        case "Remove News and Interests/Widgets":
                            done++;

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "TaskbarDa", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds\", "ShellFeedsTaskbarViewMode", 2, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds\", "EnableFeeds", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Dsh\", "AllowNewsAndInterests", 0, RegistryValueKind.DWord);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command winget uninstall \"windows web experience pack\" --accept-source-agreements";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxPackage -AllUsers | Where-Object {$_.Name -like \"*WebExperience*\"} | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxProvisionedPackage -online | Where-Object {$_.Name -like \"*WebExperience*\"}| Remove-AppxProvisionedPackage -online –Verbose";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command winget uninstall \"windows web experience pack\"";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Scan for Adware (AdwCleaner)":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command winget install --id=Malwarebytes.AdwCleaner --disable-interactivity --silent --accept-source-agreements --accept-package-agreements; adwcleaner.exe /eula /clean /noreboot";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            System.Threading.Thread.Sleep(2000);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command winget uninstall --id=Malwarebytes.AdwCleaner --disable-interactivity --silent";
                            process.StartInfo = startInfo;
                            process.Start();

                            break;
                        case "Clean WinSxS Folder":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                    }
                }
            }

            //Expert Panel
            foreach (CheckBox checkBox in panel5.Controls)
            {
                progressBar1.Value = done;
                if (checkBox.Checked)
                {
                    checkBox.Checked = false;
                    string timelog = DateTime.Now.ToString("[HH:mm:ss] ");
                    textBox1.Text += timelog + checkBox.Text + Environment.NewLine;
                    textBox1.SelectionStart = textBox1.TextLength;
                    textBox1.ScrollToCaret();
                    string caseSwitch = checkBox.Tag as string;

                    switch (caseSwitch)
                    {
                        case "Disable Windows Defender":
                            done++;

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\MsSecFlt\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\SecurityHealthService\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\Sense\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\WdBoot\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\WdFilter\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\WdNisDrv\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\WdNisSvc\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\WinDefend\", "Start", 4, RegistryValueKind.DWord);

                            Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Run", true)?.DeleteValue("SecurityHealth", false);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\SgrmAgent\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\SgrmBroker\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\webthreatdefsvc\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\ControlSet001\Services\webthreatdefusersvc\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\", "DisableAntiSpyware", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\", "DisableAntiVirus", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\", "DisableRealtimeMonitoring", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\", "DisableSpecialRunningModes", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\", "DisableRoutinelyTakingAction", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates\", "ForceUpdateFromMU", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet\", "DisableBlockAtFirstSeen", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray", "HideSystray", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components\", "ServiceEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components\", "NotifyMalicious", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components\", "NotifyPasswordReuse", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components\", "NotifyUnsafeApp", 0, RegistryValueKind.DWord);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C for /f %%i in ('reg query \"HKLM\\SYSTEM\\ControlSet001\\Services\" /s /k \"webthreatdefusersvc\" /f 2^>nul ^| find /i \"webthreatdefusersvc\" ') do (reg add \"%%i\" /v \"Start\" /t REG_DWORD /d \"4\" /f)\r\n";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\smartscreen.exe\", "Debugger", @"%windir%\System32\taskkill.exe", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations\", "DefaultFileTypeRisk", 6152, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments\", "SaveZoneInformation", 1, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations\", "LowRiskFileTypes", @".avi;.bat;.com;.cmd;.exe;.htm;.html;.lnk;.mpg;.mpeg;.mov;.mp3;.msi;.m3u;.rar;.reg;.txt;.vbs;.wav;.zip;", RegistryValueKind.String);

                            SetRegistryValue(@"HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations\", "ModRiskFileTypes", @".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\", "SmartScreenEnabled", @"Off", RegistryValueKind.String);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen\", "ConfigureAppInstallControlEnabled", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen\", "ConfigureAppInstallControl", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\Windows Defender\SmartScreen\", "EnableSmartScreen", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKCU\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter\", "EnabledV9", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter\", "EnabledV9", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger\", "Start", 0, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger\", "Start", 0, RegistryValueKind.DWord);

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\ExploitGuard\\ExploitGuard MDM policy Refresh\" /Disable";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Cache Maintenance\" /Disable";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Cleanup\" /Disable";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Scheduled Scan\" /Disable";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Verification\" /Disable";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run\", true)?.DeleteValue("SecurityHealth", false);

                            Registry.LocalMachine.OpenSubKey(@"SOFTWARE\Software\Microsoft\Windows\CurrentVersion\Run\", true)?.DeleteValue("SecurityHealth", false);

                            Registry.ClassesRoot.DeleteSubKeyTree(@"Directory\shellex\ContextMenuHandlers\EPP\", false);
                            Registry.ClassesRoot.DeleteSubKeyTree(@"Drive\shellex\ContextMenuHandlers\EPP\", false);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Services\WdFilter\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Services\WdNisDrv\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Services\WdNisSvc\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\System\CurrentControlSet\Services\WinDefend\", "Start", 4, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications\", "DisableEnhancedNotifications", 1, RegistryValueKind.DWord);
                            break;
                        case "Disable Spectre/Meltdown":
                            done++;

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\", "FeatureSettingsOverrideMask", 3, RegistryValueKind.DWord);

                            SetRegistryValue(@"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\", "FeatureSettingsOverride", 3, RegistryValueKind.DWord);
                            break;
                        case "Remove Microsoft OneDrive":
                            done++;

                            StopOneDriveKFM();

                            Process.Start("cmd.exe", "/c taskkill /F /IM OneDrive.exe /T");

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C IF EXIST %programdata%\\SysWOW64\\OneDriveSetup.exe start %programdata%\\SysWOW64\\OneDriveSetup.exe /uninstall";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C IF EXIST %programdata%\\System32\\OneDriveSetup.exe start %programdata%\\System32\\OneDriveSetup.exe /uninstall";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxPackage -allusers *Microsoft.OneDriveSync* | Remove-AppxPackage";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command winget uninstall onedrive";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Xbox Services":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C sc config XblAuthManager start= disabled && sc config XboxNetApiSvc start= disabled && sc config XblGameSave start= disabled";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Process Mitigation":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Set-ProcessMitigation -System -Disable CFG";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Enable Fast/Secure DNS (1.1.1.1)":
                            done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C ipconfig /flushdns && netsh interface ipv4 add dnsservers \"Ethernet\" address=1.1.1.1 index=1 && netsh interface ipv4 add dnsservers \"Ethernet\" address=8.8.8.8 index=2 && netsh interface ipv4 add dnsservers \"Wi-Fi\" address=1.1.1.1 index=1 && netsh interface ipv4 add dnsservers \"Wi-Fi\" address=8.8.8.8 index=2";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                    }
                }
            }

            if (alltodo == 0)
            {
                progressBar1.Visible = false;
                button5.Enabled = true;
                groupBox1.Visible = true;
                groupBox2.Visible = true;
                groupBox3.Visible = true;
                groupBox4.Visible = true;
                groupBox5.Visible = true;
                groupBox6.Visible = true;
                button1.Visible = true;
                button2.Visible = true;
                button3.Visible = true;
                button4.Visible = true;
                button5.Visible = true;
                pictureBox4.Visible = false;
                textBox1.Visible = false;
                Application.VisualStyleState = VisualStyleState.ClientAndNonClientAreasEnabled;
                MessageBox.Show(msgerror, ETVersion, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            else
            {
                if (alltodo == done)
                {
                    if (issillent == true)
                    {
                        SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation", "Manufacturer", @"ET-Optimizer", RegistryValueKind.String);
                        SetRegistryValue(@"HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation", "SupportURL", @"https://github.com/semazurek/ET-Optimizer", RegistryValueKind.String);
                        Environment.Exit(0);
                        this.Close();
                        String my_name_process = Process.GetCurrentProcess().ProcessName;
                        Process.Start("cmd.exe", "/c taskkill /F /IM " + my_name_process + ".exe /T");
                    }
                    string OSpath = Path.GetPathRoot(Environment.SystemDirectory);
                    if (File.Exists(OSpath + "Windows\\Media\\Windows Proximity Notification.wav"))
                    {
                        SoundPlayer my_wave_file = new SoundPlayer(OSpath + "Windows\\Media\\Windows Proximity Notification.wav");
                        my_wave_file.Play();
                    }

                    this.TopMost = true;

                    if (isswitch == true)
                    {
                        MessageBox.Show(msgend, ETVersion, MessageBoxButtons.OK, MessageBoxIcon.Information);
                        this.Close();
                    }
                    else
                    {
                        PopUpMSG(msgend);
                    }
                    c_p(null, null);
                    textBox1.Text = "";
                    button5.Enabled = true;
                    progressBar1.Visible = false;
                    groupBox1.Visible = true;
                    groupBox2.Visible = true;
                    groupBox3.Visible = true;
                    groupBox4.Visible = true;
                    groupBox5.Visible = true;
                    groupBox6.Visible = true;
                    button1.Visible = true;
                    button2.Visible = true;
                    button3.Visible = true;
                    button4.Visible = true;
                    button5.Visible = true;
                    pictureBox4.Visible = false;
                    textBox1.Visible = false;
                    this.TopMost = false;

                    Application.VisualStyleState = VisualStyleState.ClientAndNonClientAreasEnabled;
                }
            }
        }
        private void button5_Click(object sender, EventArgs e)
        {
            doengine();
        }

        private void toolStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void toolStripButton5_Click(object sender, EventArgs e)
        {

        }

        int perf = 0;
        private void button1_Click(object sender, EventArgs e)
        {
            perf++;
            if (perf % 2 == 0)
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel1.Controls)
                {
                    checkBox.Checked = true;
                }
            }
            else
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel1.Controls)
                {
                    checkBox.Checked = false;
                }
            }
        }

        int priva = 0;
        private void button3_Click(object sender, EventArgs e)
        {
            priva++;
            if (priva % 2 == 0)
            {
                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel2.Controls)
                {
                    checkBox.Checked = true;
                }
            }
            else
            {
                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel2.Controls)
                {
                    checkBox.Checked = false;
                }
            }
        }

        int visua = 0;
        private void button2_Click(object sender, EventArgs e)
        {
            visua++;
            if (visua % 2 == 0)
            {
                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel3.Controls)
                {
                    checkBox.Checked = true;
                }
            }
            else
            {
                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel3.Controls)
                {
                    checkBox.Checked = false;
                }
            }
        }

        int selecall = 1;
        private void button4_Click(object sender, EventArgs e)
        {
            this.Click += c_p;
            selecall++;
            if (selecall % 2 == 0)
            {
                visua++; priva++; perf++;
                button4.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button4.Text = selectall1;

                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                foreach (CheckBox checkBox in panel4.Controls)
                {
                    checkBox.Checked = true;
                }

                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel3.Controls)
                {
                    checkBox.Checked = true;
                }

                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel2.Controls)
                {
                    checkBox.Checked = true;
                }

                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel1.Controls)
                {
                    checkBox.Checked = true;
                }

            }
            else
            {
                button4.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                button4.Text = selectall0;

                groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel3.Controls)
                {
                    checkBox.Checked = false;
                }

                groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel2.Controls)
                {
                    checkBox.Checked = false;
                }

                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
                foreach (CheckBox checkBox in panel1.Controls)
                {
                    checkBox.Checked = false;
                }

                foreach (CheckBox checkBox in panel5.Controls)
                {
                    checkBox.Checked = false;
                }

                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                foreach (CheckBox checkBox in panel4.Controls)
                {
                    checkBox.Checked = false;
                }

            }


        }

        private void toolStripButton4_Click(object sender, EventArgs e)
        {

            Process.Start("https://www.buymeacoffee.com/semazurek");
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            string programDataPath = Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData);
            string fileName = "ET-lunched.txt";
            string fullPath = Path.Combine(programDataPath, fileName);
            if (File.Exists(fullPath))
            {
                File.Delete(fullPath);
            }
            Hide();
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            Console.WriteLine(Application.ExecutablePath);

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start " + Application.ExecutablePath;
            process.StartInfo = startInfo;
            process.Start();
            Close();
        }


        private void diskDefragmenterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msconfigPath = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "dfrgui.exe"
);

            if (!File.Exists(msconfigPath))
            {
                msconfigPath = Path.Combine(Environment.SystemDirectory, "dfrgui.exe");
            }
            Process.Start(new ProcessStartInfo
            {
                FileName = msconfigPath,
                UseShellExecute = true
            });
        }

        private void cleanmgrToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("cleanmgr.exe");
        }

        private void msconfigToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msconfigPath = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "msconfig.exe"
);

            if (!File.Exists(msconfigPath))
            {
                msconfigPath = Path.Combine(Environment.SystemDirectory, "msconfig.exe");
            }
            Process.Start(new ProcessStartInfo
            {
                FileName = msconfigPath,
                UseShellExecute = true
            });
        }

        private void controlPanelToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("control.exe");
        }

        private void deviceManagerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("devmgmt.msc");
        }

        private void uACSettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("UserAccountControlSettings.exe");
        }

        private void msinfo32ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("msinfo32");
        }

        private void servicesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("services.msc");
        }

        private void remoteDesktopToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("mstsc");
        }

        private void eventViewerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("eventvwr.msc");
        }

        private void resetNetworkToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C netsh winsock reset && netsh int ipv4 reset;netsh int ipv6 reset && ipconfig /release;ipconfig /renew && ipconfig /flushdns";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void updateApplicationsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C Winget upgrade --all";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void rebootToBIOSToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start("shutdown", "/r /fw /t 1");
        }

        private void windowsLicenseKeyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var searcher = new ManagementObjectSearcher("SELECT OA3xOriginalProductKey FROM SoftwareLicensingService");
            foreach (var obj in searcher.Get())
            {
                string productKeycopy = obj["OA3xOriginalProductKey"]?.ToString();
                if (!string.IsNullOrEmpty(productKeycopy))
                {
                    Clipboard.SetText(productKeycopy);
                }
                MessageBox.Show(" " + obj["OA3xOriginalProductKey"], "Windows Product Key", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            Process.Start("https://semazurek.github.io");
        }

        public static string GetUsedRAM()
        {
            try
            {
                PerformanceCounter RAMCounter;
                RAMCounter = new PerformanceCounter();
                RAMCounter.CategoryName = "Memory";
                RAMCounter.CounterName = "% Committed Bytes In Use";
                return String.Format("{0:0.00}", RAMCounter.NextValue());
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving RAM usage: " + ex.Message);
                return "0.00";
            }
        }

        public static string GetUsedCPU()
        {
            try
            {
                PerformanceCounter CPUCounter;
                CPUCounter = new PerformanceCounter();
                CPUCounter.CategoryName = "Processor";
                CPUCounter.CounterName = "% Processor Time";
                CPUCounter.InstanceName = "_Total";
                CPUCounter.NextValue();
                System.Threading.Thread.Sleep(1000);
                return String.Format("{0:0.00}", CPUCounter.NextValue());
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving CPU usage: " + ex.Message);
                return "0.00";
            }
        }

        private async void timer1_Tick(object sender, EventArgs e)
        {
            string cpu = await Task.Run(() => GetUsedCPU());
            if (!IsDisposed) this.Invoke(new MethodInvoker(() =>
            {
                toolStripLabel1.Text = "CPU " + cpu + "% ";
                toolStripLabel1.Image = Properties.Resources.cpu_tower;
            }));

            string ram = await Task.Run(() => GetUsedRAM());
            if (float.TryParse(ram, out float flRAM) && !IsDisposed)
            {
                this.Invoke(new MethodInvoker(() =>
                {
                    toolStripLabel2.Image = Properties.Resources.ram;
                    toolStripLabel2.Text = "RAM " + (int)flRAM + "% ";
                    toolStripLabel2.ForeColor = (int)flRAM >= 80 ? Color.Red : default;
                }));
            }

            await Task.Run(() =>
            {
                try
                {
                    PowerStatus pwr = SystemInformation.PowerStatus;
                    float percent = pwr.BatteryLifePercent * 100;

                    this.Invoke(new MethodInvoker(() =>
                    {
                        toolStripLabel3.Image = Properties.Resources.battery_charge;
                        toolStripLabel3.Text = percent.ToString("0") + "%";
                        toolStripLabel3.ForeColor = percent <= 25 ? Color.Red : default;
                    }));
                }
                catch (Exception ex)
                {
                    this.Invoke(new MethodInvoker(() =>
                    {
                        toolStripLabel3.Image = Properties.Resources.battery_charge;
                        toolStripLabel3.Text = "0%";
                    }));
                    Console.WriteLine("Error retrieving battery status: " + ex.Message);
                }
            });

            toolStripLabel2.Visible = true;
            toolStripLabel3.Visible = true;

        }


        private void panelmain_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void panelmain_MouseUp(object sender, MouseEventArgs e)
        {

        }

        private void label1_MouseMove_1(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void toolStrip1_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void rebootToSafeModeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            string msconfigPath = Path.Combine(
    Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
    "bcdedit.exe"
);

            if (!File.Exists(msconfigPath))
            {
                msconfigPath = Path.Combine(Environment.SystemDirectory, "bcdedit.exe");
            }
            Process.Start(new ProcessStartInfo
            {
                Arguments = "/set {current} safeboot network",
                FileName = msconfigPath,
                UseShellExecute = true
            });
            RegistryKey reg = Registry.CurrentUser.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\RunOnce", true);
            reg.SetValue("ET-Optimizer", Application.ExecutablePath.ToString());

            Process.Start("shutdown", "/r /t 5");
            this.Close();
        }

        private void restartExplorerexeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Process.Start(new ProcessStartInfo
            {
                FileName = "taskkill",
                Arguments = "/f /im explorer.exe",
                Verb = "runas",
                WindowStyle = ProcessWindowStyle.Hidden,
                CreateNoWindow = true
            })?.WaitForExit();

            System.Threading.Thread.Sleep(1000); // odczekaj na zamknięcie

            Process.Start(new ProcessStartInfo
            {
                FileName = "explorer.exe",
                CreateNoWindow = true
            })?.WaitForExit();
        }



        private void downloadSoftwareToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void mSIAfterburnerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Guru3D.Afterburner --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void vLCMediaPlayerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=VideoLAN.VLC --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void microsoftVisualCRedistributableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=abbodi1406.vcredist --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void notepadToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Notepad++.Notepad++ --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void javaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Oracle.JavaRuntimeEnvironment --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void zipToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=7zip.7zip --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void mozillaFirefoxToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Mozilla.Firefox --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void braveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Brave.Brave --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void googleChromeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=Google.Chrome --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        public void button7_Click(object sender, EventArgs e)
        {
            if (engforced == true)
            {
                Hide();

                Process.Start(Application.ExecutablePath, "");
                Close();
            }
            else
            {
                Hide();

                Process.Start(Application.ExecutablePath, "/english");
                Close();
            }

        }

        public string isoPath;
        public string scriptPath = @"Copy_To_ISO\Make-ISO.ps1";
        private void makeETISOToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show(isoinfo, ETVersion, MessageBoxButtons.OK, MessageBoxIcon.Information);

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            if (!Directory.Exists("Copy_To_ISO"))
            {
                Directory.CreateDirectory("Copy_To_ISO");
            }

            string exeDir = AppDomain.CurrentDomain.BaseDirectory;

            string FileNameToSave = "autounattend.xml";

            string outputPath = Path.Combine(exeDir + "Copy_To_ISO/", FileNameToSave);

            string ContentToGet = Properties.Resources.autounattend;

            File.WriteAllText(outputPath, ContentToGet);


            string exePath = Assembly.GetExecutingAssembly().Location;

            string exeDirectory = AppDomain.CurrentDomain.BaseDirectory;

            string targetDir = Path.Combine(exeDirectory, "Copy_To_ISO");
            string targetPath = Path.Combine(targetDir, "ET.exe");

            File.Copy(exePath, targetPath, overwrite: true);

            FileNameToSave = "HowTo-ISO.png";

            outputPath = Path.Combine(exeDir + "Copy_To_ISO/", FileNameToSave);

            Image img = Properties.Resources.HowTo_ISO;
            img.Save(outputPath, ImageFormat.Png);

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "powershell.exe";
            startInfo.Arguments = "-Command explorer.exe \"Copy_To_ISO\"";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();
        }

        private void uniGetUIWingetGUIToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=MartiCliment.UniGetUI --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void restorePointToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string msconfigPath = Path.Combine(
Environment.ExpandEnvironmentVariables("%windir%\\Sysnative"),
"rstrui.exe"
);

            if (!File.Exists(msconfigPath))
            {
                msconfigPath = Path.Combine(Environment.SystemDirectory, "rstrui.exe");
            }
            Process.Start(new ProcessStartInfo
            {
                FileName = msconfigPath,
                UseShellExecute = true
            });
        }

        private void registryRestoreToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            string backupPath = System.IO.Path.Combine(systemDrive + @"\", "Backup");
            if (Directory.Exists(backupPath))
            {
                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
                startInfo.FileName = "powershell.exe";
                startInfo.Arguments = "-Command Get-ChildItem -Path \"$env:SystemDrive\\backup\" -Filter *.reg | ForEach-Object { reg import $_.FullName }";
                process.StartInfo = startInfo;
                process.Start();
            }
            else
            {
                MessageBox.Show(msgerror, ETVersion, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void panel1_Scroll(object sender, ScrollEventArgs e)
        {

        }

        private void privacySexyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C winget install --id=undergroundwires.privacy.sexy --disable-interactivity --silent --accept-source-agreements --accept-package-agreements";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void chrisTitusTechsWinToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "powershell.exe";
            startInfo.Arguments = "-Command irm \"https://christitus.com/win\" | iex";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F12)
            {
                Process.Start("https://github.com/semazurek/ET-Optimizer/blob/master/ET/Form1.cs");
            }
        }

        private void toolStripLabel3_DoubleClick(object sender, EventArgs e)
        {

        }

    }
}
