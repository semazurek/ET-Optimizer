$apps = @(
    # Whitelist apps
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.Office.OneNote"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "microsoft.windowscommunicationsapps"
	"Microsoft.NET.Native.Framework.2.2"
	"Microsoft.NET.Native.Framework.2.0"
	"Microsoft.NET.Native.Runtime.2.2"
	"Microsoft.NET.Native.Runtime.2.0"
	"Microsoft.UI.Xaml.2.7"
	"Microsoft.UI.Xaml.2.0"
	"Microsoft.WindowsAppRuntime.1.3"
	"Microsoft.NET.Native.Framework.1.7"
	"MicrosoftWindows.Client.Core"
	"Microsoft.LockApp"
	"Microsoft.WindowsAppRuntime.CBS"
	"Microsoft.VCLibs.140.00.UWPDesktop"
	"Microsoft.VCLibs.120.00.UWPDesktop"
	"Microsoft.VCLibs.110.00.UWPDesktop"
	"Microsoft.DirectXRuntime"
	"Microsoft.XboxGameOverlay"
	"Microsoft.XboxGamingOverlay"
	"Microsoft.GamingApp"
	"Microsoft.GamingServices"
	"Microsoft.XboxIdentityProvider"
	"Microsoft.Xbox.TCUI"
	"Microsoft.AccountsControl"
	"Microsoft.WindowsStore"
	"Microsoft.StorePurchaseApp"
    "Microsoft.Messaging"
    "NotepadPlusPlus"
)

$RemoveAppPkgs = (Get-AppxPackage -AllUsers).Name
'TotalApps: ' + $RemoveAppPkgs.Count
'TotalWhiteListedApps: ' + $apps.Count
'TotalBlackListeedApps: ' + ($RemoveAppPkgs.Count - $apps.Count)

ForEach($TargetApp in $RemoveAppPkgs)
{
    If($apps -notcontains $TargetApp)
    {
        "Trying to remove $TargetApp"

        Get-AppxPackage -Name $TargetApp -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

        Get-AppXProvisionedPackage -Online |
            Where-Object DisplayName -EQ $TargetApp |
            Remove-AppxProvisionedPackage -Online
    }
}