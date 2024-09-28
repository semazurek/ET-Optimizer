using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Diagnostics;
using System.Windows.Forms;
using System.IO;
using System.Security.Cryptography.X509Certificates;
using System.Runtime.InteropServices;
using System.Drawing.Drawing2D;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Windows.Forms.VisualStyles;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TaskbarClock;
using System.Globalization;
using System.Security.Policy;
using System.Management;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Window;
using Microsoft.Win32;

// Created by Rikey
// https://github.com/semazurek/ET-Optimizer
// https://www.paypal.com/paypalme/rikey

namespace ET
{
    public partial class Form1 : Form
    {
        // Import the necessary functions from the Windows API
        [DllImport("user32.dll")]
        public static extern bool ReleaseCapture();

        [DllImport("user32.dll")]
        public static extern int SendMessage(IntPtr hWnd, int Msg, int wParam, int lParam);

        public const int WM_NCLBUTTONDOWN = 0xA1;
        public const int HTCAPTION = 0x2;

        // Import the necessary function from the gdi32.dll library for rounded corners
        [DllImport("gdi32.dll", EntryPoint = "CreateRoundRectRgn")]
        private static extern IntPtr CreateRoundRectRgn(
            int nLeftRect,      // x-coordinate of the upper-left corner
            int nTopRect,       // y-coordinate of the upper-left corner
            int nRightRect,     // x-coordinate of the lower-right corner
            int nBottomRect,    // y-coordinate of the lower-right corner
            int nWidthEllipse,  // width of the ellipse used for corners
            int nHeightEllipse  // height of the ellipse used for corners
        );

        public class MySR : ToolStripSystemRenderer
        {
            public MySR() { }

            protected override void OnRenderToolStripBorder(ToolStripRenderEventArgs e)
            {
                //base.OnRenderToolStripBorder(e);
            }
        }

        string mainforecolor = "#eeeeee";
        string mainbackcolor = "#252525";
        string menubackcolor = "#323232";
        string selectioncolor = "#3498db";
        string selectioncolor2 = "#246c9d";
        string unselectionc = "#ecf0f1";
        string expercolor = "#e74c3c";

        string ETVersion = "E.T. ver 5.4";

        public string selectall0 = "Select All";
        public string selectall1 = "Unselect All";

        public string msgend = "Everything has been done. Reboot is recommended.";
        public string msgerror = "No option selected.";

        //Function c_p to count and mark by color that groupbox of function are fully (all) marked
        public void c_p(object sender, EventArgs e)
        {
            int ct = 0;
            foreach (CheckBox checkBox in panel1.Controls)
            {
                
                if (checkBox.Checked == true) { ct++; }
            }
            if (ct == 34) 
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            else
            {
                groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.BackColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
                button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainbackcolor);
            }

            int cy = 0;
            foreach (CheckBox checkBox in panel2.Controls)
            {

                if (checkBox.Checked == true) { cy++; }
            }
            if (cy == 17)
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

            int cu = 0;
            foreach (CheckBox checkBox in panel3.Controls)
            {

                if (checkBox.Checked == true) { cu++; }
            }
            if (cu == 6)
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

            int ci = 0;
            foreach (CheckBox checkBox in panel4.Controls)
            {

                if (checkBox.Checked == true) { ci++; }
            }
            if (ci == 6)
            {
                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            }
            else
            {
                groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            }
            int allc = ci + cu + cy + ct;
            
            if (allc == 63) 
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

