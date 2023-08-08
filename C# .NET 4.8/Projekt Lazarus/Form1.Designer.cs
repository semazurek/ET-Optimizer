using System;
using System.Drawing;
using System.Windows.Forms;

namespace Projekt_Lazarus
{
    partial class Form
    {
        /// <summary>
        /// Wymagana zmienna projektanta.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Wyczyść wszystkie używane zasoby.
        /// </summary>
        /// <param name="disposing">prawda, jeżeli zarządzane zasoby powinny zostać zlikwidowane; Fałsz w przeciwnym wypadku.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Kod generowany przez Projektanta formularzy systemu Windows

        /// <summary>
        /// Metoda wymagana do obsługi projektanta — nie należy modyfikować
        /// jej zawartości w edytorze kodu.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form));
            this.B_close = new System.Windows.Forms.Button();
            this.B_checkall = new System.Windows.Forms.Button();
            this.B_uncheckall = new System.Windows.Forms.Button();
            this.B_performanceall = new System.Windows.Forms.Button();
            this.B_visualall = new System.Windows.Forms.Button();
            this.B_privacyall = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.chck1 = new System.Windows.Forms.CheckBox();
            this.chck2 = new System.Windows.Forms.CheckBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.panel3 = new System.Windows.Forms.Panel();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.panel4 = new System.Windows.Forms.Panel();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.panel5 = new System.Windows.Forms.Panel();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.backupToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.restoreToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.extrasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.diskDefragmenterToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cleanmgrToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.msconfigToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.controlPanelToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.deviceManagerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.uACSettingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.msinfo32ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.servicesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.remoteDesktopToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.eventViewerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.resetNetworkToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.updateApplicationsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.windowsLicenseKeyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.resetToBIOSToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.donateToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.eToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.groupBox1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // B_close
            // 
            this.B_close.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_close.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_close.Location = new System.Drawing.Point(660, 400);
            this.B_close.Name = "B_close";
            this.B_close.Size = new System.Drawing.Size(120, 50);
            this.B_close.TabIndex = 0;
            this.B_close.Text = "Start";
            // 
            // B_checkall
            // 
            this.B_checkall.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_checkall.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_checkall.Location = new System.Drawing.Point(510, 400);
            this.B_checkall.Name = "B_checkall";
            this.B_checkall.Size = new System.Drawing.Size(140, 50);
            this.B_checkall.TabIndex = 1;
            this.B_checkall.Text = "Select All";
            // 
            // B_uncheckall
            // 
            this.B_uncheckall.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_uncheckall.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_uncheckall.Location = new System.Drawing.Point(510, 400);
            this.B_uncheckall.Name = "B_uncheckall";
            this.B_uncheckall.Size = new System.Drawing.Size(140, 50);
            this.B_uncheckall.TabIndex = 2;
            this.B_uncheckall.Text = "Select All";
            this.B_uncheckall.Visible = false;
            // 
            // B_performanceall
            // 
            this.B_performanceall.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_performanceall.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_performanceall.Location = new System.Drawing.Point(110, 400);
            this.B_performanceall.Name = "B_performanceall";
            this.B_performanceall.Size = new System.Drawing.Size(130, 50);
            this.B_performanceall.TabIndex = 3;
            this.B_performanceall.Text = "Performance";
            // 
            // B_visualall
            // 
            this.B_visualall.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_visualall.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_visualall.Location = new System.Drawing.Point(250, 400);
            this.B_visualall.Name = "B_visualall";
            this.B_visualall.Size = new System.Drawing.Size(120, 50);
            this.B_visualall.TabIndex = 4;
            this.B_visualall.Text = "Visual";
            // 
            // B_privacyall
            // 
            this.B_privacyall.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.B_privacyall.Font = new System.Drawing.Font("Consolas", 13F);
            this.B_privacyall.Location = new System.Drawing.Point(380, 400);
            this.B_privacyall.Name = "B_privacyall";
            this.B_privacyall.Size = new System.Drawing.Size(120, 50);
            this.B_privacyall.TabIndex = 5;
            this.B_privacyall.Text = "Privacy";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox1.Font = new System.Drawing.Font("Consolas", 11F, System.Drawing.FontStyle.Bold);
            this.groupBox1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.groupBox1.Location = new System.Drawing.Point(10, 30);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(570, 180);
            this.groupBox1.TabIndex = 6;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Performance Tweaks (34)";
            // 
            // panel1
            // 
            this.panel1.AutoScroll = true;
            this.panel1.Controls.Add(this.chck1);
            this.panel1.Controls.Add(this.chck2);
            this.panel1.Location = new System.Drawing.Point(10, 20);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(564, 152);
            this.panel1.TabIndex = 0;
            // 
            // chck1
            // 
            this.chck1.Checked = true;
            this.chck1.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chck1.Font = new System.Drawing.Font("Consolas", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.chck1.Location = new System.Drawing.Point(0, 5);
            this.chck1.Name = "chck1";
            this.chck1.Size = new System.Drawing.Size(270, 25);
            this.chck1.TabIndex = 0;
            this.chck1.Text = "Disable Edge WebWidget";
            // 
            // chck2
            // 
            this.chck2.Checked = true;
            this.chck2.CheckState = System.Windows.Forms.CheckState.Checked;
            this.chck2.Font = new System.Drawing.Font("Consolas", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.chck2.Location = new System.Drawing.Point(0, 30);
            this.chck2.Name = "chck2";
            this.chck2.Size = new System.Drawing.Size(270, 25);
            this.chck2.TabIndex = 1;
            this.chck2.Text = "Power Option to Ultimate Performance";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.panel2);
            this.groupBox2.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox2.Font = new System.Drawing.Font("Consolas", 11F, System.Drawing.FontStyle.Bold);
            this.groupBox2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.groupBox2.Location = new System.Drawing.Point(585, 30);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(285, 180);
            this.groupBox2.TabIndex = 7;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Privacy (17)";
            // 
            // panel2
            // 
            this.panel2.AutoScroll = true;
            this.panel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2.Location = new System.Drawing.Point(3, 25);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(279, 152);
            this.panel2.TabIndex = 0;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.panel3);
            this.groupBox3.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox3.Font = new System.Drawing.Font("Consolas", 11F, System.Drawing.FontStyle.Bold);
            this.groupBox3.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.groupBox3.Location = new System.Drawing.Point(10, 210);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(285, 180);
            this.groupBox3.TabIndex = 8;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Visual Tweaks (6)";
            // 
            // panel3
            // 
            this.panel3.AutoScroll = true;
            this.panel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel3.Location = new System.Drawing.Point(3, 25);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(279, 152);
            this.panel3.TabIndex = 0;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.panel4);
            this.groupBox4.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox4.Font = new System.Drawing.Font("Consolas", 11F, System.Drawing.FontStyle.Bold);
            this.groupBox4.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.groupBox4.Location = new System.Drawing.Point(302, 210);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(278, 180);
            this.groupBox4.TabIndex = 9;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Other (6)";
            // 
            // panel4
            // 
            this.panel4.AutoScroll = true;
            this.panel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel4.Location = new System.Drawing.Point(3, 25);
            this.panel4.Name = "panel4";
            this.panel4.Size = new System.Drawing.Size(272, 152);
            this.panel4.TabIndex = 0;
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.panel5);
            this.groupBox5.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.groupBox5.Font = new System.Drawing.Font("Consolas", 11F, System.Drawing.FontStyle.Bold);
            this.groupBox5.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.groupBox5.Location = new System.Drawing.Point(585, 210);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(285, 180);
            this.groupBox5.TabIndex = 10;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Expert Mode (4)";
            // 
            // panel5
            // 
            this.panel5.AutoScroll = true;
            this.panel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel5.Location = new System.Drawing.Point(3, 25);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(279, 152);
            this.panel5.TabIndex = 0;
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(50)))), ((int)(((byte)(50)))), ((int)(((byte)(50)))));
            this.menuStrip1.Font = new System.Drawing.Font("Segoe UI", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.menuStrip1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.menuStrip1.ImageScalingSize = new System.Drawing.Size(20, 20);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.backupToolStripMenuItem,
            this.restoreToolStripMenuItem,
            this.extrasToolStripMenuItem,
            this.aboutToolStripMenuItem,
            this.donateToolStripMenuItem,
            this.eToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(879, 28);
            this.menuStrip1.TabIndex = 11;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // backupToolStripMenuItem
            // 
            this.backupToolStripMenuItem.Name = "backupToolStripMenuItem";
            this.backupToolStripMenuItem.Size = new System.Drawing.Size(71, 24);
            this.backupToolStripMenuItem.Text = "Backup";
            // 
            // restoreToolStripMenuItem
            // 
            this.restoreToolStripMenuItem.Name = "restoreToolStripMenuItem";
            this.restoreToolStripMenuItem.Size = new System.Drawing.Size(73, 24);
            this.restoreToolStripMenuItem.Text = "Restore";
            // 
            // extrasToolStripMenuItem
            // 
            this.extrasToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.diskDefragmenterToolStripMenuItem,
            this.cleanmgrToolStripMenuItem,
            this.msconfigToolStripMenuItem,
            this.controlPanelToolStripMenuItem,
            this.deviceManagerToolStripMenuItem,
            this.uACSettingsToolStripMenuItem,
            this.msinfo32ToolStripMenuItem,
            this.servicesToolStripMenuItem,
            this.remoteDesktopToolStripMenuItem,
            this.eventViewerToolStripMenuItem,
            this.resetNetworkToolStripMenuItem,
            this.updateApplicationsToolStripMenuItem,
            this.windowsLicenseKeyToolStripMenuItem,
            this.resetToBIOSToolStripMenuItem});
            this.extrasToolStripMenuItem.Name = "extrasToolStripMenuItem";
            this.extrasToolStripMenuItem.Size = new System.Drawing.Size(62, 24);
            this.extrasToolStripMenuItem.Text = "Extras";
            // 
            // diskDefragmenterToolStripMenuItem
            // 
            this.diskDefragmenterToolStripMenuItem.Name = "diskDefragmenterToolStripMenuItem";
            this.diskDefragmenterToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.diskDefragmenterToolStripMenuItem.Text = "Disk Defragmenter";
            // 
            // cleanmgrToolStripMenuItem
            // 
            this.cleanmgrToolStripMenuItem.Name = "cleanmgrToolStripMenuItem";
            this.cleanmgrToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.cleanmgrToolStripMenuItem.Text = "Cleanmgr";
            // 
            // msconfigToolStripMenuItem
            // 
            this.msconfigToolStripMenuItem.Name = "msconfigToolStripMenuItem";
            this.msconfigToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.msconfigToolStripMenuItem.Text = "Msconfig";
            // 
            // controlPanelToolStripMenuItem
            // 
            this.controlPanelToolStripMenuItem.Name = "controlPanelToolStripMenuItem";
            this.controlPanelToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.controlPanelToolStripMenuItem.Text = "Control Panel";
            // 
            // deviceManagerToolStripMenuItem
            // 
            this.deviceManagerToolStripMenuItem.Name = "deviceManagerToolStripMenuItem";
            this.deviceManagerToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.deviceManagerToolStripMenuItem.Text = "Device Manager";
            // 
            // uACSettingsToolStripMenuItem
            // 
            this.uACSettingsToolStripMenuItem.Name = "uACSettingsToolStripMenuItem";
            this.uACSettingsToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.uACSettingsToolStripMenuItem.Text = "UAC Settings";
            // 
            // msinfo32ToolStripMenuItem
            // 
            this.msinfo32ToolStripMenuItem.Name = "msinfo32ToolStripMenuItem";
            this.msinfo32ToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.msinfo32ToolStripMenuItem.Text = "Msinfo32";
            // 
            // servicesToolStripMenuItem
            // 
            this.servicesToolStripMenuItem.Name = "servicesToolStripMenuItem";
            this.servicesToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.servicesToolStripMenuItem.Text = "Services";
            // 
            // remoteDesktopToolStripMenuItem
            // 
            this.remoteDesktopToolStripMenuItem.Name = "remoteDesktopToolStripMenuItem";
            this.remoteDesktopToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.remoteDesktopToolStripMenuItem.Text = "Remote Desktop";
            // 
            // eventViewerToolStripMenuItem
            // 
            this.eventViewerToolStripMenuItem.Name = "eventViewerToolStripMenuItem";
            this.eventViewerToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.eventViewerToolStripMenuItem.Text = "Event Viewer";
            // 
            // resetNetworkToolStripMenuItem
            // 
            this.resetNetworkToolStripMenuItem.Name = "resetNetworkToolStripMenuItem";
            this.resetNetworkToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.resetNetworkToolStripMenuItem.Text = "Reset Network";
            // 
            // updateApplicationsToolStripMenuItem
            // 
            this.updateApplicationsToolStripMenuItem.Name = "updateApplicationsToolStripMenuItem";
            this.updateApplicationsToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.updateApplicationsToolStripMenuItem.Text = "Update Applications";
            // 
            // windowsLicenseKeyToolStripMenuItem
            // 
            this.windowsLicenseKeyToolStripMenuItem.Name = "windowsLicenseKeyToolStripMenuItem";
            this.windowsLicenseKeyToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.windowsLicenseKeyToolStripMenuItem.Text = "Windows License Key";
            // 
            // resetToBIOSToolStripMenuItem
            // 
            this.resetToBIOSToolStripMenuItem.Name = "resetToBIOSToolStripMenuItem";
            this.resetToBIOSToolStripMenuItem.Size = new System.Drawing.Size(233, 26);
            this.resetToBIOSToolStripMenuItem.Text = "Reset to BIOS";
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(64, 24);
            this.aboutToolStripMenuItem.Text = "About";
            // 
            // donateToolStripMenuItem
            // 
            this.donateToolStripMenuItem.Name = "donateToolStripMenuItem";
            this.donateToolStripMenuItem.Size = new System.Drawing.Size(72, 24);
            this.donateToolStripMenuItem.Text = "Donate";
            this.donateToolStripMenuItem.Click += new System.EventHandler(this.donateToolStripMenuItem_Click);
            // 
            // eToolStripMenuItem
            // 
            this.eToolStripMenuItem.Name = "eToolStripMenuItem";
            this.eToolStripMenuItem.Size = new System.Drawing.Size(47, 24);
            this.eToolStripMenuItem.Text = "Exit";
            this.eToolStripMenuItem.Click += new System.EventHandler(this.eToolStripMenuItem_Click);
            // 
            // Form
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(37)))), ((int)(((byte)(37)))), ((int)(((byte)(37)))));
            this.ClientSize = new System.Drawing.Size(879, 461);
            this.Controls.Add(this.B_close);
            this.Controls.Add(this.B_checkall);
            this.Controls.Add(this.B_uncheckall);
            this.Controls.Add(this.B_performanceall);
            this.Controls.Add(this.B_visualall);
            this.Controls.Add(this.B_privacyall);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.menuStrip1);
            this.Font = new System.Drawing.Font("Consolas", 9F);
            this.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(238)))), ((int)(((byte)(238)))));
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.Margin = new System.Windows.Forms.Padding(2);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "E.T. ver 5.3";
            this.Load += new System.EventHandler(this.Form_Load);
            this.groupBox1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox5.ResumeLayout(false);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Button B_close;
        private Button B_checkall;
        private Button B_uncheckall;
        private Button B_performanceall;
        private Button B_visualall;
        private Button B_privacyall;
        private GroupBox groupBox1;
        private Panel panel1;
        private GroupBox groupBox2;
        private Panel panel2;
        private GroupBox groupBox3;
        private Panel panel3;
        private GroupBox groupBox4;
        private Panel panel4;
        private GroupBox groupBox5;
        private Panel panel5;
        private MenuStrip menuStrip1;
        private ToolStripMenuItem backupToolStripMenuItem;
        private ToolStripMenuItem restoreToolStripMenuItem;
        private ToolStripMenuItem extrasToolStripMenuItem;
        private ToolStripMenuItem aboutToolStripMenuItem;
        private ToolStripMenuItem donateToolStripMenuItem;
        private ToolStripMenuItem eToolStripMenuItem;
        private ToolStripMenuItem diskDefragmenterToolStripMenuItem;
        private ToolStripMenuItem cleanmgrToolStripMenuItem;
        private ToolStripMenuItem msconfigToolStripMenuItem;
        private ToolStripMenuItem controlPanelToolStripMenuItem;
        private ToolStripMenuItem deviceManagerToolStripMenuItem;
        private ToolStripMenuItem uACSettingsToolStripMenuItem;
        private ToolStripMenuItem msinfo32ToolStripMenuItem;
        private ToolStripMenuItem servicesToolStripMenuItem;
        private ToolStripMenuItem remoteDesktopToolStripMenuItem;
        private ToolStripMenuItem eventViewerToolStripMenuItem;
        private ToolStripMenuItem resetNetworkToolStripMenuItem;
        private ToolStripMenuItem updateApplicationsToolStripMenuItem;
        private ToolStripMenuItem windowsLicenseKeyToolStripMenuItem;
        private ToolStripMenuItem resetToBIOSToolStripMenuItem;
        private CheckBox chck1;
        private CheckBox chck2;
    }
}

