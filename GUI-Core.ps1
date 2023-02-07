$versionPS=$args[0]+' '+$args[1]+' '+$args[2];
[reflection.assembly]::LoadWithPartialName( 'System.Windows.Forms'); 
[reflection.assembly]::loadwithpartialname('System.Drawing'); 
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
function count_p {
$c_p = 0;
Foreach ($control in $groupBox1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_p++}
   }
If ($c_p -eq 34) { $groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db'); $B_performanceall.Visible = $false; $B_performanceoff.Visible = $true; }
Else { $groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee'); $B_performanceall.Visible = $true; $B_performanceoff.Visible = $false; }
}
function count_v {
$c_v = 0;
Foreach ($control in $groupBox3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_v++}
   }
If ($c_v -eq 6) { $groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db'); $B_visualoff.Visible = $true; $B_visualall.Visible = $false; }
Else { $groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee'); $B_visualoff.Visible = $false; $B_visualall.Visible = $true; }
}
function count_s {
$c_s = 0;
Foreach ($control in $groupBox2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){$c_s++}
   }
If ($c_s -eq 17) { $groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db'); $B_privacyoff.Visible = $true; $B_privacyall.Visible = $false; }
Else { $groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee'); $B_privacyoff.Visible = $false; $B_privacyall.Visible = $true; }
}
function do_start { 
Foreach ($control in $groupBox1.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $groupBox2.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $groupBox3.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
Foreach ($control in $groupBox4.Controls){
	$tempval = $control.TabIndex+1;
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.checked -eq 1){ echo True > $Env:programdata\ET\chck$tempval.lbool}
   }
$form.close()
}; 
$form= New-Object Windows.Forms.Form; 
$form.Size = New-Object System.Drawing.Size(895,780); 
$form.StartPosition = 'CenterScreen'; 
$form.FormBorderStyle = 'FixedDialog'; 
$form.Text = $versionPS; 
$form.AutoSizeMode = 'GrowAndShrink'; 
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$form.MinimizeBox = $false; 
$form.MaximizeBox = $false; 
$Font = New-Object System.Drawing.Font('Consolas',9,[System.Drawing.FontStyle]::Regular); 
$form.FlatStyle = 'Flat'
$form.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$form.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.Font = $Font; 
$B_close = New-Object Windows.Forms.Button; 
$B_close.text = 'Start'; 
$B_close.FlatStyle = 'Flat'
$B_close.Location = New-Object Drawing.Point 660,675; 
$B_close.Size = New-Object Drawing.Point 120,50;
$B_close.FlatStyle = 'Flat'
$B_close.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_close.add_click({do_start}); $form.controls.add($B_close); 
$B_checkall = New-Object Windows.Forms.Button; 
$B_checkall.text = 'Select All'; 
$B_checkall.Location = New-Object Drawing.Point 510,675; 
$B_checkall.Size = New-Object Drawing.Point 140,50;
$B_checkall.FlatStyle = 'Flat'
$B_checkall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_checkall.add_click({
Foreach ($control in $groupBox1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $groupBox2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $groupBox3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
Foreach ($control in $groupBox4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox" -and $control.TabIndex -ne 60 -and $control.TabIndex -ne 61 -and $control.TabIndex -ne 59 -and $control.TabIndex -ne 65 -and $control.TabIndex -ne 2 -and $control.TabIndex -ne 66){
           $control.checked = $true
       }
   }
$B_checkall.Visible = $false;
$B_uncheckall.Visible = $true;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
}); 
$form.controls.add($B_checkall);
$B_uncheckall = New-Object Windows.Forms.Button; 
$B_uncheckall.text = 'Unselect All'; 
$B_uncheckall.Location = New-Object Drawing.Point 510,675; 
$B_uncheckall.Size = New-Object Drawing.Point 140,50;
$B_uncheckall.FlatStyle = 'Flat'
$B_uncheckall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_uncheckall.add_click({
Foreach ($control in $groupBox1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $groupBox2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $groupBox3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
Foreach ($control in $groupBox4.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_checkall.Visible = $true;
$B_uncheckall.Visible = $false;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_p;
count_v;
count_s;
}); 
$form.controls.add($B_uncheckall);
$B_performanceall = New-Object Windows.Forms.Button; 
$B_performanceall.text = 'Performance'; 
$B_performanceall.Location = New-Object Drawing.Point 110,675; 
$B_performanceall.Size = New-Object Drawing.Point 130,50;
$B_performanceall.FlatStyle = 'Flat'
$B_performanceall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_performanceall.add_click({
Foreach ($control in $groupBox1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
count_p;
$B_performanceoff.Visible = $true;
$B_performanceall.Visible = $false;
}); 
$form.controls.add($B_performanceall); 
$B_performanceoff = New-Object Windows.Forms.Button; 
$B_performanceoff.text = 'Performance'; 
$B_performanceoff.Location = New-Object Drawing.Point 110,675; 
$B_performanceoff.Size = New-Object Drawing.Point 130,50;
$B_performanceoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db');
$B_performanceoff.FlatStyle = 'Flat'
$B_performanceoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_performanceoff.add_click({
Foreach ($control in $groupBox1.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
count_p;
$B_performanceoff.Visible = $false;
$B_performanceall.Visible = $true;
}); 
$form.controls.add($B_performanceoff); 
$B_visualall = New-Object Windows.Forms.Button; 
$B_visualall.text = 'Visual'; 
$B_visualall.Location = New-Object Drawing.Point 250,675; 
$B_visualall.Size = New-Object Drawing.Point 120,50;
$B_visualall.FlatStyle = 'Flat'
$B_visualall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_visualall.add_click({
Foreach ($control in $groupBox3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_visualoff.Visible = $true;
$B_visualall.Visible = $false;
count_v;
}); 
$form.controls.add($B_visualall); 
$B_visualoff = New-Object Windows.Forms.Button; 
$B_visualoff.text = 'Visual'; 
$B_visualoff.Location = New-Object Drawing.Point 250,675; 
$B_visualoff.Size = New-Object Drawing.Point 120,50;
$B_visualoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db');
$B_visualoff.FlatStyle = 'Flat'
$B_visualoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_visualoff.add_click({
Foreach ($control in $groupBox3.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_visualoff.Visible = $false;
$B_visualall.Visible = $true;
count_v;
}); 
$form.controls.add($B_visualoff); 
$B_privacyall = New-Object Windows.Forms.Button; 
$B_privacyall.text = 'Privacy'; 
$B_privacyall.Location = New-Object Drawing.Point 380,675; 
$B_privacyall.Size = New-Object Drawing.Point 120,50;
$B_privacyall.FlatStyle = 'Flat'
$B_privacyall.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_privacyall.add_click({
Foreach ($control in $groupBox2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $true
       }
   }
$B_privacyoff.Visible = $true;
$B_privacyall.Visible = $false;
count_s;
}); 
$form.controls.add($B_privacyall); 
$B_privacyoff = New-Object Windows.Forms.Button; 
$B_privacyoff.text = 'Privacy'; 
$B_privacyoff.Location = New-Object Drawing.Point 380,675; 
$B_privacyoff.Size = New-Object Drawing.Point 120,50;
$B_privacyoff.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#3498db');
$B_privacyoff.FlatStyle = 'Flat'
$B_privacyoff.Font = New-Object System.Drawing.Font('Consolas',13,[System.Drawing.FontStyle]::Regular);
$B_privacyoff.add_click({
Foreach ($control in $groupBox2.Controls){
       $objectType = $control.GetType().Name
       If ($objectType -like "CheckBox"){
           $control.checked = $false
       }
   }
$B_privacyoff.Visible = $false;
$B_privacyall.Visible = $true;
count_s;
}); 
$form.controls.add($B_privacyoff);
$B_uncheckall.Visible = $false;
$B_performanceall.Visible = $false;
$B_visualall.Visible = $false;
$B_privacyall.Visible = $false;
count_p;
count_v;
count_s;
$groupBox1 = New-Object System.Windows.Forms.GroupBox
$groupBox1.Location = '10,30' 
$groupBox1.size = '570,455'
$groupBox1.text = 'Performance Tweaks'
$groupBox1.Visible = $true
$groupBox1.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox1.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.controls.Add($groupBox1) 
$groupBox1.add_click({count_p})
$groupBox2 = New-Object System.Windows.Forms.GroupBox
$groupBox2.Location = '585,30' 
$groupBox2.size = '285,455'
$groupBox2.text = 'Privacy'
$groupBox2.Visible = $true
$groupBox2.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox2.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.Controls.Add($groupBox2) 
$groupBox2.add_click({count_s})
$groupBox3 = New-Object System.Windows.Forms.GroupBox
$groupBox3.Location = '10,485' 
$groupBox3.size = '285,180'
$groupBox3.text = 'Visual Tweaks'
$groupBox3.Visible = $true
$groupBox3.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.Controls.Add($groupBox3) 
$groupBox3.add_click({count_v})
$groupBox4 = New-Object System.Windows.Forms.GroupBox
$groupBox4.Location = '302,485' 
$groupBox4.size = '568,180'
$groupBox4.text = 'Other'
$groupBox4.Visible = $true
$groupBox4.Font = New-Object System.Drawing.Font('Consolas',11,[System.Drawing.FontStyle]::Bold); 
$groupBox4.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$form.Controls.Add($groupBox4) 
$chck1 = New-Object Windows.Forms.Checkbox; 
$chck1.Location = New-Object Drawing.Point 10,25; 
$chck1.Size = New-Object Drawing.Point 270,25; 
$chck1.Text = 'Disable Edge WebWidget'; 
$chck1.TabIndex = 0;
$chck1.Checked = $true; 
$chck1.Font = $Font; 
$groupBox1.controls.add($chck1); 
$chck1.add_click({count_p})
$chck2 = New-Object Windows.Forms.Checkbox; 
$chck2.Location = New-Object Drawing.Point 10,50; 
$chck2.Size = New-Object Drawing.Point 270,25; 
$chck2.Text = 'Power Option to Ultimate Performance'; 
$chck2.TabIndex = 1; 
$chck2.Checked = $true; 
$chck2.Font = $Font;
$groupBox1.controls.add($chck2); 
$chck2.add_MouseHover({
$tooltip2 = New-Object System.Windows.Forms.ToolTip
$tooltip2.SetToolTip($chck2, 'Setting power option to high/ultimate for best CPU performance')
})
$chck2.add_click({count_p})
$chck4 = New-Object Windows.Forms.Checkbox; 
$chck4.Location = New-Object Drawing.Point 10,75; 
$chck4.Size = New-Object Drawing.Point 270,25; 
$chck4.Text = 'Dual Boot Timeout 3sec'; 
$chck4.TabIndex = 3; 
$chck4.Checked = $true; 
$chck4.Font = $Font;
$groupBox1.controls.add($chck4); 
$chck4.add_click({count_p})
$chck5 = New-Object Windows.Forms.Checkbox; 
$chck5.Location = New-Object Drawing.Point 10,100; 
$chck5.Size = New-Object Drawing.Point 270,25; 
$chck5.Text = 'Disable Hibernation/Fast Startup'; 
$chck5.TabIndex = 4; 
$chck5.Checked = $true; 
$chck5.Font = $Font;
$groupBox1.controls.add($chck5); 
$chck5.add_MouseHover({
$tooltip5 = New-Object System.Windows.Forms.ToolTip
$tooltip5.SetToolTip($chck5, 'Disable Hibernation/Fast startup in Windows to free RAM from hiberfil.sys')
})
$chck5.add_click({count_p})
$chck6 = New-Object Windows.Forms.Checkbox; 
$chck6.Location = New-Object Drawing.Point 10,125; 
$chck6.Size = New-Object Drawing.Point 280,25; 
$chck6.Text = 'Disable Windows Insider Experiments'; 
$chck6.TabIndex = 5; 
$chck6.Checked = $true; 
$chck6.Font = $Font;
$groupBox1.controls.add($chck6); 
$chck6.add_click({count_p})
$chck7 = New-Object Windows.Forms.Checkbox; 
$chck7.Location = New-Object Drawing.Point 10,150; 
$chck7.Size = New-Object Drawing.Point 270,25; 
$chck7.Text = 'Disable App Launch Tracking'; 
$chck7.TabIndex = 6; 
$chck7.Checked = $true; 
$chck7.Font = $Font;
$groupBox1.controls.add($chck7); 
$chck7.add_click({count_p})
$chck8 = New-Object Windows.Forms.Checkbox; 
$chck8.Location = New-Object Drawing.Point 10,175; 
$chck8.Size = New-Object Drawing.Point 275,25; 
$chck8.Text = 'Disable Powerthrottling (Intel 6gen+)'; 
$chck8.TabIndex = 7; 
$chck8.Checked = $true; 
$chck8.Font = $Font;
$groupBox1.controls.add($chck8); 
$chck8.add_click({count_p})
$chck9 = New-Object Windows.Forms.Checkbox; 
$chck9.Location = New-Object Drawing.Point 10,200; 
$chck9.Size = New-Object Drawing.Point 275,25; 
$chck9.Text = 'Turn Off Background Apps'; 
$chck9.TabIndex = 8; 
$chck9.Checked = $true; 
$chck9.Font = $Font;
$groupBox1.controls.add($chck9); 
$chck9.add_click({count_p})
$chck10 = New-Object Windows.Forms.Checkbox; 
$chck10.Location = New-Object Drawing.Point 10,225; 
$chck10.Size = New-Object Drawing.Point 270,25; 
$chck10.Text = 'Disable Sticky Keys Prompt'; 
$chck10.TabIndex = 9; 
$chck10.Checked = $true; 
$chck10.Font = $Font;
$groupBox1.controls.add($chck10); 
$chck10.add_click({count_p})
$chck11 = New-Object Windows.Forms.Checkbox; 
$chck11.Location = New-Object Drawing.Point 10,250; 
$chck11.Size = New-Object Drawing.Point 270,25; 
$chck11.Text = 'Disable Activity History'; 
$chck11.TabIndex = 10; 
$chck11.Checked = $true; 
$chck11.Font = $Font;
$groupBox1.controls.add($chck11); 
$chck11.add_click({count_p})
$chck12 = New-Object Windows.Forms.Checkbox; 
$chck12.Location = New-Object Drawing.Point 10,275; 
$chck12.Size = New-Object Drawing.Point 280,25; 
$chck12.Text = 'Disable Updates for MS Store Apps'; 
$chck12.TabIndex = 11; 
$chck12.Checked = $true; 
$chck12.Font = $Font;
$groupBox1.controls.add($chck12); 
$chck12.add_MouseHover({
$tooltip12 = New-Object System.Windows.Forms.ToolTip
$tooltip12.SetToolTip($chck12, 'Disable Automatic Updates for Microsoft Store apps')
})
$chck12.add_click({count_p})
$chck13 = New-Object Windows.Forms.Checkbox; 
$chck13.Location = New-Object Drawing.Point 10,300; 
$chck13.Size = New-Object Drawing.Point 270,25; 
$chck13.Text = 'SmartScreen Filter for Apps: Disable'; 
$chck13.TabIndex = 12; 
$chck13.Checked = $true; 
$chck13.Font = $Font;
$groupBox1.controls.add($chck13); 
$chck13.add_click({count_p})
$chck14 = New-Object Windows.Forms.Checkbox; 
$chck14.Location = New-Object Drawing.Point 10,325; 
$chck14.Size = New-Object Drawing.Point 270,25; 
$chck14.Text = 'Let Websites Provide Locally'; 
$chck14.TabIndex = 13; 
$chck14.Checked = $true; 
$chck14.Font = $Font;
$groupBox1.controls.add($chck14); 
$chck14.add_click({count_p})
$chck15 = New-Object Windows.Forms.Checkbox; 
$chck15.Location = New-Object Drawing.Point 10,350; 
$chck15.Size = New-Object Drawing.Point 270,25; 
$chck15.Text = 'Fix Microsoft Edge Settings'; 
$chck15.TabIndex = 14; 
$chck15.Checked = $true; 
$chck15.Font = $Font;
$groupBox1.controls.add($chck15); 
$chck15.add_click({count_p})
$chck64 = New-Object Windows.Forms.Checkbox; 
$chck64.Location = New-Object Drawing.Point 10,375; 
$chck64.Size = New-Object Drawing.Point 270,25; 
$chck64.Text = 'Disable Nagle''s Alg. (Delayed ACKs)'; 
$chck64.TabIndex = 63; 
$chck64.Checked = $true; 
$chck64.Font = $Font;
$groupBox1.controls.add($chck64); 
$chck64.add_click({count_p})
$chck65 = New-Object Windows.Forms.Checkbox; 
$chck65.Location = New-Object Drawing.Point 10,400; 
$chck65.Size = New-Object Drawing.Point 270,25; 
$chck65.Text = 'Disable Sleep Mode Timeouts'; 
$chck65.TabIndex = 64; 
$chck65.Checked = $true; 
$chck65.Font = $Font;
$groupBox1.controls.add($chck65); 
$chck65.add_click({count_p})
$chck16 = New-Object Windows.Forms.Checkbox; 
$chck16.Location = New-Object Drawing.Point 295,25; 
$chck16.Size = New-Object Drawing.Point 270,25; 
$chck16.Text = 'Disable Location Sensor'; 
$chck16.TabIndex = 15; 
$chck16.Checked = $true; 
$chck16.Font = $Font;
$groupBox1.controls.add($chck16); 
$chck16.add_click({count_p})
$chck17 = New-Object Windows.Forms.Checkbox; 
$chck17.Location = New-Object Drawing.Point 295,50; 
$chck17.Size = New-Object Drawing.Point 270,25; 
$chck17.Text = 'Disable WiFi HotSpot Auto-Sharing'; 
$chck17.TabIndex = 16; 
$chck17.Checked = $true; 
$chck17.Font = $Font;
$groupBox1.controls.add($chck17); 
$chck17.add_click({count_p})
$chck18 = New-Object Windows.Forms.Checkbox; 
$chck18.Location = New-Object Drawing.Point 295,75; 
$chck18.Size = New-Object Drawing.Point 270,25; 
$chck18.Text = 'Disable Shared HotSpot Connect'; 
$chck18.TabIndex = 17; 
$chck18.Checked = $true; 
$chck18.Font = $Font;
$groupBox1.controls.add($chck18); 
$chck18.add_click({count_p})
$chck19 = New-Object Windows.Forms.Checkbox; 
$chck19.Location = New-Object Drawing.Point 295,100; 
$chck19.Size = New-Object Drawing.Point 270,25; 
$chck19.Text = 'Updates Notify to Schedule Restart'; 
$chck19.TabIndex = 18; 
$chck19.Checked = $true; 
$chck19.Font = $Font;
$groupBox1.controls.add($chck19); 
$chck19.add_MouseHover({
$tooltip19 = New-Object System.Windows.Forms.ToolTip
$tooltip19.SetToolTip($chck19, 'Change Windows Updates to: Notify to schedule restart')
})
$chck19.add_click({count_p})
$chck20 = New-Object Windows.Forms.Checkbox; 
$chck20.Location = New-Object Drawing.Point 295,125; 
$chck20.Size = New-Object Drawing.Point 270,25; 
$chck20.Text = 'P2P Update Setting to LAN (local)'; 
$chck20.TabIndex = 19; 
$chck20.Checked = $true; 
$chck20.Font = $Font;
$groupBox1.controls.add($chck20); 
$chck20.add_MouseHover({
$tooltip20 = New-Object System.Windows.Forms.ToolTip
$tooltip20.SetToolTip($chck20, 'Disable P2P Update downloads outside of local network')
})
$chck20.add_click({count_p})
$chck21 = New-Object Windows.Forms.Checkbox; 
$chck21.Location = New-Object Drawing.Point 295,150; 
$chck21.Size = New-Object Drawing.Point 270,25; 
$chck21.Text = 'Set Lower Shutdown Time (2sec)'; 
$chck21.TabIndex = 20; 
$chck21.Checked = $true; 
$chck21.Font = $Font;
$groupBox1.controls.add($chck21); 
$chck21.add_click({count_p})
$chck22 = New-Object Windows.Forms.Checkbox; 
$chck22.Location = New-Object Drawing.Point 295,175; 
$chck22.Size = New-Object Drawing.Point 270,25; 
$chck22.Text = 'Remove Old Device Drivers'; 
$chck22.TabIndex = 21; 
$chck22.Checked = $true; 
$chck22.Font = $Font;
$groupBox1.controls.add($chck22); 
$chck22.add_click({count_p})
$chck23 = New-Object Windows.Forms.Checkbox; 
$chck23.Location = New-Object Drawing.Point 295,200; 
$chck23.Size = New-Object Drawing.Point 270,25; 
$chck23.Text = 'Disable Get Even More Out of...'; 
$chck23.TabIndex = 22; 
$chck23.Checked = $true; 
$chck23.Font = $Font;
$groupBox1.controls.add($chck23); 
$chck23.add_MouseHover({
$tooltip23 = New-Object System.Windows.Forms.ToolTip
$tooltip23.SetToolTip($chck23, 'Disable Get Even More Out of Windows Screen')
})
$chck23.add_click({count_p})
$chck24 = New-Object Windows.Forms.Checkbox; 
$chck24.Location = New-Object Drawing.Point 295,225; 
$chck24.Size = New-Object Drawing.Point 270,25; 
$chck24.Text = 'Disable Installing Suggested Apps'; 
$chck24.TabIndex = 23; 
$chck24.Checked = $true; 
$chck24.Font = $Font;
$groupBox1.controls.add($chck24); 
$chck24.add_MouseHover({
$tooltip24 = New-Object System.Windows.Forms.ToolTip
$tooltip24.SetToolTip($chck23, 'Disable automatically installing suggested apps')
})
$chck24.add_click({count_p})
$chck25 = New-Object Windows.Forms.Checkbox; 
$chck25.Location = New-Object Drawing.Point 295,250; 
$chck25.Size = New-Object Drawing.Point 270,25; 
$chck25.Text = 'Disable Start Menu Ads/Suggestions'; 
$chck25.TabIndex = 24; 
$chck25.Checked = $true; 
$chck25.Font = $Font;
$groupBox1.controls.add($chck25); 
$chck25.add_click({count_p})
$chck26 = New-Object Windows.Forms.Checkbox; 
$chck26.Location = New-Object Drawing.Point 295,275; 
$chck26.Size = New-Object Drawing.Point 274,25; 
$chck26.Text = 'Disable Suggest Apps WindowsInk'; 
$chck26.TabIndex = 25; 
$chck26.Checked = $true; 
$chck26.Font = $Font;
$groupBox1.controls.add($chck26); 
$chck26.add_click({count_p})
$chck27 = New-Object Windows.Forms.Checkbox; 
$chck27.Location = New-Object Drawing.Point 295,300; 
$chck27.Size = New-Object Drawing.Point 270,25; 
$chck27.Text = 'Disable Unnecessary Components'; 
$chck27.TabIndex = 26; 
$chck27.Checked = $true; 
$chck27.Font = $Font;
$groupBox1.controls.add($chck27); 
$chck27.add_MouseHover({
$tooltip27 = New-Object System.Windows.Forms.ToolTip
$tooltip27.SetToolTip($chck27, 'PrintToPDFServices, Printing-XPSServices, Xps-Viewer')
})
$chck27.add_click({count_p})
$chck28 = New-Object Windows.Forms.Checkbox; 
$chck28.Location = New-Object Drawing.Point 295,325; 
$chck28.Size = New-Object Drawing.Point 270,25; 
$chck28.Text = 'Defender Scheduled Scan Nerf'; 
$chck28.TabIndex = 27; 
$chck28.Checked = $true; 
$chck28.Font = $Font;
$groupBox1.controls.add($chck28); 
$chck28.add_MouseHover({
$tooltip28 = New-Object System.Windows.Forms.ToolTip
$tooltip28.SetToolTip($chck28, 'Setting Windows Defender Scheduled Scan from highest to normal privileges')
})
$chck28.add_click({count_p})
$chck29 = New-Object Windows.Forms.Checkbox; 
$chck29.Location = New-Object Drawing.Point 295,350; 
$chck29.Size = New-Object Drawing.Point 270,25; 
$chck29.Text = 'Disable Process Mitigation'; 
$chck29.TabIndex = 28; 
$chck29.Checked = $true; 
$chck29.Font = $Font;
$groupBox1.controls.add($chck29); 
$chck29.add_MouseHover({
$tooltip29 = New-Object System.Windows.Forms.ToolTip
$tooltip29.SetToolTip($chck29, 'Audit exploit mitigations for increased process security or for converting existing Enhanced Mitigation Experience Toolkit')
})
$chck29.add_click({count_p})
$chck30 = New-Object Windows.Forms.Checkbox; 
$chck30.Location = New-Object Drawing.Point 295,375; 
$chck30.Size = New-Object Drawing.Point 270,25; 
$chck30.Text = 'Defragment Indexing Service File'; 
$chck30.TabIndex = 29; 
$chck30.Checked = $true; 
$chck30.Font = $Font;
$groupBox1.controls.add($chck30); 
$chck30.add_MouseHover({
$tooltip30 = New-Object System.Windows.Forms.ToolTip
$tooltip30.SetToolTip($chck30, 'Defragmenting the Indexing Service database file')
}) 
$chck30.add_click({count_p})
$chck66 = New-Object Windows.Forms.Checkbox; 
$chck66.Location = New-Object Drawing.Point 295,125; 
$chck66.Size = New-Object Drawing.Point 270,25; 
$chck66.Text = 'Disable Spectre/Meltdown Protection'; 
$chck66.TabIndex = 65; 
$chck66.Checked = $false; 
$chck66.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c')
$chck66.Font = $Font;
$groupBox4.controls.add($chck66); 
$chck66.add_MouseHover({
$tooltip66 = New-Object System.Windows.Forms.ToolTip
$tooltip66.SetToolTip($chck66, 'These are important secure patches although it decrease system performance.')
})
$chck3 = New-Object Windows.Forms.Checkbox; 
$chck3.Location = New-Object Drawing.Point 295,150; 
$chck3.Size = New-Object Drawing.Point 270,25; 
$chck3.Text = 'Disable Windows Defender'; 
$chck3.TabIndex = 2; 
$chck3.Checked = $false; 
$chck3.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c')
$chck3.Font = $Font;
$groupBox4.controls.add($chck3); 
$chck3.add_MouseHover({
$tooltip67 = New-Object System.Windows.Forms.ToolTip
$tooltip67.SetToolTip($chck3, 'You are doing this at your own risk ')
})
$chck31 = New-Object Windows.Forms.Checkbox; 
$chck31.Location = New-Object Drawing.Point 10,25; 
$chck31.Size = New-Object Drawing.Point 270,25; 
$chck31.Text = 'Disable Telemetry Scheduled Tasks'; 
$chck31.TabIndex = 30; 
$chck31.Checked = $true; 
$chck31.Font = $Font;
$groupBox2.controls.add($chck31); 
$chck31.add_click({count_s})
$chck32 = New-Object Windows.Forms.Checkbox; 
$chck32.Location = New-Object Drawing.Point 10,50; 
$chck32.Size = New-Object Drawing.Point 270,25; 
$chck32.Text = 'Remove Telemetry/Data Collection'; 
$chck32.TabIndex = 31; 
$chck32.Checked = $true; 
$chck32.Font = $Font;
$groupBox2.controls.add($chck32); 
$chck32.add_click({count_s})
$chck33 = New-Object Windows.Forms.Checkbox; 
$chck33.Location = New-Object Drawing.Point 10,75; 
$chck33.Size = New-Object Drawing.Point 270,25; 
$chck33.Text = 'Disable PowerShell Telemetry'; 
$chck33.TabIndex = 32; 
$chck33.Checked = $true; 
$chck33.Font = $Font;
$groupBox2.controls.add($chck33); 
$chck33.add_click({count_s})
$chck34 = New-Object Windows.Forms.Checkbox; 
$chck34.Location = New-Object Drawing.Point 10,100; 
$chck34.Size = New-Object Drawing.Point 270,25; 
$chck34.Text = 'Disable Skype Telemetry'; 
$chck34.TabIndex = 33; 
$chck34.Checked = $true; 
$chck34.Font = $Font;
$groupBox2.controls.add($chck34); 
$chck34.add_click({count_s})
$chck35 = New-Object Windows.Forms.Checkbox; 
$chck35.Location = New-Object Drawing.Point 10,125; 
$chck35.Size = New-Object Drawing.Point 270,25; 
$chck35.Text = 'Disable Media Player Usage Reports'; 
$chck35.TabIndex = 34; 
$chck35.Checked = $true; 
$chck35.Font = $Font;
$groupBox2.controls.add($chck35); 
$chck35.add_click({count_s})
$chck36 = New-Object Windows.Forms.Checkbox; 
$chck36.Location = New-Object Drawing.Point 10,150; 
$chck36.Size = New-Object Drawing.Point 270,25; 
$chck36.Text = 'Disable Mozilla Telemetry'; 
$chck36.TabIndex = 35; 
$chck36.Checked = $true; 
$chck36.Font = $Font;
$groupBox2.controls.add($chck36); 
$chck36.add_click({count_s})
$chck37 = New-Object Windows.Forms.Checkbox; 
$chck37.Location = New-Object Drawing.Point 10,175; 
$chck37.Size = New-Object Drawing.Point 270,25; 
$chck37.Text = 'Disable Apps Use My Advertising ID'; 
$chck37.TabIndex = 36; 
$chck37.Checked = $true; 
$chck37.Font = $Font;
$groupBox2.controls.add($chck37); 
$chck37.add_click({count_s})
$chck38 = New-Object Windows.Forms.Checkbox; 
$chck38.Location = New-Object Drawing.Point 10,200; 
$chck38.Size = New-Object Drawing.Point 270,25; 
$chck38.Text = 'Disable Send Info About How I Write'; 
$chck38.TabIndex = 37; 
$chck38.Checked = $true; 
$chck38.Font = $Font;
$groupBox2.controls.add($chck38); 
$chck38.add_click({count_s})
$chck39 = New-Object Windows.Forms.Checkbox; 
$chck39.Location = New-Object Drawing.Point 10,225; 
$chck39.Size = New-Object Drawing.Point 270,25; 
$chck39.Text = 'Disable Handwriting Recognition'; 
$chck39.TabIndex = 38; 
$chck39.Checked = $true; 
$chck39.Font = $Font;
$groupBox2.controls.add($chck39); 
$chck39.add_click({count_s})
$chck40 = New-Object Windows.Forms.Checkbox; 
$chck40.Location = New-Object Drawing.Point 10,250; 
$chck40.Size = New-Object Drawing.Point 270,25; 
$chck40.Text = 'Disable Watson Malware Reports'; 
$chck40.TabIndex = 39; 
$chck40.Checked = $true; 
$chck40.Font = $Font;
$groupBox2.controls.add($chck40); 
$chck40.add_click({count_s})
$chck41 = New-Object Windows.Forms.Checkbox; 
$chck41.Location = New-Object Drawing.Point 10,275; 
$chck41.Size = New-Object Drawing.Point 270,25; 
$chck41.Text = 'Disable Malware Diagnostic Data'; 
$chck41.TabIndex = 40; 
$chck41.Checked = $true; 
$chck41.Font = $Font;
$groupBox2.controls.add($chck41); 
$chck41.add_click({count_s})
$chck42 = New-Object Windows.Forms.Checkbox; 
$chck42.Location = New-Object Drawing.Point 10,300; 
$chck42.Size = New-Object Drawing.Point 270,25; 
$chck42.Text = 'Disable Reporting to MS MAPS'; 
$chck42.TabIndex = 41; 
$chck42.Checked = $true; 
$chck42.Font = $Font;
$groupBox2.controls.add($chck42); 
$chck42.add_click({count_s})
$chck43 = New-Object Windows.Forms.Checkbox; 
$chck43.Location = New-Object Drawing.Point 10,325; 
$chck43.Size = New-Object Drawing.Point 270,25; 
$chck43.Text = 'Disable Spynet Defender Reporting'; 
$chck43.TabIndex = 42; 
$chck43.Checked = $true; 
$chck43.Font = $Font;
$groupBox2.controls.add($chck43); 
$chck43.add_click({count_s})
$chck44 = New-Object Windows.Forms.Checkbox; 
$chck44.Location = New-Object Drawing.Point 10,350; 
$chck44.Size = New-Object Drawing.Point 270,25; 
$chck44.Text = 'Do Not Send Malware Samples'; 
$chck44.TabIndex = 43; 
$chck44.Checked = $true; 
$chck44.Font = $Font;
$groupBox2.controls.add($chck44); 
$chck44.add_click({count_s})
$chck45 = New-Object Windows.Forms.Checkbox; 
$chck45.Location = New-Object Drawing.Point 10,375; 
$chck45.Size = New-Object Drawing.Point 270,25; 
$chck45.Text = 'Disable Sending Typing Samples'; 
$chck45.TabIndex = 44; 
$chck45.Checked = $true; 
$chck45.Font = $Font;
$groupBox2.controls.add($chck45); 
$chck45.add_click({count_s})
$chck46 = New-Object Windows.Forms.Checkbox; 
$chck46.Location = New-Object Drawing.Point 10,400; 
$chck46.Size = New-Object Drawing.Point 270,25; 
$chck46.Text = 'Disable Sending Contacts to MS'; 
$chck46.TabIndex = 45; 
$chck46.Checked = $true; 
$chck46.Font = $Font;
$groupBox2.controls.add($chck46); 
$chck46.add_click({count_s})
$chck47 = New-Object Windows.Forms.Checkbox; 
$chck47.Location = New-Object Drawing.Point 10,425; 
$chck47.Size = New-Object Drawing.Point 270,25; 
$chck47.Text = 'Disable Cortana'; 
$chck47.TabIndex = 46; 
$chck47.Checked = $true; 
$chck47.Font = $Font;
$groupBox2.controls.add($chck47); 
$chck47.add_click({count_s})
$chck48 = New-Object Windows.Forms.Checkbox; 
$chck48.Location = New-Object Drawing.Point 10,25; 
$chck48.Size = New-Object Drawing.Point 270,25; 
$chck48.Text = 'Show File Extensions in Explorer'; 
$chck48.TabIndex = 47; 
$chck48.Checked = $true; 
$chck48.Font = $Font;
$groupBox3.controls.add($chck48); 
$chck48.add_click({count_v})
$chck49 = New-Object Windows.Forms.Checkbox; 
$chck49.Location = New-Object Drawing.Point 10,50; 
$chck49.Size = New-Object Drawing.Point 270,25; 
$chck49.Text = 'Disable Transparency on Taskbar'; 
$chck49.TabIndex = 48; 
$chck49.Checked = $true; 
$chck49.Font = $Font;
$groupBox3.controls.add($chck49); 
$chck49.add_click({count_v})
$chck50 = New-Object Windows.Forms.Checkbox; 
$chck50.Location = New-Object Drawing.Point 10,75; 
$chck50.Size = New-Object Drawing.Point 270,25; 
$chck50.Text = 'Disable Windows Animations'; 
$chck50.TabIndex = 49; 
$chck50.Checked = $true; 
$chck50.Font = $Font;
$groupBox3.controls.add($chck50); 
$chck50.add_click({count_v})
$chck51 = New-Object Windows.Forms.Checkbox; 
$chck51.Location = New-Object Drawing.Point 10,100; 
$chck51.Size = New-Object Drawing.Point 270,25; 
$chck51.Text = 'Disable MRU lists (jump lists)'; 
$chck51.TabIndex = 50; 
$chck51.Checked = $true; 
$chck51.Font = $Font;
$groupBox3.controls.add($chck51); 
$chck51.add_click({count_v})
$chck52 = New-Object Windows.Forms.Checkbox; 
$chck52.Location = New-Object Drawing.Point 10,125; 
$chck52.Size = New-Object Drawing.Point 270,25; 
$chck52.Text = 'Set Search Box to Icon Only'; 
$chck52.TabIndex = 51; 
$chck52.Checked = $true; 
$chck52.Font = $Font;
$groupBox3.controls.add($chck52);
$chck52.add_click({count_v})
$chck53 = New-Object Windows.Forms.Checkbox; 
$chck53.Location = New-Object Drawing.Point 10,150; 
$chck53.Size = New-Object Drawing.Point 270,25; 
$chck53.Text = 'Explorer on Start on This PC'; 
$chck53.TabIndex = 52; 
$chck53.Checked = $true; 
$chck53.Font = $Font;
$groupBox3.controls.add($chck53); 
$chck53.add_click({count_v})
$chck54 = New-Object Windows.Forms.Checkbox; 
$chck54.Location = New-Object Drawing.Point 10,25; 
$chck54.Size = New-Object Drawing.Point 270,25; 
$chck54.Text = 'Remove Windows Game Bar/DVR'; 
$chck54.TabIndex = 53; 
$chck54.Checked = $true; 
$chck54.Font = $Font;
$groupBox4.controls.add($chck54);  
$chck55 = New-Object Windows.Forms.Checkbox; 
$chck55.Location = New-Object Drawing.Point 10,425; 
$chck55.Size = New-Object Drawing.Point 270,25; 
$chck55.Text = 'Enable Service Tweaks'; 
$chck55.TabIndex = 54; 
$chck55.Checked = $true; 
$chck55.Font = $Font;
$groupBox1.controls.add($chck55); 
$chck55.add_MouseHover({
$tooltip55 = New-Object System.Windows.Forms.ToolTip
$tooltip55.SetToolTip($chck55, 'More details on github.com/semazurek ')
})
$chck55.add_click({count_p})
$chck56 = New-Object Windows.Forms.Checkbox; 
$chck56.Location = New-Object Drawing.Point 295,400; 
$chck56.Size = New-Object Drawing.Point 270,25; 
$chck56.Text = 'Remove Bloatware (Preinstalled)'; 
$chck56.TabIndex = 55; 
$chck56.Checked = $true; 
$chck56.Font = $Font;
$groupBox1.controls.add($chck56);
$chck56.add_MouseHover({
$tooltip56 = New-Object System.Windows.Forms.ToolTip
$tooltip56.SetToolTip($chck56, 'More details on github.com/semazurek ')
})
$chck56.add_click({count_p})
$chck57 = New-Object Windows.Forms.Checkbox; 
$chck57.Location = New-Object Drawing.Point 295,425; 
$chck57.Size = New-Object Drawing.Point 270,25; 
$chck57.Text = 'Disable Unnecessary Startup Apps'; 
$chck57.TabIndex = 56; 
$chck57.Checked = $true; 
$chck57.Font = $Font;
$groupBox1.controls.add($chck57); 
$chck57.add_MouseHover({
$tooltip57 = New-Object System.Windows.Forms.ToolTip
$tooltip57.SetToolTip($chck57, "Java Update Checker x64 `n Mini Partition Tool Wizard Updater `n Teams Machine Installer `n Cisco Meeting Daemon `n Adobe Reader Speed Launcher `n CCleaner Smart Cleaning/Monitor `n Spotify Web Helper `n Gaijin.Net Updater `n Microsoft Teams Update `n Google Update `n Microsoft Edge Update `n BitTorrent Bleep `n Skype `n Adobe Update Startup Utility `n iTunes Helper `n CyberLink Update Utility `n MSI Live Update `n Wondershare Helper Compact `n Cisco AnyConnect Secure Mobility Agent `n Wargaming.net Game Center `n Skype for Desktop `n Gog Galaxy `n Epic Games Launcher `n Origin `n Steam `n Opera Browser Assistant `n uTorrent `n Skype for Business `n Google Chrome Installer `n Microsoft Edge Installer `n Discord Update `n Blitz")
})
$chck57.add_click({count_p})
$chck58 = New-Object Windows.Forms.Checkbox; 
$chck58.Location = New-Object Drawing.Point 10,50; 
$chck58.Size = New-Object Drawing.Point 270,25; 
$chck58.Text = 'Clean Temp/Cache/Prefetch/Logs'; 
$chck58.TabIndex = 57; 
$chck58.Checked = $true; 
$chck58.Font = $Font;
$groupBox4.controls.add($chck58); 
$chck59 = New-Object Windows.Forms.Checkbox; 
$chck59.Location = New-Object Drawing.Point 10,75; 
$chck59.Size = New-Object Drawing.Point 275,25; 
$chck59.Text = 'Remove News and Interests/Widgets'; 
$chck59.TabIndex = 58; 
$chck59.Checked = $false; 
$chck59.Font = $Font;
$groupBox4.controls.add($chck59); 
$chck60 = New-Object Windows.Forms.Checkbox; 
$chck60.Location = New-Object Drawing.Point 295,100; 
$chck60.Size = New-Object Drawing.Point 270,25; 
$chck60.Text = 'Remove Microsoft OneDrive'; 
$chck60.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c')
$chck60.TabIndex = 59; 
$chck60.Checked = $false; 
$chck60.Font = $Font;
$groupBox4.controls.add($chck60); 
$chck61 = New-Object Windows.Forms.Checkbox; 
$chck61.Location = New-Object Drawing.Point 295,50; 
$chck61.Size = New-Object Drawing.Point 270,25; 
$chck61.Text = 'Disable Xbox Services'; 
$chck61.TabIndex = 60; 
$chck61.Checked = $false;
$chck61.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c') 
$chck61.Font = $Font;
$groupBox4.controls.add($chck61); 
$chck62 = New-Object Windows.Forms.Checkbox; 
$chck62.Location = New-Object Drawing.Point 295,75; 
$chck62.Size = New-Object Drawing.Point 270,25; 
$chck62.Text = 'Enable Fast/Secure DNS (1.1.1.1)'; 
$chck62.TabIndex = 61; 
$chck62.Checked = $false; 
$chck62.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c')
$chck62.Font = $Font;
$groupBox4.controls.add($chck62); 
$chck63 = New-Object Windows.Forms.Checkbox; 
$chck63.Location = New-Object Drawing.Point 10,100; 
$chck63.Size = New-Object Drawing.Point 270,25; 
$chck63.Text = 'Scan for Adware (AdwCleaner)'; 
$chck63.TabIndex = 62; 
$chck63.Checked = $false; 
$chck63.Font = $Font;
$groupBox4.controls.add($chck63); 
$chck67 = New-Object Windows.Forms.Checkbox; 
$chck67.Location = New-Object Drawing.Point 295,25; 
$chck67.Size = New-Object Drawing.Point 270,25; 
$chck67.Text = 'Remove Microsoft Edge'; 
$chck67.TabIndex = 66; 
$chck67.Checked = $false;
$chck67.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#e74c3c') 
$chck67.Font = $Font;
$groupBox4.controls.add($chck67); 
$chck68 = New-Object Windows.Forms.Checkbox; 
$chck68.Location = New-Object Drawing.Point 10,125; 
$chck68.Size = New-Object Drawing.Point 270,25; 
$chck68.Text = 'Clean WinSxS Folder'; 
$chck68.TabIndex = 67; 
$chck68.Checked = $false;
$chck68.Font = $Font;
$groupBox4.controls.add($chck68); 
$chck69 = New-Object Windows.Forms.Checkbox; 
$chck69.Location = New-Object Drawing.Point 10,150; 
$chck69.Size = New-Object Drawing.Point 270,25; 
$chck69.Text = 'Remove Microsoft Teams'; 
$chck69.TabIndex = 68; 
$chck69.Checked = $false;
$chck69.Font = $Font;
$groupBox4.controls.add($chck69); 
count_p;
count_v;
count_s;
function About {
$aboutForm = New-Object System.Windows.Forms.Form; 
$aboutFormExit = New-Object System.Windows.Forms.Button; 
$aboutFormNameLabel = New-Object System.Windows.Forms.Label; 
$aboutFormText = New-Object System.Windows.Forms.Label; 
$aboutFormText2 = New-Object System.Windows.Forms.Label; 
$aboutForm.MinimizeBox = $false; 
$aboutForm.MaximizeBox = $false; 
$aboutForm.TopMost = $true; 
$aboutForm.FlatStyle = 'Flat'
$aboutForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$aboutForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$aboutForm.AutoSizeMode = 'GrowAndShrink'; 
$aboutForm.FormBorderStyle = 'FixedDialog'; 
$aboutForm.AcceptButton = $aboutFormExit; 
$aboutForm.CancelButton = $aboutFormExit; 
$aboutForm.ClientSize = '350, 110'; 
$aboutForm.ControlBox = $false; 
$aboutForm.ShowInTaskBar = $false; 
$aboutForm.StartPosition = 'CenterParent'; 
$aboutForm.Text = 'About'; 
$aboutForm.Add_Load($aboutForm_Load); 
$aboutFormNameLabel.Font = New-Object Drawing.Font('Consolas', 9, [System.Drawing.FontStyle]::Bold); 
$aboutFormNameLabel.Location = '110, 10'; 
$aboutFormNameLabel.Size = '200, 18'; 
$aboutFormNameLabel.Text = '  E.T. All in One'; 
$aboutForm.Controls.Add($aboutFormNameLabel); 
$aboutFormText.Location = '100, 30'; 
$aboutFormText.Size = '300, 20'; $aboutFormText.Text = '         Sebastian Mazurek'; 
$aboutForm.Controls.Add($aboutFormText); 
$aboutFormText2.Location = '100, 50'; 
$aboutFormText2.Size = '300, 20';  
$aboutFormText2.Text = '      GitHub.com/semazurek'; 
$aboutForm.Controls.Add($aboutFormText2); 
$aboutFormExit.Location = '138, 75'; 
$aboutFormExit.Text = 'OK'; 
$aboutFormExit.FlatStyle = 'Flat'
$aboutForm.Controls.Add($aboutFormExit); 
[void]$aboutForm.ShowDialog()
}; 
function Extras {
$extraForm = New-Object System.Windows.Forms.Form; 
$extraFormB1 = New-Object System.Windows.Forms.Button; 
$extraFormB2 = New-Object System.Windows.Forms.Button; 
$extraFormB3 = New-Object System.Windows.Forms.Button; 
$extraFormB4 = New-Object System.Windows.Forms.Button; 
$extraFormB5 = New-Object System.Windows.Forms.Button; 
$extraFormB6 = New-Object System.Windows.Forms.Button; 
$extraFormB7 = New-Object System.Windows.Forms.Button; 
$extraFormB8 = New-Object System.Windows.Forms.Button; 
$extraFormB9 = New-Object System.Windows.Forms.Button; 
$extraFormB10 = New-Object System.Windows.Forms.Button; 
$extraFormB11 = New-Object System.Windows.Forms.Button; 
$extraFormB12 = New-Object System.Windows.Forms.Button; 
$extraForm.MinimizeBox = $false; 
$extraForm.MaximizeBox = $false; 
$extraForm.TopMost = $true; 
$extraForm.AutoSizeMode = 'GrowAndShrink'; 
$extraForm.FormBorderStyle = 'FixedDialog'; 
$extraForm.AcceptButton = $extraFormExit; 
$extraForm.CancelButton = $extraFormExit; 
$extraForm.ClientSize = '200, 390'; 
$extraForm.ShowInTaskBar = $false; 
$extraForm.FlatStyle = 'Flat'
$extraForm.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#252525')
$extraForm.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee')
$extraForm.Location = (30,30);
$extraForm.Text = 'Extras'; 
$extraForm.Font = $font;
$extraFormB1.Location = '25, 15'; 
$extraFormB1.Size = New-Object Drawing.Point 150,25;
$extraFormB1.Text = 'Disk Defragmenter'; 
$extraFormB1.add_click({dfrgui.exe});
$extraFormB1.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB1); 
$extraFormB1.add_MouseHover({
$tooltipEB1 = New-Object System.Windows.Forms.ToolTip
$tooltipEB1.SetToolTip($extraFormB1, 'Optimize your drives to help your computer run more efficienlty.')
})
$extraFormB2.Location = '25, 45'; 
$extraFormB2.Size = New-Object Drawing.Point 150,25;
$extraFormB2.Text = 'Cleanmgr'; 
$extraFormB2.add_click({cleanmgr.exe});
$extraFormB2.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB2); 
$extraFormB2.add_MouseHover({
$tooltipEB2 = New-Object System.Windows.Forms.ToolTip
$tooltipEB2.SetToolTip($extraFormB2, 'Clears unnecessary files from your computer hard disk.')
})
$extraFormB3.Location = '25, 75'; 
$extraFormB3.Size = New-Object Drawing.Point 150,25;
$extraFormB3.Text = 'Msconfig'; 
$extraFormB3.add_click({msconfig});
$extraFormB3.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB3); 
$extraFormB3.add_MouseHover({
$tooltipEB3 = New-Object System.Windows.Forms.ToolTip
$tooltipEB3.SetToolTip($extraFormB3, 'Utility designed to troubleshoot and configure Windows startup process.')
})
$extraFormB4.Location = '25, 105'; 
$extraFormB4.Size = New-Object Drawing.Point 150,25;
$extraFormB4.Text = 'Control Panel'; 
$extraFormB4.add_click({control.exe});
$extraFormB4.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB4); 
$extraFormB5.Location = '25, 135'; 
$extraFormB5.Size = New-Object Drawing.Point 150,25;
$extraFormB5.Text = 'Device Manager'; 
$extraFormB5.add_click({devmgmt.msc});
$extraFormB5.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB5); 
$extraFormB6.Location = '25, 165'; 
$extraFormB6.Size = New-Object Drawing.Point 150,25;
$extraFormB6.Text = 'UAC Settings'; 
$extraFormB6.add_click({UserAccountControlSettings.exe});
$extraFormB6.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB6); 
$extraFormB7.Location = '25, 195'; 
$extraFormB7.Size = New-Object Drawing.Point 150,25;
$extraFormB7.Text = 'Msinfo32'; 
$extraFormB7.add_click({msinfo32});
$extraFormB7.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB7); 
$extraFormB7.add_MouseHover({
$tooltipEB7 = New-Object System.Windows.Forms.ToolTip
$tooltipEB7.SetToolTip($extraFormB7, 'This tool gathers information about your computer.')
})
$extraFormB8.Location = '25, 225'; 
$extraFormB8.Size = New-Object Drawing.Point 150,25;
$extraFormB8.Text = 'Services'; 
$extraFormB8.add_click({services.msc});
$extraFormB8.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB8); 
$extraFormB9.Location = '25, 255'; 
$extraFormB9.Size = New-Object Drawing.Point 150,25;
$extraFormB9.Text = 'Remote Desktop'; 
$extraFormB9.add_click({mstsc});
$extraFormB9.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB9); 
$extraFormB10.Location = '25, 285'; 
$extraFormB10.Size = New-Object Drawing.Point 150,25;
$extraFormB10.Text = 'Event Viewer'; 
$extraFormB10.add_click({eventvwr.msc});
$extraFormB10.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB10); 
$extraFormB11.Location = '25, 315'; 
$extraFormB11.Size = New-Object Drawing.Point 150,25;
$extraFormB11.Text = 'Reset Network'; 
$extraFormB11.add_click({start C:\ProgramData\restart-network-settings.bat});
$extraFormB11.FlatStyle = 'Flat'
$extraForm.Controls.Add($extraFormB11); 
$extraFormB11.add_MouseHover({
$tooltipEB11 = New-Object System.Windows.Forms.ToolTip
$tooltipEB11.SetToolTip($extraFormB11, 'This option will reset any internet settings on your device.')
})
$extraFormB12.Location = '25, 345'; 
$extraFormB12.Size = New-Object Drawing.Point 150,25; 
$extraFormB12.Text = 'Update Applications (Winget)'; 
$extraFormB12.add_click({start C:\ProgramData\winget-et.bat}); 
$extraFormB12.FlatStyle = 'Flat' 
$extraForm.Controls.Add($extraFormB12); 
$extraFormB12.add_MouseHover({
$tooltipEB12 = New-Object System.Windows.Forms.ToolTip
$tooltipEB12.SetToolTip($extraFormB12, 'Update Applications (winget upgrade --all)')
})
[void]$extraForm.ShowDialog()
}; 
function addMenuItem { param([ref]$ParentItem, [string]$ItemName='', [string]$ItemText='', [scriptblock]$ScriptBlock=$null ) [System.Windows.Forms.ToolStripMenuItem]$private:menuItem=` New-Object System.Windows.Forms.ToolStripMenuItem;
$private:menuItem.Name =$ItemName; 
$private:menuItem.Text =$ItemText; 
if ($ScriptBlock -ne $null) { $private:menuItem.add_Click(([System.EventHandler]$handler=` $ScriptBlock));}; 
if (($ParentItem.Value) -is [System.Windows.Forms.MenuStrip]) { ($ParentItem.Value).Items.Add($private:menuItem);} return $private:menuItem; }; 
function Backup{start C:\ProgramData\regback-et.bat; $timeback=Get-Date -Format G ;echo [ET] $timeback > $Env:programdata\ET-dump.log}; 
[System.Windows.Forms.MenuStrip]$mainMenu=New-Object System.Windows.Forms.MenuStrip; $form.Controls.Add($mainMenu); 
$mainMenu.BackColor = [System.Drawing.ColorTranslator]::FromHtml('#323232');
$mainMenu.ForeColor = [System.Drawing.ColorTranslator]::FromHtml('#eeeeee');
[scriptblock]$exit= {$form.Close()}; 
[scriptblock]$backup= {Backup}; 
[scriptblock]$restore= {rstrui.exe; sleep 1;start C:\RegBack}; 
[scriptblock]$about= {About}; 
[scriptblock]$donate= {start https://www.paypal.com/paypalme/rikey}; 
[scriptblock]$extras= {Extras}; 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Backup' -ScriptBlock $backup); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Restore' -ScriptBlock $restore); 
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Extras' -ScriptBlock $extras);
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'About' -ScriptBlock $about);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Donate' -ScriptBlock $donate);  
(addMenuItem -ParentItem ([ref]$mainMenu) -ItemName 'mnuFile' -ItemText 'Exit' -ScriptBlock $exit); 
$form.ShowDialog();