        public Form1(string[] args)
        {

            InitializeComponent();
            button6.Location = new System.Drawing.Point(845, 5);
            button6.FlatAppearance.BorderSize = 0;
            this.MouseDown += new MouseEventHandler(Form1_MouseDown);
            this.MouseDown += new MouseEventHandler(ToolStrip1_MouseDown);
            this.MouseDown += new MouseEventHandler(panelmain_MouseDown);
            this.MouseDown += new MouseEventHandler(label1_MouseDown);

            this.Load += new EventHandler(Form1_Load);

            toolStrip1.Renderer = new MySR();
            this.Size = new System.Drawing.Size(880, 500);
            this.StartPosition = FormStartPosition.CenterScreen;
            //this.FormBorderStyle = FormBorderStyle.FixedDialog;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "powershell.exe";
            startInfo.Arguments = "-Command $ProcessorType=Get-WMIObject win32_Processor | select Name | findstr /c:AMD /c:Intel; $ProcessorType = $ProcessorType.Replace('(R)','').Replace('(TM)','') > CPUL.txt";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();
            

            string CPUL = File.ReadAllText("CPUL.txt");
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C del /f /q CPUL.txt";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();

            this.Text = ETVersion+"   -   " +CPUL;
            label1.Text = ETVersion+"   -   " + CPUL;
            this.AutoSizeMode = AutoSizeMode.GrowAndShrink;
            this.MinimizeBox = false;
            this.MaximizeBox = false;
            button5.Location = new System.Drawing.Point(660, 440);
            button5.Size = new System.Drawing.Size(120, 50);
            button5.FlatAppearance.BorderSize = 0;
            button4.Location = new System.Drawing.Point(510, 440);
            button4.Size = new System.Drawing.Size(140, 50);
            button4.FlatAppearance.BorderSize = 0;
            button3.Location = new System.Drawing.Point(380, 440);
            button3.Size = new System.Drawing.Size(120, 50);
            button3.FlatAppearance.BorderSize = 0;
            button2.Location = new System.Drawing.Point(250, 440);
            button2.Size = new System.Drawing.Size(120, 50);
            button2.FlatAppearance.BorderSize = 0;
            button1.Location = new System.Drawing.Point(110, 440);
            button1.Size = new System.Drawing.Size(130, 50);
            button1.FlatAppearance.BorderSize = 0;
            groupBox1.Location = new System.Drawing.Point(10, 70);
            groupBox1.Size = new System.Drawing.Size(570, 180);
            groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox2.Location = new System.Drawing.Point(585, 70);
            groupBox2.Size = new System.Drawing.Size(285, 180);
            groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox3.Location = new System.Drawing.Point(10, 250);
            groupBox3.Size = new System.Drawing.Size(285, 180);
            groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox4.Location = new System.Drawing.Point(302, 250);
            groupBox4.Size = new System.Drawing.Size(278, 180);
            groupBox4.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            groupBox5.Location = new System.Drawing.Point(585, 250);
            groupBox5.Size = new System.Drawing.Size(285, 180);
            groupBox5.ForeColor = System.Drawing.ColorTranslator.FromHtml(expercolor);
            toolStrip1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            toolStrip1.BackColor = System.Drawing.ColorTranslator.FromHtml(menubackcolor);
            toolStrip1.Size = new System.Drawing.Size(802, 25);
            textBox1.Location = new System.Drawing.Point(10, 70);
            textBox1.Size = new System.Drawing.Size(860,360);
            toolStripButton5.Visible = false;

            //Language change function
            CultureInfo cinfo = CultureInfo.InstalledUICulture;

            if (cinfo.Name == "pl-PL")
            {
                Console.WriteLine("Wykryto Polski");
                groupBox1.Text = "Poprawki Wydajności (34)";
                groupBox2.Text = "Prywatność (17)";
                groupBox3.Text = "Poprawki Wizualne (6)";
                groupBox4.Text = "Inne (6)";
                groupBox5.Text = "Tryb Eksperta (5)";

                button1.Text = "Wydajność";
                button2.Text = "Wizualne";
                button3.Text = "Prywatność";
                selectall0 = "Zaznacz Wszystko";
                selectall1 = "Odznacz Wszystko";

                button4.Text = "Zaznacz Wszystko";
                button4.Font = new Font("Consolas", 12, FontStyle.Regular);

                toolStripButton2.Text = "Kopia Zapasowa";
                toolStripButton1.Text = "Przywracanie";
                toolStripButton3.Text = "O mnie";
                toolStripButton4.Text = "Wsparcie";
                //toolStripButton5.Text = "Tryb Awaryjny";
                rebootToSafeModeToolStripMenuItem.Text = "Uruchom w Trybie Awaryjnym";
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

                msgend = "Zakończono. Zalecane jest ponowne uruchomienie.";
                msgerror = "Nie wybrano żadnej opcji.";

                toolStripLabel1.Text = "Wersja: Publiczna | 28.09.2024";
            } 

            if (cinfo.Name == "ru-RU" || cinfo.Name == "be-BY")
            {
                Console.WriteLine("Russian detected");
                groupBox1.Text = "Настройки производительности (34)";
                groupBox2.Text = "Конфиденциальность (17)";
                groupBox3.Text = "Визуальные настройки (6)";
                groupBox4.Text = "Другие (6)";
                groupBox5.Text = "Экспертный режим (5)";

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
                toolStripButton1.Text = "Восстановление";
                toolStripButton3.Text = "О программе";
                toolStripButton4.Text = "Пожертвовать";
                //toolStripButton5.Text = "безопасный режим";
                rebootToSafeModeToolStripMenuItem.Text = "Загрузитесь в безопасном режиме";
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

                msgend = "Завершено. Рекомендуется перезапуск.";
                msgerror = "Ни один вариант не был выбран.";

                toolStripLabel1.Text = "Build: Public | 28.09.2024";
            }

            panel1.VerticalScroll.Enabled = false;
            panel1.VerticalScroll.Visible = false;
            
            panel2.VerticalScroll.Enabled = false;
            panel2.VerticalScroll.Visible = false;

            panel3.VerticalScroll.Enabled = false;
            panel3.VerticalScroll.Visible = false;

            panel4.VerticalScroll.Enabled = false;
            panel4.VerticalScroll.Visible = false;

            panel5.VerticalScroll.Enabled = false;
            panel5.VerticalScroll.Visible = false;
            CheckBox chck1 = new CheckBox();
            chck1.Location = new System.Drawing.Point(10, 5);
            chck1.Size = new System.Drawing.Size(270, 25);
            chck1.Text = "Disable Edge WebWidget";
            chck1.TabIndex = 1;
            chck1.Checked = true;
            chck1.Click += c_p;
            panel1.Controls.Add(chck1);
            CheckBox chck2 = new CheckBox();
            chck2.Location = new System.Drawing.Point(10, 30);
            chck2.Size = new System.Drawing.Size(275, 25);
            chck2.Text = "Power Option to Ultimate Perform.";
            chck2.Checked = true;
            chck2.Click += c_p;
            chck2.TabIndex = 2;
            panel1.Controls.Add(chck2);
            CheckBox chck3 = new CheckBox();
            chck3.Location = new System.Drawing.Point(10, 55);
            chck3.Size = new System.Drawing.Size(250, 25);
            chck3.Text = "Split Threshold for Svchost";
            chck3.Checked = true;
            chck3.Click += c_p;
            chck3.TabIndex = 3;
            panel4.Controls.Add(chck3);
            CheckBox chck4 = new CheckBox();
            chck4.Location = new System.Drawing.Point(10, 55);
            chck4.Size = new System.Drawing.Size(270, 25);
            chck4.Text = "Dual Boot Timeout 3sec";
            chck4.Checked = true;
            chck4.Click += c_p;
            chck4.TabIndex = 4;
            panel1.Controls.Add(chck4);
            CheckBox chck5 = new CheckBox();
            chck5.Location = new System.Drawing.Point(10, 80);
            chck5.Size = new System.Drawing.Size(270, 25);
            chck5.Text = "Disable Hibernation/Fast Startup";
            chck5.Checked = true;
            chck5.Click += c_p;
            chck5.TabIndex = 5;
            panel1.Controls.Add(chck5);
            CheckBox chck6 = new CheckBox();
            chck6.Location = new System.Drawing.Point(10, 105);
            chck6.Size = new System.Drawing.Size(275, 25);
            chck6.Text = "Disable Windows Insider Experiments";
            chck6.Checked = true;
            chck6.Click += c_p;
            chck6.TabIndex = 6;
            panel1.Controls.Add(chck6);
            CheckBox chck7 = new CheckBox();
            chck7.Location = new System.Drawing.Point(10, 130);
            chck7.Size = new System.Drawing.Size(275, 25);
            chck7.Text = "Disable App Launch Tracking";
            chck7.Checked = true;
            chck7.Click += c_p;
            chck7.TabIndex = 7;
            panel1.Controls.Add(chck7);
            CheckBox chck8 = new CheckBox();
            chck8.Location = new System.Drawing.Point(10, 155);
            chck8.Size = new System.Drawing.Size(275, 25);
            chck8.Text = "Disable Powerthrottling (Intel 6gen+)";
            chck8.Checked = true;
            chck8.Click += c_p;
            chck8.TabIndex = 8;
            panel1.Controls.Add(chck8);
            CheckBox chck9 = new CheckBox();
            chck9.Location = new System.Drawing.Point(10, 180);
            chck9.Size = new System.Drawing.Size(275, 25);
            chck9.Text = "Turn Off Background Apps";
            chck9.Checked = true;
            chck9.Click += c_p;
            chck9.TabIndex = 9;
            panel1.Controls.Add(chck9);
            CheckBox chck10 = new CheckBox();
            chck10.Location = new System.Drawing.Point(10, 205);
            chck10.Size = new System.Drawing.Size(275, 25);
            chck10.Text = "Disable Sticky Keys Prompt";
            chck10.Checked = true;
            chck10.Click += c_p;
            chck10.TabIndex = 10;
            panel1.Controls.Add(chck10);
            CheckBox chck11 = new CheckBox();
            chck11.Location = new System.Drawing.Point(10, 230);
            chck11.Size = new System.Drawing.Size(275, 25);
            chck11.Text = "Disable Activity History";
            chck11.Checked = true;
            chck11.Click += c_p;
            chck11.TabIndex = 11;
            panel1.Controls.Add(chck11);
            CheckBox chck12 = new CheckBox();
            chck12.Location = new System.Drawing.Point(10, 255);
            chck12.Size = new System.Drawing.Size(275, 25);
            chck12.Text = "Disable Updates for MS Store Apps";
            chck12.Checked = true;
            chck12.Click += c_p;
            chck12.TabIndex = 12;
            panel1.Controls.Add(chck12);
            CheckBox chck13 = new CheckBox();
            chck13.Location = new System.Drawing.Point(10, 280);
            chck13.Size = new System.Drawing.Size(275, 25);
            chck13.Text = "SmartScreen Filter for Apps Disable";
            chck13.Checked = true;
            chck13.Click += c_p;
            chck13.TabIndex = 13;
            panel1.Controls.Add(chck13);
            CheckBox chck14 = new CheckBox();
            chck14.Location = new System.Drawing.Point(10, 305);
            chck14.Size = new System.Drawing.Size(270, 25);
            chck14.Text = "Let Websites Provide Locally";
            chck14.Checked = true;
            chck14.Click += c_p;
            chck14.TabIndex = 14;
            panel1.Controls.Add(chck14);
            CheckBox chck15 = new CheckBox();
            chck15.Location = new System.Drawing.Point(10, 330);
            chck15.Size = new System.Drawing.Size(270, 25);
            chck15.Text = "Fix Microsoft Edge Settings";
            chck15.Checked = true;
            chck15.Click += c_p;
            chck15.TabIndex = 15;
            panel1.Controls.Add(chck15);
            CheckBox chck64 = new CheckBox();
            chck64.Location = new System.Drawing.Point(10, 355);
            chck64.Size = new System.Drawing.Size(275, 25);
            chck64.Text = "Disable Nagle's Alg. (Delayed ACKs)";
            chck64.Checked = true;
            chck64.Click += c_p;
            chck64.TabIndex = 64;
            panel1.Controls.Add(chck64);
            CheckBox chck65 = new CheckBox();
            chck65.Location = new System.Drawing.Point(10, 380);
            chck65.Size = new System.Drawing.Size(275, 25);
            chck65.Text = "CPU Priority Tweaks";
            chck65.Checked = true;
            chck65.Click += c_p;
            chck65.TabIndex = 65;
            panel1.Controls.Add(chck65);
            CheckBox chck16 = new CheckBox();
            chck16.Location = new System.Drawing.Point(285, 05);
            chck16.Size = new System.Drawing.Size(260, 25);
            chck16.Text = "Disable Location Sensors";
            chck16.Checked = true;
            chck16.Click += c_p;
            chck16.TabIndex = 16;
            panel1.Controls.Add(chck16);
            CheckBox chck17 = new CheckBox();
            chck17.Location = new System.Drawing.Point(285, 30);
            chck17.Size = new System.Drawing.Size(260, 25);
            chck17.Text = "Disable WiFi HotSpot Auto-Sharing";
            chck17.Checked = true;
            chck17.Click += c_p;
            chck17.TabIndex = 17;
            panel1.Controls.Add(chck17);
            CheckBox chck18 = new CheckBox();
            chck18.Location = new System.Drawing.Point(285, 55);
            chck18.Size = new System.Drawing.Size(260, 25);
            chck18.Text = "Disable Shared HotSpot Connect";
            chck18.Checked = true;
            chck18.Click += c_p;
            chck18.TabIndex = 18;
            panel1.Controls.Add(chck18);
            CheckBox chck19 = new CheckBox();
            chck19.Location = new System.Drawing.Point(285, 80);
            chck19.Size = new System.Drawing.Size(260, 25);
            chck19.Text = "Updates Notify to Sched. Restart";
            chck19.Checked = true;
            chck19.Click += c_p;
            chck19.TabIndex = 19;
            panel1.Controls.Add(chck19);
            CheckBox chck20 = new CheckBox();
            chck20.Location = new System.Drawing.Point(285, 105);
            chck20.Size = new System.Drawing.Size(260, 25);
            chck20.Text = "P2P Update Setting to LAN (local)";
            chck20.Checked = true;
            chck20.Click += c_p;
            chck20.TabIndex = 20;
            panel1.Controls.Add(chck20);
            CheckBox chck21 = new CheckBox();
            chck21.Location = new System.Drawing.Point(285, 130);
            chck21.Size = new System.Drawing.Size(260, 25);
            chck21.Text = "Set Lower Shutdown Time (2sec)";
            chck21.Checked = true;
            chck21.Click += c_p;
            chck21.TabIndex = 21;
            panel1.Controls.Add(chck21);
            CheckBox chck22 = new CheckBox();
            chck22.Location = new System.Drawing.Point(285, 155);
            chck22.Size = new System.Drawing.Size(260, 25);
            chck22.Text = "Remove Old Device Drivers";
            chck22.Checked = true;
            chck22.Click += c_p;
            chck22.TabIndex = 22;
            panel1.Controls.Add(chck22);
            CheckBox chck23 = new CheckBox();
            chck23.Location = new System.Drawing.Point(285, 180);
            chck23.Size = new System.Drawing.Size(260, 25);
            chck23.Text = "Disable Get Even More Out of...";
            chck23.Checked = true;
            chck23.Click += c_p;
            chck23.TabIndex = 23;
            panel1.Controls.Add(chck23);
            CheckBox chck24 = new CheckBox();
            chck24.Location = new System.Drawing.Point(285, 205);
            chck24.Size = new System.Drawing.Size(260, 25);
            chck24.Text = "Disable Installing Suggested Apps";
            chck24.Checked = true;
            chck24.Click += c_p;
            chck24.TabIndex = 24;
            panel1.Controls.Add(chck24);
            CheckBox chck25 = new CheckBox();
            chck25.Location = new System.Drawing.Point(285, 230);
            chck25.Size = new System.Drawing.Size(260, 25);
            chck25.Text = "Disable Start Menu Ads/Suggestions";
            chck25.Checked = true;
            chck25.Click += c_p;
            chck25.TabIndex = 25;
            panel1.Controls.Add(chck25);
            CheckBox chck26 = new CheckBox();
            chck26.Location = new System.Drawing.Point(285, 255);
            chck26.Size = new System.Drawing.Size(260, 25);
            chck26.Text = "Disable Suggest Apps WindowsInk";
            chck26.Checked = true;
            chck26.Click += c_p;
            chck26.TabIndex = 26;
            panel1.Controls.Add(chck26);
            CheckBox chck27 = new CheckBox();
            chck27.Location = new System.Drawing.Point(285, 280);
            chck27.Size = new System.Drawing.Size(260, 25);
            chck27.Text = "Disable Unnecessary Components";
            chck27.Checked = true;
            chck27.Click += c_p;
            chck27.TabIndex = 27;
            panel1.Controls.Add(chck27);
            CheckBox chck28 = new CheckBox();
            chck28.Location = new System.Drawing.Point(285, 305);
            chck28.Size = new System.Drawing.Size(260, 25);
            chck28.Text = "Defender Scheduled Scan Nerf";
            chck28.Checked = true;
            chck28.Click += c_p;
            chck28.TabIndex = 28;
            panel1.Controls.Add(chck28);
            CheckBox chck29 = new CheckBox();
            chck29.Location = new System.Drawing.Point(285, 330);
            chck29.Size = new System.Drawing.Size(260, 25);
            chck29.Text = "Disable Process Mitigation";
            chck29.Checked = true;
            chck29.Click += c_p;
            chck29.TabIndex = 29;
            panel1.Controls.Add(chck29);
            CheckBox chck30 = new CheckBox();
            chck30.Location = new System.Drawing.Point(285, 355);
            chck30.Size = new System.Drawing.Size(260, 25);
            chck30.Text = "Defragment Indexing Service File";
            chck30.Checked = true;
            chck30.Click += c_p;
            chck30.TabIndex = 30;
            panel1.Controls.Add(chck30);
            CheckBox chck66 = new CheckBox();
            chck66.Location = new System.Drawing.Point(10, 80);
            chck66.Size = new System.Drawing.Size(260, 25);
            chck66.Text = "Disable Spectre/Meltdown";
            chck66.Click += c_p;
            chck66.TabIndex = 66;
            panel5.Controls.Add(chck66);
            CheckBox chck67 = new CheckBox();
            chck67.Location = new System.Drawing.Point(10, 105);
            chck67.Size = new System.Drawing.Size(260, 25);
            chck67.Text = "Disable Windows Defender";
            chck67.Click += c_p;
            chck67.TabIndex = 67;
            panel5.Controls.Add(chck67);
            CheckBox chck31 = new CheckBox();
            chck31.Location = new System.Drawing.Point(10, 05);
            chck31.Size = new System.Drawing.Size(270, 25);
            chck31.Text = "Disable Telemetry Scheduled Tasks";
            chck31.Checked = true;
            chck31.Click += c_p;
            chck31.TabIndex = 31;
            panel2.Controls.Add(chck31);
            CheckBox chck32 = new CheckBox();
            chck32.Location = new System.Drawing.Point(10, 30);
            chck32.Size = new System.Drawing.Size(250, 25);
            chck32.Text = "Remove Telemetry/Data Collection";
            chck32.Checked = true;
            chck32.Click += c_p;
            chck32.TabIndex = 32;
            panel2.Controls.Add(chck32);
            CheckBox chck33 = new CheckBox();
            chck33.Location = new System.Drawing.Point(10, 55);
            chck33.Size = new System.Drawing.Size(250, 25);
            chck33.Text = "Disable PowerShell Telemetry";
            chck33.Checked = true;
            chck33.Click += c_p;
            chck33.TabIndex = 33;
            panel2.Controls.Add(chck33);
            CheckBox chck34 = new CheckBox();
            chck34.Location = new System.Drawing.Point(10, 80);
            chck34.Size = new System.Drawing.Size(250, 25);
            chck34.Text = "Disable Skype Telemetry";
            chck34.Checked = true;
            chck34.Click += c_p;
            chck34.TabIndex = 34;
            panel2.Controls.Add(chck34);
            CheckBox chck35 = new CheckBox();
            chck35.Location = new System.Drawing.Point(10, 105);
            chck35.Size = new System.Drawing.Size(270, 25);
            chck35.Text = "Disable Media Player Usage Reports";
            chck35.Checked = true;
            chck35.Click += c_p;
            chck35.TabIndex = 35;
            panel2.Controls.Add(chck35);
            CheckBox chck36 = new CheckBox();
            chck36.Location = new System.Drawing.Point(10, 130);
            chck36.Size = new System.Drawing.Size(250, 25);
            chck36.Text = "Disable Mozilla Telemetry";
            chck36.Checked = true;
            chck36.Click += c_p;
            chck36.TabIndex = 36;
            panel2.Controls.Add(chck36);
            CheckBox chck37 = new CheckBox();
            chck37.Location = new System.Drawing.Point(10, 155);
            chck37.Size = new System.Drawing.Size(250, 25);
            chck37.Text = "Disable Apps Use My Advertising ID";
            chck37.Checked = true;
            chck37.Click += c_p;
            chck37.TabIndex = 37;
            panel2.Controls.Add(chck37);
            CheckBox chck38 = new CheckBox();
            chck38.Location = new System.Drawing.Point(10, 180);
            chck38.Size = new System.Drawing.Size(270, 25);
            chck38.Text = "Disable Send Info About Writing";
            chck38.Checked = true;
            chck38.Click += c_p;
            chck38.TabIndex = 38;
            panel2.Controls.Add(chck38);
            CheckBox chck39 = new CheckBox();
            chck39.Location = new System.Drawing.Point(10, 205);
            chck39.Size = new System.Drawing.Size(250, 25);
            chck39.Text = "Disable Handwriting Recognition";
            chck39.Checked = true;
            chck39.Click += c_p;
            chck39.TabIndex = 39;
            panel2.Controls.Add(chck39);
            CheckBox chck40 = new CheckBox();
            chck40.Location = new System.Drawing.Point(10, 230);
            chck40.Size = new System.Drawing.Size(250, 25);
            chck40.Text = "Disable Watson Malware Reports";
            chck40.Checked = true;
            chck40.Click += c_p;
            chck40.TabIndex = 40;
            panel2.Controls.Add(chck40);
            CheckBox chck41 = new CheckBox();
            chck41.Location = new System.Drawing.Point(10, 255);
            chck41.Size = new System.Drawing.Size(250, 25);
            chck41.Text = "Disable Malware Diagnostic Data";
            chck41.Checked = true;
            chck41.Click += c_p;
            chck41.TabIndex = 41;
            panel2.Controls.Add(chck41);
            CheckBox chck42 = new CheckBox();
            chck42.Location = new System.Drawing.Point(10, 280);
            chck42.Size = new System.Drawing.Size(250, 25);
            chck42.Text = "Disable Reporting to MS MAPS";
            chck42.Checked = true;
            chck42.Click += c_p;
            chck42.TabIndex = 42;
            panel2.Controls.Add(chck42);
            CheckBox chck43 = new CheckBox();
            chck43.Location = new System.Drawing.Point(10, 305);
            chck43.Size = new System.Drawing.Size(270, 25);
            chck43.Text = "Disable Spynet Defender Reporting";
            chck43.Checked = true;
            chck43.Click += c_p;
            chck43.TabIndex = 43;
            panel2.Controls.Add(chck43);
            CheckBox chck44 = new CheckBox();
            chck44.Location = new System.Drawing.Point(10, 330);
            chck44.Size = new System.Drawing.Size(250, 25);
            chck44.Text = "Do Not Send Malware Samples";
            chck44.Checked = true;
            chck44.Click += c_p;
            chck44.TabIndex = 44;
            panel2.Controls.Add(chck44);
            CheckBox chck45 = new CheckBox();
            chck45.Location = new System.Drawing.Point(10, 355);
            chck45.Size = new System.Drawing.Size(250, 25);
            chck45.Text = "Disable Sending Typing Samples";
            chck45.Checked = true;
            chck45.Click += c_p;
            chck45.TabIndex = 45;
            panel2.Controls.Add(chck45);
            CheckBox chck46 = new CheckBox();
            chck46.Location = new System.Drawing.Point(10, 380);
            chck46.Size = new System.Drawing.Size(250, 25);
            chck46.Text = "Disable Sending Contacts to MS";
            chck46.Checked = true;
            chck46.Click += c_p;
            chck46.TabIndex = 46;
            panel2.Controls.Add(chck46);
            CheckBox chck47 = new CheckBox();
            chck47.Location = new System.Drawing.Point(10, 405);
            chck47.Size = new System.Drawing.Size(250, 25);
            chck47.Text = "Disable Cortana";
            chck47.Checked = true;
            chck47.Click += c_p;
            chck47.TabIndex = 47;
            panel2.Controls.Add(chck47);
            CheckBox chck48 = new CheckBox();
            chck48.Location = new System.Drawing.Point(10, 05);
            chck48.Size = new System.Drawing.Size(260, 25);
            chck48.Text = "Show File Extensions in Explorer";
            chck48.Checked = true;
            chck48.Click += c_p;
            chck48.TabIndex = 48;
            panel3.Controls.Add(chck48);
            CheckBox chck49 = new CheckBox();
            chck49.Location = new System.Drawing.Point(10, 30);
            chck49.Size = new System.Drawing.Size(260, 25);
            chck49.Text = "Disable Transparency on Taskbar";
            chck49.Checked = true;
            chck49.Click += c_p;
            chck49.TabIndex = 49;
            panel3.Controls.Add(chck49);
            CheckBox chck50 = new CheckBox();
            chck50.Location = new System.Drawing.Point(10, 55);
            chck50.Size = new System.Drawing.Size(260, 25);
            chck50.Text = "Disable Windows Animations";
            chck50.Checked = true;
            chck50.Click += c_p;
            chck50.TabIndex = 50;
            panel3.Controls.Add(chck50);
            CheckBox chck51 = new CheckBox();
            chck51.Location = new System.Drawing.Point(10, 80);
            chck51.Size = new System.Drawing.Size(260, 25);
            chck51.Text = "Disable MRU lists (jump lists)";
            chck51.Checked = true;
            chck51.Click += c_p;
            chck51.TabIndex = 51;
            panel3.Controls.Add(chck51);
            CheckBox chck52 = new CheckBox();
            chck52.Location = new System.Drawing.Point(10, 105);
            chck52.Size = new System.Drawing.Size(260, 25);
            chck52.Text = "Set Search Box to Icon Only";
            chck52.Checked = true;
            chck52.Click += c_p;
            chck52.TabIndex = 52;
            panel3.Controls.Add(chck52);
            CheckBox chck53 = new CheckBox();
            chck53.Location = new System.Drawing.Point(10, 130);
            chck53.Size = new System.Drawing.Size(260, 25);
            chck53.Text = "Explorer on Start on This PC";
            chck53.Checked = true;
            chck53.Click += c_p;
            chck53.TabIndex = 53;
            panel3.Controls.Add(chck53);
            CheckBox chck54 = new CheckBox();
            chck54.Location = new System.Drawing.Point(10, 05);
            chck54.Size = new System.Drawing.Size(260, 25);
            chck54.Text = "Remove Windows Game Bar/DVR";
            chck54.Checked = true;
            chck54.Click += c_p;
            chck54.TabIndex = 54;
            panel4.Controls.Add(chck54);
            CheckBox chck55 = new CheckBox();
            chck55.Location = new System.Drawing.Point(10, 405);
            chck55.Size = new System.Drawing.Size(260, 25);
            chck55.Text = "Enable Service Tweaks";
            chck55.Checked = true;
            chck55.Click += c_p;
            chck55.TabIndex = 55;
            panel1.Controls.Add(chck55);
            CheckBox chck56 = new CheckBox();
            chck56.Location = new System.Drawing.Point(285, 380);
            chck56.Size = new System.Drawing.Size(260, 25);
            chck56.Text = "Remove Bloatware (Preinstalled)";
            chck56.Checked = true;
            chck56.Click += c_p;
            chck56.TabIndex = 56;
            panel1.Controls.Add(chck56);
            CheckBox chck57 = new CheckBox();
            chck57.Location = new System.Drawing.Point(285, 405);
            chck57.Size = new System.Drawing.Size(260, 25);
            chck57.Text = "Disable Unnecessary Startup Apps";
            chck57.Checked = true;
            chck57.Click += c_p;
            chck57.TabIndex = 57;
            panel1.Controls.Add(chck57);
            CheckBox chck58 = new CheckBox();
            chck58.Location = new System.Drawing.Point(10, 30);
            chck58.Size = new System.Drawing.Size(260, 25);
            chck58.Text = "Clean Temp/Cache/Prefetch/Logs";
            chck58.Checked = true;
            chck58.Click += c_p;
            chck58.TabIndex = 58;
            panel4.Controls.Add(chck58);
            CheckBox chck59 = new CheckBox();
            chck59.Location = new System.Drawing.Point(10, 130);
            chck59.Size = new System.Drawing.Size(263, 25);
            chck59.Text = "Remove News and Interests/Widgets";
            chck59.Click += c_p;
            chck59.TabIndex = 59;
            panel4.Controls.Add(chck59);
            CheckBox chck60 = new CheckBox();
            chck60.Location = new System.Drawing.Point(10, 55);
            chck60.Size = new System.Drawing.Size(255, 25);
            chck60.Text = "Remove Microsoft OneDrive";
            chck60.Click += c_p;
            chck60.TabIndex = 60;
            panel5.Controls.Add(chck60);
            CheckBox chck61 = new CheckBox();
            chck61.Location = new System.Drawing.Point(10, 05);
            chck61.Size = new System.Drawing.Size(255, 25);
            chck61.Text = "Disable Xbox Services";
            chck61.Click += c_p;
            chck61.TabIndex = 61;
            panel5.Controls.Add(chck61);
            CheckBox chck62 = new CheckBox();
            chck62.Location = new System.Drawing.Point(10, 30);
            chck62.Size = new System.Drawing.Size(255, 25);
            chck62.Text = "Enable Fast/Secure DNS (1.1.1.1)";
            chck62.Click += c_p;
            chck62.TabIndex = 62;
            panel5.Controls.Add(chck62);
            CheckBox chck63 = new CheckBox();
            chck63.Location = new System.Drawing.Point(10, 80);
            chck63.Size = new System.Drawing.Size(255, 25);
            chck63.Text = "Scan for Adware (AdwCleaner)";
            chck63.Click += c_p;
            chck63.TabIndex = 63;
            panel4.Controls.Add(chck63);
            CheckBox chck68 = new CheckBox();
            chck68.Location = new System.Drawing.Point(10, 105);
            chck68.Size = new System.Drawing.Size(255, 25);
            chck68.Text = "Clean WinSxS Folder";
            chck68.Click += c_p;
            chck68.TabIndex = 68;
            panel4.Controls.Add(chck68);

            groupBox3.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button2.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button2.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);

            groupBox2.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button3.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button3.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);

            groupBox1.ForeColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor);
            button1.BackColor = System.Drawing.ColorTranslator.FromHtml(selectioncolor2);
            button1.ForeColor = System.Drawing.ColorTranslator.FromHtml(mainforecolor);
            if (args.Equals("-auto") || args.Equals("auto") || args.Equals("/auto") || args.Equals("*auto"))
            {
                doengine();
                Console.WriteLine(args);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // Create a region with rounded corners
            IntPtr regionHandle = CreateRoundRectRgn(0, 0, this.Width, this.Height, 20, 20); // 50 is the radius for the corners

            // Apply the region to the form
            //this.Region = Region.FromHrgn(regionHandle);

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C bcdedit /deletevalue {current} safeboot";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();

        }

        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void ToolStrip1_MouseDown(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void label1_MouseDown(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void label1_MouseMove(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }


        private void panelmain_MouseDown(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        public void doengine()
        {
            Application.VisualStyleState = VisualStyleState.NonClientAreaEnabled;
            button5.Enabled = false;
            textBox1.Visible = true;
            //DO START ENGINE
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            int alltodo = 0; //max 68
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

            //Perforamnce Panel
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
                    string caseSwitch = checkBox.Text;

                    switch (caseSwitch)
                    {
                        case "Disable Edge WebWidget":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Edge\" /v WebWidgetAllowed /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Power Option to Ultimate Perform.":
                            Console.WriteLine(checkBox.Text); done++;

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
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C bcdedit /set timeout 3";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C bcdedit /timeout 3";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Hibernation/Fast Startup":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C powercfg -hibernate off";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Windows Insider Experiments":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\PolicyManager\\current\\device\\System\" /v \"AllowExperimentation\" /t REG_DWORD /d \"0\" /f && reg add \"HKLM\\SOFTWARE\\Microsoft\\PolicyManager\\default\\System\\AllowExperimentation\" /v \"value\" /t \"REG_DWORD\" /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable App Launch Tracking":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v \"Start_TrackProgs\" /d \"0\" /t REG_DWORD /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Powerthrottling (Intel 6gen+)":

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\Power\\PowerThrottling\" /v \"PowerThrottlingOff\" /t REG_DWORD /d \"1\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            Console.WriteLine(checkBox.Text); done++;
                            break;
                        case "Turn Off Background Apps":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C REG ADD \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\BackgroundAccessApplications\" /v GlobalUserDisabled  /t REG_DWORD /d 1 /f && REG ADD \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Search\" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Sticky Keys Prompt":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\Control Panel\\Accessibility\\StickyKeys\" /v \"Flags\" /t REG_SZ /d 506 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Activity History":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\System\" /v \"PublishUserActivities\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Updates for MS Store Apps":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\WindowsStore\" /v \"AutoDownload\" /t REG_DWORD /d 2 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "SmartScreen Filter for Apps Disable":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AppHost\" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Let Websites Provide Locally":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Control Panel\\International\\User Profile\" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Fix Microsoft Edge Settings":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Storage\\microsoft.microsoftedge_8wekyb3d8bbwe\\MicrosoftEdge\\Main\" /v DoNotTrack /t REG_DWORD /d 1 /f && reg add \"HKCU\\SOFTWARE\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Storage\\microsoft.microsoftedge_8wekyb3d8bbwe\\MicrosoftEdge\\User\\Default\\SearchScopes\" /v ShowSearchSuggestionsGlobal /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Storage\\microsoft.microsoftedge_8wekyb3d8bbwe\\MicrosoftEdge\\FlipAhead\" /v FPEnabled /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Storage\\microsoft.microsoftedge_8wekyb3d8bbwe\\MicrosoftEdge\\PhishingFilter\" /v EnabledV9 /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Nagle's Alg. (Delayed ACKs)":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\MSMQ\\Parameters\" /v TcpNoDelay /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "CPU Priority Tweaks":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\usbxhci\\Parameters\" /v ThreadPriority /t REG_DWORD /d 31 /f && reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\USBHUB3\\Parameters\" /v ThreadPriority /t REG_DWORD /d 31 /f && reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NDIS\\Parameters\" /v ThreadPriority /t REG_DWORD /d 31 /f && reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\nvlddmkm\\Parameters\" /v ThreadPriority /t REG_DWORD /d 31 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C bcdedit /set {current} numproc %NUMBER_OF_PROCESSORS%";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-WmiObject win32_Processor | findstr /r \"Intel\" > NOLPi.txt";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();


                            string NOLPi = File.ReadAllText("NOLPi.txt");
                            if (NOLPi is null)
                            {
                                Console.WriteLine("amd");
                                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                                startInfo.FileName = "cmd.exe";
                                startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"GPU Priority\" /t REG_DWORD /d 8 /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Priority\" /t REG_DWORD /d 6 /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Scheduling Category\" /t REG_SZ /d \"High\" /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"SFIO Priority\" /t REG_SZ /d \"High\" /f";
                                process.StartInfo = startInfo;
                                process.Start(); process.WaitForExit();
                            }
                            else
                            {
                                Console.WriteLine("intel");
                                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                                startInfo.FileName = "cmd.exe";
                                startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v Affinity /t REG_DWORD /d 0 /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Background Only\" /t REG_SZ /d \"False\" /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Clock Rate\" /t REG_DWORD /d 10000 /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Scheduling Category\" /t REG_SZ /d \"High\" /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"SFIO Priority\" /t REG_SZ /d \"High\" /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"GPU Priority\" /t REG_DWORD /d 8 /f && reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Multimedia\\SystemProfile\\Tasks\\Games\" /v \"Priority\" /t REG_DWORD /d 6 /f";
                                process.StartInfo = startInfo;
                                process.Start(); process.WaitForExit();
                            }
                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del /f /q NOLPi.txt && del /f /q NOLP.txt";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Location Sensors":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Sensor\\Permissions\\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}\" /v SensorPermissionState /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable WiFi HotSpot Auto-Sharing":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Microsoft\\PolicyManager\\default\\WiFi\\AllowWiFiHotSpotReporting\" /v value /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Shared HotSpot Connect":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Microsoft\\PolicyManager\\default\\WiFi\\AllowAutoConnectToWiFiSenseHotspots\" /v value /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Updates Notify to Sched. Restart":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\WindowsUpdate\\UX\\Settings\" /v UxOption /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "P2P Update Setting to LAN (local)":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\DeliveryOptimization\\Config\" /v DODownloadMode /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Set Lower Shutdown Time (2sec)":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\" /v \"WaitToKillServiceTimeout\" /t REG_SZ /d 2000 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Old Device Drivers":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C SET DEVMGR_SHOW_NONPRESENT_DEVICES=1";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Get Even More Out of...":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-310093Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-314559Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-314563Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338387Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338388Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338389Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338393Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-353698Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\UserProfileEngagement\" /v \"ScoobeSystemSettingEnabled\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Installing Suggested Apps":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent\" /v \"DisableWindowsConsumerFeatures\" /t REG_DWORD /d 1 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"ContentDeliveryAllowed\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"OemPreInstalledAppsEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"PreInstalledAppsEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"PreInstalledAppsEverEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SilentInstalledAppsEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"FeatureManagementEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SoftLandingEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"RemediationRequired\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContentEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-310093Enabled\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338388Enabled\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338393Enabled\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-353694Enabled\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-353696Enabled\" /t REG_DWORD /d \"0\" /f && reg add \"HKLM\\Software\\Policies\\Microsoft\\PushToInstall\" /v \"DisablePushToInstall\" /t REG_DWORD /d \"1\" /f && reg delete \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\\Subscriptions\" /f && reg delete \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\\SuggestedApps\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Start Menu Ads/Suggestions":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SystemPaneSuggestionsEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v \"ShowSyncProviderNotifications\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"RotatingLockScreenEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"RotatingLockScreenOverlayEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\ContentDeliveryManager\" /v \"SubscribedContent-338387Enabled\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Suggest Apps WindowsInk":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\PolicyManager\\default\\WindowsInkWorkspace\\AllowSuggestedAppsInWindowsInkWorkspace\" /v \"value\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Unnecessary Components":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command disable-windowsoptionalfeature -online -featureName Printing-XPSServices-Features -NoRestart; disable-windowsoptionalfeature -online -featureName Xps-Foundation-Xps-Viewer -NoRestart";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Defender Scheduled Scan Nerf":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\Windows Defender\\Windows Defender Scheduled Scan\" /RL LIMITED";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Process Mitigation":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Set-ProcessMitigation -System -Disable CFG";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Defragment Indexing Service File":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net stop wsearch /y";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C esentutl /d %programdata%\\ProgramData\\Microsoft\\Search\\Data\\Applications\\Windows\\Windows.edb";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net start wsearch";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Enable Service Tweaks":
                            Console.WriteLine(checkBox.Text); done++;

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
                            break;
                        case "Remove Bloatware (Preinstalled)":
                            Console.WriteLine(checkBox.Text); done++;

                            //string[] whitelistapps = { "Microsoft.MicrosoftOfficeHub", "Microsoft.Office.OneNote", "Microsoft.WindowsAlarms", "Microsoft.WindowsCalculator", "Microsoft.WindowsCamera", "microsoft.windowscommunicationsapps", "Microsoft.NET.Native.Framework.2.2", "Microsoft.NET.Native.Framework.2.0", "Microsoft.NET.Native.Runtime.2.2", "Microsoft.NET.Native.Runtime.2.0", "Microsoft.UI.Xaml.2.7", "Microsoft.UI.Xaml.2.0", "Microsoft.WindowsAppRuntime.1.3", "Microsoft.NET.Native.Framework.1.7", "MicrosoftWindows.Client.Core", "Microsoft.LockApp", "Microsoft.ECApp", "Microsoft.Windows.ContentDeliveryManager", "Microsoft.Windows.Search", "Microsoft.Windows.OOBENetworkCaptivePortal", "Microsoft.Windows.SecHealthUI", "Microsoft.SecHealthUI", "Microsoft.WindowsAppRuntime.CBS", "Microsoft.VCLibs.140.00.UWPDesktop", "Microsoft.VCLibs.120.00.UWPDesktop", "Microsoft.VCLibs.110.00.UWPDesktop", "Microsoft.DirectXRuntime", "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay", "Microsoft.GamingApp", "Microsoft.GamingServices", "Microsoft.XboxIdentityProvider", "Microsoft.Xbox.TCUI", "Microsoft.AccountsControl", "Microsoft.WindowsStore", "Microsoft.StorePurchaseApp", "Microsoft.VP9VideoExtensions", "Microsoft.RawImageExtension", "Microsoft.HEIFImageExtension", "Microsoft.HEIFImageExtension", "Microsoft.WebMediaExtensions", "RealtekSemiconductorCorp.RealtekAudioControl", "Microsoft.MicrosoftEdge", "Microsoft.MicrosoftEdge.Stable", "MicrosoftWindows.Client.FileExp", "NVIDIACorp.NVIDIAControlPanel", "AppUp.IntelGraphicsExperience", "Microsoft.Paint", "Microsoft.Messaging", "Microsoft.AsyncTextService", "Microsoft.CredDialogHost", "Microsoft.Win32WebViewHost", "Microsoft.MicrosoftEdgeDevToolsClient", "Microsoft.Windows.OOBENetworkConnectionFlow", "Microsoft.Windows.PeopleExperienceHost", "Microsoft.Windows.PinningConfirmationDialog", "Microsoft.Windows.SecondaryTileExperience", "Microsoft.Windows.SecureAssessmentBrowser", "Microsoft.Windows.ShellExperienceHost", "Microsoft.Windows.StartMenuExperienceHost", "Microsoft.Windows.XGpuEjectDialog", "Microsoft.XboxGameCallableUI", "MicrosoftWindows.UndockedDevKit", "NcsiUwpApp", "Windows.CBSPreview", "Windows.MiracastView", "Windows.ContactSupport", "Windows.PrintDialog", "c5e2524a-ea46-4f67-841f-6a9465d9d515", "windows.immersivecontrolpanel", "WinRAR.ShellExtension", "Microsoft.WindowsNotepad", "MicrosoftWindows.Client.WebExperience", "Microsoft.ZuneMusic", "Microsoft.ZuneVideo", "Microsoft.OutlookForWindows", "MicrosoftWindows.Ai.Copilot.Provider", "Microsoft.WindowsTerminal", "Microsoft.Windows.Terminal", "WindowsTerminal", "Microsoft.Winget.Source", "Microsoft.DesktopAppInstaller", "Microsoft.Services.Store.Engagement", "Microsoft.HEVCVideoExtension", "Microsoft.WebpImageExtension", "MicrosoftWindows.CrossDevice", "NotepadPlusPlus", "MicrosoftCorporationII.WinAppRuntime.Main.1.5", "Microsoft.WindowsAppRuntime.1.5", "MicrosoftCorporationII.WinAppRuntime.Singleton", "Microsoft.WindowsSoundRecorder", "MicrosoftCorporationII.WinAppRuntime.Main.1.4", "MicrosoftWindows.Client.LKG", "MicrosoftWindows.Client.CBS", "Microsoft.VCLibs.140.00", "Microsoft.Windows.CloudExperienceHost", "SpotifyAB.SpotifyMusic", "Microsoft.SkypeApp", "5319275A.WhatsAppDesktop", "FACEBOOK.317180B0BB486", "TelegramMessengerLLP.TelegramDesktop", "4DF9E0F8.Netflix", "Discord", "Paint", "mspaint", "Microsoft.Windows.Paint" };

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command $RemoveAppPkgs = (Get-AppxPackage -AllUsers).Name; $whitelistapps = @('Microsoft.MicrosoftOfficeHub','Microsoft.Office.OneNote','Microsoft.WindowsAlarms','Microsoft.WindowsCalculator','Microsoft.WindowsCamera','microsoft.windowscommunicationsapps','Microsoft.NET.Native.Framework.2.2','Microsoft.NET.Native.Framework.2.0','Microsoft.NET.Native.Runtime.2.2','Microsoft.NET.Native.Runtime.2.0','Microsoft.UI.Xaml.2.7','Microsoft.UI.Xaml.2.0','Microsoft.WindowsAppRuntime.1.3','Microsoft.NET.Native.Framework.1.7','MicrosoftWindows.Client.Core','Microsoft.LockApp','Microsoft.ECApp','Microsoft.Windows.ContentDeliveryManager','Microsoft.Windows.Search','Microsoft.Windows.OOBENetworkCaptivePortal','Microsoft.Windows.SecHealthUI','Microsoft.SecHealthUI','Microsoft.WindowsAppRuntime.CBS','Microsoft.VCLibs.140.00.UWPDesktop','Microsoft.VCLibs.120.00.UWPDesktop','Microsoft.VCLibs.110.00.UWPDesktop','Microsoft.DirectXRuntime','Microsoft.XboxGameOverlay','Microsoft.XboxGamingOverlay','Microsoft.GamingApp','Microsoft.GamingServices','Microsoft.XboxIdentityProvider','Microsoft.Xbox.TCUI','Microsoft.AccountsControl','Microsoft.WindowsStore','Microsoft.StorePurchaseApp','Microsoft.VP9VideoExtensions','Microsoft.RawImageExtension','Microsoft.HEIFImageExtension','Microsoft.HEIFImageExtension','Microsoft.WebMediaExtensions','RealtekSemiconductorCorp.RealtekAudioControl','Microsoft.MicrosoftEdge','Microsoft.MicrosoftEdge.Stable','MicrosoftWindows.Client.FileExp','NVIDIACorp.NVIDIAControlPanel','AppUp.IntelGraphicsExperience','Microsoft.Paint','Microsoft.Messaging','Microsoft.AsyncTextService','Microsoft.CredDialogHost','Microsoft.Win32WebViewHost','Microsoft.MicrosoftEdgeDevToolsClient','Microsoft.Windows.OOBENetworkConnectionFlow','Microsoft.Windows.PeopleExperienceHost','Microsoft.Windows.PinningConfirmationDialog','Microsoft.Windows.SecondaryTileExperience','Microsoft.Windows.SecureAssessmentBrowser','Microsoft.Windows.ShellExperienceHost','Microsoft.Windows.StartMenuExperienceHost','Microsoft.Windows.XGpuEjectDialog','Microsoft.XboxGameCallableUI','MicrosoftWindows.UndockedDevKit','NcsiUwpApp','Windows.CBSPreview','Windows.MiracastView','Windows.ContactSupport','Windows.PrintDialog','c5e2524a-ea46-4f67-841f-6a9465d9d515','windows.immersivecontrolpanel','WinRAR.ShellExtension','Microsoft.WindowsNotepad','MicrosoftWindows.Client.WebExperience','Microsoft.ZuneMusic','Microsoft.ZuneVideo','Microsoft.OutlookForWindows','MicrosoftWindows.Ai.Copilot.Provider','Microsoft.WindowsTerminal','Microsoft.Windows.Terminal','WindowsTerminal','Microsoft.Winget.Source','Microsoft.DesktopAppInstaller','Microsoft.Services.Store.Engagement','Microsoft.HEVCVideoExtension','Microsoft.WebpImageExtension','MicrosoftWindows.CrossDevice','NotepadPlusPlus','MicrosoftCorporationII.WinAppRuntime.Main.1.5','Microsoft.WindowsAppRuntime.1.5','MicrosoftCorporationII.WinAppRuntime.Singleton','Microsoft.WindowsSoundRecorder','MicrosoftCorporationII.WinAppRuntime.Main.1.4','MicrosoftWindows.Client.LKG','MicrosoftWindows.Client.CBS','Microsoft.VCLibs.140.00','Microsoft.Windows.CloudExperienceHost','SpotifyAB.SpotifyMusic','Microsoft.SkypeApp','5319275A.WhatsAppDesktop','FACEBOOK.317180B0BB486','TelegramMessengerLLP.TelegramDesktop','4DF9E0F8.Netflix','Discord','Paint','mspaint','Microsoft.Windows.Paint'); ForEach($TargetApp in $RemoveAppPkgs){ If( $whitelistapps -notcontains $TargetApp) { Get-AppxPackage -Name $TargetApp -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue; Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $TargetApp | Remove-AppxProvisionedPackage -Online }}";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Unnecessary Startup Apps":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"SunJavaUpdateSched\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"SunJavaUpdateSched\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"MTPW\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"TeamsMachineInstaller\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"TeamsMachineInstaller\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"CiscoMeetingDaemon\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Adobe Reader Speed Launcher\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Adobe Reader Speed Launcher\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"CCleaner Smart Cleaning\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"CCleaner Monitor\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Spotify Web Helper\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Gaijin.Net Updater\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"com.squirrel.Teams.Teams\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Google Update\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"BitTorrent Bleep\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Skype\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"adobeAAMUpdater-1.0\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"AdobeAAMUpdater\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"iTunesHelper\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"UpdatePPShortCut\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Live Update\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Live Update\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Wondershare Helper Compact\" /f && reg delete \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Wondershare Helper Compact\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Cisco AnyConnect Secure Mobility Agent for Windows\" /f && reg delete \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Cisco AnyConnect Secure Mobility Agent for Windows\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Opera Browser Assistant\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Steam\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"EADM\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"EpicGamesLauncher\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"GogGalaxy\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Skype for Desktop\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Wargaming.net Game Center\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"ut\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Lync\" /f && reg delete \"HKLM\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\" /v \"Google Chrome\" /f && reg delete \"HKLM\\SOFTWARE\\Microsoft\\Active Setup\\Installed Components\" /v \"Microsoft Edge\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"MicrosoftEdgeAutoLaunch_E9C49D8E9BDC4095F482C844743B9E82\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"MicrosoftEdgeAutoLaunch_D3AB3F7FBB44621987441AECEC1156AD\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"MicrosoftEdgeAutoLaunch\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Microsoft Edge Update\" /f && reg delete \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"MicrosoftEdgeAutoLaunch_31CF12C7FD715D87B15C2DF57BBF8D3E\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Discord\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"Ubisoft Game Launcher\" /f && reg delete \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"com.blitz.app\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
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
                    string caseSwitch = checkBox.Text;

                    switch (caseSwitch)
                    {
                        case "Disable Telemetry Scheduled Tasks":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C schtasks /Change /TN \"Microsoft\\Windows\\AppID\\SmartScreenSpecific\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\Microsoft Compatibility Appraiser\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\ProgramDataUpdater\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Application Experience\\StartupAppTask\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\Consolidator\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\KernelCeipTask\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\UsbCeip\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\DiskDiagnostic\\Microsoft-Windows-DiskDiagnosticDataCollector\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\MemoryDiagnostic\\ProcessMemoryDiagnosticEvent\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Power Efficiency Diagnostics\\AnalyzeSystem\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Customer Experience Improvement Program\\Uploader\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Shell\\FamilySafetyUpload\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentLogOn\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentFallBack\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentFallBack2016\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\OfficeTelemetryAgentLogOn2016\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office 15 Subscription Heartbeat\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office 16 Subscription Heartbeat\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\Windows Error Reporting\\QueueReporting\" /Disable && schtasks /Change /TN \"Microsoft\\Windows\\WindowsUpdate\\Automatic App Update\" /Disable && schtasks /Change /TN \"NIUpdateServiceStartupTask\" /Disable && schtasks /Change /TN \"CCleaner Update\" /Disable && schtasks /Change /TN \"CCleanerCrashReportings\" /Disable && schtasks /Change /TN \"CCleanerSkipUAC - $env:username\" /Disable && schtasks /Change /TN \"updater\" /Disable && schtasks /Change /TN \"Adobe Acrobat Update Task\" /Disable && schtasks /Change /TN \"MicrosoftEdgeUpdateTaskMachineCore\" /Disable && schtasks /Change /TN \"MicrosoftEdgeUpdateTaskMachineUA\" /Disable && schtasks /Change /TN \"MiniToolPartitionWizard\" /Disable && schtasks /Change /TN \"AMDLinkUpdate\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Automatic Updates 2.0\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Feature Updates\" /Disable && schtasks /Change /TN \"Microsoft\\Office\\Office Feature Updates Logon\" /Disable && schtasks /Change /TN \"GoogleUpdateTaskMachineCore\" /Disable && schtasks /Change /TN \"GoogleUpdateTaskMachineUA\" /Disable && schtasks /DELETE /TN \"AMDInstallLauncher\" /f && schtasks /DELETE /TN \"AMDLinkUpdate\" /f && schtasks /DELETE /TN \"AMDRyzenMasterSDKTask\" /f && schtasks /DELETE /TN \"DUpdaterTask\" /f && schtasks /DELETE /TN \"ModifyLinkUpdate\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Telemetry/Data Collection":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del /q %temp%\\NVIDIA Corporation\\NV_Cache\\* && del /q %programdata%\\NVIDIA Corporation\\NV_Cache\\*";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\NVIDIA Corporation\\NvControlPanel2\\Client\" /v OptInOrOutPreference /t REG_DWORD /d 0 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\NVIDIA Corporation\\Global\\FTS\" /v EnableRID44231 /t REG_DWORD /d 0 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\NVIDIA Corporation\\Global\\FTS\" /v EnableRID64640 /t REG_DWORD /d 0 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\NVIDIA Corporation\\Global\\FTS\" /v EnableRID66610 /t REG_DWORD /d 0 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NvTelemetryContainer\" /v Start /t REG_DWORD /d 4 /f && REG ADD \"HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\" /v NoInstrumentation /t REG_DWORD /d 1 /f && REG ADD \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\" /v NoInstrumentation /t REG_DWORD /d 1 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\HandwritingErrorReports\" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection\" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection\" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\" /v SmartScreenEnabled /t REG_SZ /d \"Off\" /f && REG ADD \"HKEY_CURRENT_USER\\SOFTWARE\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Storage\\microsoft.microsoftedge_8wekyb3d8bbwe\\MicrosoftEdge\\PhishingFilter\" /v EnabledV9 /t REG_DWORD /d 0 /f && REG ADD \"HKEY_CURRENT_USER\\SOFTWARE\\Policies\\Microsoft\\Windows\\Explorer\" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Assistance\\Client\\1.0\" /v NoActiveHelp /t REG_DWORD /d 1 /f && REG ADD \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\CrashControl\\StorageTelemetry\" /v DeviceDumpEnabled /t REG_DWORD /d 0 /f &&  && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\CompatTelRunner.exe\" /v Debugger /t REG_SZ /d \"%windir%\\System32\\taskkill.exe\" /f && REG ADD \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\DeviceCensus.exe\" /v Debugger /t REG_SZ /d \"%windir%\\System32\\taskkill.exe\" /f && reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Device Metadata\" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f && reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\DataCollection\" /v \"AllowTelemetry\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Policies\\Microsoft\\Windows\\DataCollection\" /v \"AllowTelemetry\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\MRT\" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\SQMClient\\Windows\" /v \"CEIPEnable\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\AppCompat\" /v \"AITEnable\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\AppCompat\" /v \"DisableUAR\" /t REG_DWORD /d 1 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\DataCollection\" /v \"AllowTelemetry\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\WMI\\AutoLogger\\AutoLogger-Diagtrack-Listener\" /v \"Start\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SYSTEM\\CurrentControlSet\\Control\\WMI\\AutoLogger\\SQMLogger\" /v \"Start\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Privacy\" /v \"TailoredExperiencesWithDiagnosticDataEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SYSTEM\\ControlSet001\\Control\\WMI\\Autologger\\AutoLogger-Diagtrack-Listener\" /v \"Start\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\dmwappushservice\" /v \"Start\" /t REG_DWORD /d 4 /f && reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\DiagTrack\" /v \"Start\" /t REG_DWORD /d 4 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\Common\\ClientTelemetry\" /v \"DisableTelemetry\" /t REG_DWORD /d 1 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Common\\ClientTelemetry\" /v \"DisableTelemetry\" /t REG_DWORD /d 1 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\17.0\\Common\\ClientTelemetry\" /v \"DisableTelemetry\" /t REG_DWORD /d 1 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\Common\\ClientTelemetry\" /v \"VerboseLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Common\\ClientTelemetry\" /v \"VerboseLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\15.0\\Outlook\\Options\\Mail\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Outlook\\Options\\Mail\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\15.0\\Outlook\\Options\\Calendar\" /v \"EnableCalendarLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Outlook\\Options\\Calendar\" /v \"EnableCalendarLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\15.0\\Word\\Options\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Word\\Options\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\17.0\\Word\\Options\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Policies\\Microsoft\\Office\\15.0\\OSM\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Policies\\Microsoft\\Office\\16.0\\OSM\" /v \"EnableLogging\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Policies\\Microsoft\\Office\\15.0\\OSM\" /v \"EnableUpload\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Policies\\Microsoft\\Office\\16.0\\OSM\" /v \"EnableUpload\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Policies\\Microsoft\\Office\\17.0\\OSM\" /v \"EnableUpload\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\15.0\\Common\\Feedback\" /v \"Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Common\\Feedback\" /v \"Enabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\15.0\\Common\" /v \"QMEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\16.0\\Common\" /v \"QMEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Office\\17.0\\Common\" /v \"QMEnabled\" /t REG_DWORD /d 0 /f && sc stop VSStandardCollectorService150 && sc config VSStandardCollectorService150 start= disabled && reg add \"HKLM\\Software\\Wow6432Node\\Microsoft\\VSCommon\\14.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Wow6432Node\\Microsoft\\VSCommon\\15.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Wow6432Node\\Microsoft\\VSCommon\\16.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Wow6432Node\\Microsoft\\VSCommon\\17.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\VSCommon\\14.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\VSCommon\\15.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\VSCommon\\16.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\VSCommon\\17.0\\SQM\" /v \"OptIn\" /t REG_DWORD /d 0 /f && reg add \"HKLM\\Software\\Microsoft\\VisualStudio\\Telemetry\" /v \"TurnOffSwitch\" /t REG_DWORD /d 1 /f && reg add \"HKLM\\Software\\Policies\\Microsoft\\VisualStudio\\Feedback\" /v \"DisableFeedbackDialog\" /t REG_DWORD /d 1 /f && reg add \"HKLM\\Software\\Policies\\Microsoft\\VisualStudio\\Feedback\" /v \"DisableEmailInput\" /t REG_DWORD /d 1 /f && reg add \"HKLM\\Software\\Policies\\Microsoft\\VisualStudio\\Feedback\" /v \"DisableScreenshotCapture\" /t REG_DWORD /d 1 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Google\\Chrome\" /v \"MetricsReportingEnabled\" /t REG_SZ /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Google\\Chrome\" /v \"ChromeCleanupEnabled\" /t REG_SZ /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Google\\Chrome\" /v \"ChromeCleanupReportingEnabled\" /t REG_SZ /d 0 /f && reg add \"HKLM\\SOFTWARE\\Policies\\Google\\Chrome\" /v \"MetricsReportingEnabled\" /t REG_SZ /d 0 /f && cmd /c taskkill /f /im ccleaner.exe && cmd /c taskkill /f /im ccleaner64.exe && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"HomeScreen\" /t REG_SZ /d 2 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"Monitoring\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"HelpImproveCCleaner\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"SystemMonitoring\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"UpdateAuto\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"UpdateCheck\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"CheckTrialOffer\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"(Cfg)HealthCheck\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"(Cfg)QuickClean\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"(Cfg)QuickCleanIpm\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"(Cfg)SoftwareUpdater\" /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Piriform\\CCleaner\" /v \"(Cfg)SoftwareUpdaterIpm\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable PowerShell Telemetry":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C setx POWERSHELL_TELEMETRY_OPTOUT 1";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Skype Telemetry":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Tracing\\WPPMediaPerApp\\Skype\\ETW\" /v \"TraceLevelThreshold\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Tracing\\WPPMediaPerApp\\Skype\" /v \"EnableTracing\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Tracing\\WPPMediaPerApp\\Skype\\ETW\" /v \"EnableTracing\" /t REG_DWORD /d \"0\" /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Tracing\\WPPMediaPerApp\\Skype\" /v \"WPPFilePath\" /t REG_SZ /d \"%%SYSTEMDRIVE%%\\TEMP\\Tracing\\WPPMedia\" /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\Tracing\\WPPMediaPerApp\\Skype\\ETW\" /v \"WPPFilePath\" /t REG_SZ /d \"%%SYSTEMDRIVE%%\\TEMP\\WPPMedia\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Media Player Usage Reports":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\MediaPlayer\\Preferences\" /v \"UsageTracking\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Mozilla Telemetry":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add HKLM\\SOFTWARE\\Policies\\Mozilla\\Firefox /v \"DisableTelemetry\" /t REG_DWORD /d \"2\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Apps Use My Advertising ID":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AdvertisingInfo\" /v Enabled /t REG_DWORD /d 0 /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\CPSS\\Store\\AdvertisingInfo\" /v \"Value\" /t REG_DWORD /d \"0\" /f && reg add \"HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\CapabilityAccessManager\\ConsentStore\\appDiagnostics\" /v \"Value\" /t REG_SZ /d \"Deny\" /f && reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\CapabilityAccessManager\\ConsentStore\\appDiagnostics\" /v \"Value\" /t REG_SZ /d \"Deny\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Send Info About Writing":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Input\\TIPC\" /v Enabled /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Handwriting Recognition":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\InputPersonalization\" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f && reg add \"HKCU\\SOFTWARE\\Microsoft\\InputPersonalization\" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Watson Malware Reports":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Reporting\" /v \"DisableGenericReports\" /t REG_DWORD /d \"2\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Malware Diagnostic Data":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\MRT\" /v \"DontReportInfectionInformation\" /t REG_DWORD /d \"2\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Reporting to MS MAPS":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Spynet\" /v \"LocalSettingOverrideSpynetReporting\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Spynet Defender Reporting":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Spynet\" /v \"SpynetReporting\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Do Not Send Malware Samples":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Spynet\" /v \"SubmitSamplesConsent\" /t REG_DWORD /d \"2\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Sending Typing Samples":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Personalization\\Settings\" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Sending Contacts to MS":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\InputPersonalization\\TrainedDataStore\" /v HarvestContacts /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Cortana":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Windows Search\" /v \"AllowCortana\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
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
                    string caseSwitch = checkBox.Text;

                    switch (caseSwitch)
                    {
                        case "Show File Extensions in Explorer":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v \"HideFileExt\" /t  REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Transparency on Taskbar":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\Themes\\Personalize\" /v \"EnableTransparency\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v \"EnableTransparency\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Windows Animations":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\" /v VisualFXSetting  /t REG_DWORD /d 3 /f && REG ADD \"HKCU\\Control Panel\\Desktop\" /v UserPreferencesMask /t REG_BINARY /d 9012078010000000 /f && REG ADD \"HKCU\\Control Panel\\Desktop\\WindowMetrics\" /v MinAnimate /t REG_SZ /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\AnimateMinMax\" /v DefaultApplied  /t REG_DWORD /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\ComboBoxAnimation\" /v DefaultApplied  /t REG_DWORD /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\ControlAnimations\" /v DefaultApplied  /t REG_DWORD /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\MenuAnimation\" /v DefaultApplied  /t REG_DWORD /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\TaskbarAnimation\" /v DefaultApplied  /t REG_DWORD /d 0 /f && REG ADD \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\VisualEffects\\TooltipAnimation\" /v DefaultApplied  /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable MRU lists (jump lists)":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v \"Start_TrackDocs\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Set Search Box to Icon Only":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Search\" /v \"SearchboxTaskbarMode\" /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Explorer on Start on This PC":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v \"LaunchTo\" /t REG_DWORD /d 1 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
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
                    string caseSwitch = checkBox.Text;

                    switch (caseSwitch)
                    {
                        case "Split Threshold for Svchost":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb; Set-ItemProperty -Path 'HKLM:\\SYSTEM\\CurrentControlSet\\Control' -Name 'SvcHostSplitThresholdInKB' -Type DWord -Value $ram -Force ";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Windows Game Bar/DVR":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\GameDVR\" /v \"AppCaptureEnabled\" /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\System\\GameConfigStore\" /v \"GameDVR_Enabled\" /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage; Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage; Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Clean Temp/Cache/Prefetch/Logs":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del /q \"%temp%\\NVIDIA Corporation\\NV_Cache\\*\" && del /q \"%programdata%\\NVIDIA Corporation\\NV_Cache\\*\"";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del /s /f /q \"%userprofile%\\Recent\\*.*\"";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command erase /f /s /q \"%systemdrive%\\Windows\\SoftwareDistribution\\*.*\"";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C rmdir /s /q \"%systemdrive%\\Windows\\SoftwareDistribution\"";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %localappdata%\\Microsoft\\Windows\\WebCache /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %programdata%\\GOG.com\\Galaxy\\logs /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %programdata%\\GOG.com\\Galaxy\\webcache /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %appdata%\\Microsoft\\Teams\\Cache /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %localappdata%\\Yarn\\Cache /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSTelem.Out /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSTelem /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSRemoteControl /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSFeedbackVSRTCLogs /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSFeedbackPerfWatsonData /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\VSFaultInfo /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %Temp%\\Microsoft\\VSApplicationInsights /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %ProgramData%\\Microsoft\\VSApplicationInsights /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %LocalAppData%\\Microsoft\\VSApplicationInsights /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %AppData%\vstelemetry";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del /S /F /Q %windir%\\Prefetch";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C %WinDir%\\SysNative\\ie4uinit.exe -show";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C %WinDir%\\System32\\ie4uinit.exe -show";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del %LocalAppData%\\IconCache.db /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%LocalAppData%\\Microsoft\\Windows\\Explorer\\iconcache_*.db\" /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\catroot2\\*.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\catroot2\\*.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\catroot2\\.jrs\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\catroot2\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\catroot2\\*.chk\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\DISM\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\SleepStudy\\ScreenOn\\*.etl\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\SleepStudy\\*.etl\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\SysNative\\SleepStudy\\ScreenOn\\*.etl\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\SysNative\\SleepStudy\\*.etl\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\LogFiles\\HTTPERR\\*.*\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\WindowsBackup\\*.etl\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\CBS\\*.cab\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\CBS\\*.cab\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%SystemDrive%\\PerfLogs\\System\\Diagnostics\\*.*\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\debug\\WIA\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\inf\\setupapi.app.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\inf\\setupapi.offline.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net stop FontCache3.0.0.0";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net stop FontCache";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\ServiceProfiles\\LocalService\\AppData\\Local\\FontCache\\*.dat\" /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\SysNative\\FNTCACHE.DAT\" /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\System32\\FNTCACHE.DAT\" /F /Q /S";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net start FontCache";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C net start FontCache3.0.0.0";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Panther\\UnattendGC\\diagwrn.xml\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Panther\\UnattendGC\\diagerr.xml\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\repair\\setup.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Panther\\DDACLSys.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Panther\\cbs.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%LocalAppData%\\Microsoft\\Windows\\WebCache\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\ServiceProfiles\\NetworkService\\AppData\\Local\\Temp\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\DPX\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\system32\\wbem\\Logs\\*.lo_\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\system32\\wbem\\Logs\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\APPLOG\\*.*\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\*.log.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Logs\\DISM\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\setuplog.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\OEWABLog.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\system32\\wbem\\Logs\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\*.bak\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Debug\\UserMode\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Debug\\UserMode\\*.bak\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Debug\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\security\\logs\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\security\\logs\\*.old\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\SchedLgU.txt\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%WinDir%\\Directx.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C Del \"%SystemDrive%\\*.log\" /F /Q";
                            process.StartInfo = startInfo;
                            process.Start();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C start cleanmgr.exe /sagerun:5";
                            process.StartInfo = startInfo;
                            process.Start();
                            break;
                        case "Remove News and Interests/Widgets":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\Windows Feeds\" /v EnableFeeds /t REG_DWORD /d 0 /f && reg add \"HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced\" /v TaskbarDa /t REG_DWORD /d 0 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

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
                            break;
                        case "Scan for Adware (AdwCleaner)":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "powershell.exe";
                            startInfo.Arguments = "-Command wget https://downloads.malwarebytes.com/file/adwcleaner -o $Env:programdata\\adwcleaner.exe";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C start %programdata%\\adwcleaner.exe /eula /clean /noreboot";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C del %programdata%\\adwcleaner.exe";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Clean WinSxS Folder":
                            Console.WriteLine(checkBox.Text); done++;

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
                    string caseSwitch = checkBox.Text;

                    switch (caseSwitch)
                    {
                        case "Disable Windows Defender":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\MsSecFlt\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\SecurityHealthService\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\Sense\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\WdBoot\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\WdFilter\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\WdNisDrv\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\WdNisSvc\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\WinDefend\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"SecurityHealth\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\SgrmAgent\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\SgrmBroker\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\webthreatdefsvc\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SYSTEM\\ControlSet001\\Services\\webthreatdefusersvc\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C for /f %%i in ('reg query \"HKLM\\SYSTEM\\ControlSet001\\Services\" /s /k \"webthreatdefusersvc\" /f 2^>nul ^| find /i \"webthreatdefusersvc\" ') do (reg add \"%%i\" /v \"Start\" /t REG_DWORD /d \"4\" /f)\r\n";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Image File Execution Options\\smartscreen.exe\" /v \"Debugger\" /t REG_SZ /d \"%%windir%%\\System32\\taskkill.exe\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Associations\" /v \"DefaultFileTypeRisk\" /t REG_DWORD /d \"6152\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Attachments\" /v \"SaveZoneInformation\" /t REG_DWORD /d \"1\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Associations\" /v \"LowRiskFileTypes\" /t REG_SZ /d \".avi;.bat;.com;.cmd;.exe;.htm;.html;.lnk;.mpg;.mpeg;.mov;.mp3;.msi;.m3u;.rar;.reg;.txt;.vbs;.wav;.zip;\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Associations\" /v \"ModRiskFileTypes\" /t REG_SZ /d \".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\" /v \"SmartScreenEnabled\" /t REG_SZ /d \"Off\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Policies\\Microsoft\\Windows Defender\\SmartScreen\" /v \"ConfigureAppInstallControlEnabled\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Policies\\Microsoft\\Windows Defender\\SmartScreen\" /v \"ConfigureAppInstallControl\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Policies\\Microsoft\\Windows Defender\\SmartScreen\" /v \"EnableSmartScreen\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKCU\\Software\\Policies\\Microsoft\\MicrosoftEdge\\PhishingFilter\" /v \"EnabledV9\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\Software\\Policies\\Microsoft\\MicrosoftEdge\\PhishingFilter\" /v \"EnabledV9\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Control\\WMI\\Autologger\\DefenderApiLogger\" /v \"Start\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Control\\WMI\\Autologger\\DefenderAuditLogger\" /v \"Start\" /t REG_DWORD /d \"0\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

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

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\StartupApproved\\Run\" /v \"SecurityHealth\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run\" /v \"SecurityHealth\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKCR\\*\\shellex\\ContextMenuHandlers\\EPP\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKCR\\Directory\\shellex\\ContextMenuHandlers\\EPP\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg delete \"HKCR\\Drive\\shellex\\ContextMenuHandlers\\EPP\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Services\\WdFilter\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Services\\WdNisDrv\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Services\\WdNisSvc\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKLM\\System\\CurrentControlSet\\Services\\WinDefend\" /v \"Start\" /t REG_DWORD /d \"4\" /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Disable Spectre/Meltdown":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f && reg add \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Memory Management\" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Remove Microsoft OneDrive":
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C taskkill /F /IM OneDrive.exe";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();

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
                            Console.WriteLine(checkBox.Text); done++;

                            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                            startInfo.FileName = "cmd.exe";
                            startInfo.Arguments = "/C sc config XblAuthManager start= disabled && sc config XboxNetApiSvc start= disabled && sc config XblGameSave start= disabled";
                            process.StartInfo = startInfo;
                            process.Start(); process.WaitForExit();
                            break;
                        case "Enable Fast/Secure DNS (1.1.1.1)":
                            Console.WriteLine(checkBox.Text); done++;

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
                textBox1.Visible = false;
                Application.VisualStyleState = VisualStyleState.ClientAndNonClientAreasEnabled;
                DialogResult dialogResult = MessageBox.Show(msgerror, ETVersion, MessageBoxButtons.OK);
            }
            else
            {
                if (alltodo == done)
                {
                    progressBar1.Visible = false;
                    Application.VisualStyleState = VisualStyleState.ClientAndNonClientAreasEnabled;
                    DialogResult dialogResult = MessageBox.Show(msgend, ETVersion, MessageBoxButtons.OK);
                    this.Close();
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

        private void toolStripButton1_Click(object sender, EventArgs e)
        {
            // System.Diagnostics.Process.Start("CMD.EXE", "/K rstrui.exe");
            Process.Start(Path.Combine(Environment.SystemDirectory, "rstrui.exe"));
            //Process.Start("C:\\Windows\\System32\\rstrui.exe");

        }

        private void toolStripButton4_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start https://www.buymeacoffee.com/semazurek";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void toolStripButton2_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "powershell.exe";
            startInfo.Arguments = "-Command [console]::WindowWidth=80;[console]::WindowHeight=23;[console]::BufferWidth = [console]::WindowWidth; Enable-ComputerRestore -Drive $env:systemdrive; Checkpoint-Computer -Description \"ET-RestorePoint\" -RestorePointType \"MODIFY_SETTINGS\"";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void diskDefragmenterToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start dfrgui.exe";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void cleanmgrToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start cleanmgr.exe";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void msconfigToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start msconfig";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void controlPanelToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start control";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void deviceManagerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start devmgmt.msc";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void uACSettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start UserAccountControlSettings.exe";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void msinfo32ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start msinfo32";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void servicesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start services.msc";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void remoteDesktopToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start mstsc";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void eventViewerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start eventvwr.msc";
            process.StartInfo = startInfo;
            process.Start();
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
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C shutdown /r /fw /t 1";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void windowsLicenseKeyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Normal;
            startInfo.FileName = "powershell.exe";
            startInfo.Arguments = "-Command [console]::WindowWidth=80;[console]::WindowHeight=23;[console]::BufferWidth = [console]::WindowWidth; (Get-WmiObject –query 'select * from SoftwareLicensingService').OA3xOriginalProductKey ;pause";
            process.StartInfo = startInfo;
            process.Start();
        }

        private void toolStripButton3_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C start https://github.com/semazurek/ET-Optimizer";
            process.StartInfo = startInfo;
            process.Start();
        }

        public static string GetUsedRAM()
        {
            PerformanceCounter RAMCounter;
            RAMCounter = new PerformanceCounter();
            RAMCounter.CategoryName = "Memory";
            RAMCounter.CounterName = "% Committed Bytes In Use";
            return String.Format("{0:0.00}", RAMCounter.NextValue());
        }


        public static string GetUsedCPU()
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

        private async void timer1_Tick(object sender, EventArgs e)
        {
            await Task.Run(() =>
            {
                toolStripLabel1.Text = "CPU: " + GetUsedCPU() + " %";
            });
            await Task.Run(() =>
            {
                string RAMs = GetUsedRAM();
                float flRAM = float.Parse(RAMs);
                

                toolStripLabel2.Text = "RAM: " + (int)flRAM + " %";
            });
            await Task.Run(() =>
            {
                PowerStatus pwr = SystemInformation.PowerStatus;
                String strBatteryStatus;
                strBatteryStatus = pwr.BatteryLifePercent.ToString();
                char[] MyCharCut = { ',', '.', ' ' };
                string strBattery = strBatteryStatus.TrimStart(MyCharCut);
                // 0,95 - 95

                float flBattery = float.Parse(strBattery);
                flBattery = flBattery * 100;
                toolStripLabel3.Text = "Battery: " + flBattery + " % ";

            });
            toolStripLabel2.Visible = true;
            toolStripLabel3.Visible = true;

        }

        private void panelmain_MouseMove(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void panelmain_MouseUp(object sender, MouseEventArgs e)
        {
            
        }

        private void label1_MouseMove_1(object sender, MouseEventArgs e)
        {
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
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
            // Check if the left mouse button was pressed
            if (e.Button == MouseButtons.Left)
            {
                // Release the mouse capture and send the message to start dragging
                ReleaseCapture();
                SendMessage(this.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            }
        }

        private void rebootToSafeModeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C bcdedit /set {current} safeboot network";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();
            //Open the registry key for startup programs, create a registry key, then save your program path
            RegistryKey reg = Registry.CurrentUser.OpenSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\RunOnce", true);
            // Specify the name and path of your application executable, add the application to the startup
            reg.SetValue("ET-Optimizer", Application.ExecutablePath.ToString());

            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/C shutdown /r /t 5";
            process.StartInfo = startInfo;
            process.Start(); process.WaitForExit();
            this.Close();
        }
    }
}
