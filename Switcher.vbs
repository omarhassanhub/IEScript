'Original script:https://gallery.technet.microsoft.com/Proxy-On-OFF-switcher-with-945493b6

Set WshShell = WScript.CreateObject("WScript.Shell")

DimSetting = WshShell.RegRead ("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ProxyEnable")

If DimSetting = 1 Then 
'Wscript.Echo "Proxy server is currently DISABLED"

returnvalue=MsgBox ("Do you want to ENABLE the proxy pac?", 36, "Proxy pac state is currently DISABLED")


if returnvalue = 6 then 
' BEGIN CALLOUT A
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
 "CurrentVersion\Internet Settings\AutoConfigURL", "Here you may add your proxy pac", "REG_SZ"
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
	"CurrentVersion\Internet Settings\ProxyEnable", _
	0, "REG_DWORD"
' END CALLOUT A

wShshell.Run "taskkill /im iexplore.exe",0,True
WScript.Sleep 500 'give kill time to take effect

'Inform User that the task is done.
Mybox = MsgBox("Proxy pac is now ENABLED" ,vbOkOnly,"Proxy pac ENABLED")
're-launch internet explorer
wShshell.Run "iexplore.exe"
End If
WScript.Quit


Else 

'Wscript.Echo "Proxy pac is Currently Disabled" 
End If


'On Error Resume Next

returnvalue=MsgBox ("Do you want to ENABLE the proxy server?", 36, "Proxy server state is currently DISABLED")

If returnvalue = "" Then
  WScript.Quit
End If

if returnvalue = 6 then 
' BEGIN CALLOUT A
'Replace <Domain Proxy Server> in line 50  with IP or your proxy server name without the <> eg. ContosoProxy:80
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
	"CurrentVersion\Internet Settings\ProxyEnable", _
	1, "REG_DWORD"
'The following line disables the pac file or set to 0
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
 "CurrentVersion\Internet Settings\AutoConfigURL", _
	0, "REG_DWORD"
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
	"CurrentVersion\Internet Settings\ProxyServer","Enter your proxy server here e.g. 10.1.1.0:80", "REG_SZ"
'This line will allow you to by pass the proxy server
WshShell.RegWrite "HKCU\Software\Microsoft\Windows\" & _
	"CurrentVersion\Internet Settings\ProxyOverride","<local>", "REG_SZ"
' END CALLOUT A


wShshell.Run "taskkill /im iexplore.exe",0,True

WScript.Sleep 500 'give kill time to take effect

'Inform User that the task is done.
Mybox = MsgBox("Proxy server 10.1.1.0 is enabled and set to bypass",vbOkOnly,"Proxy server ENABLED")
're-launch internet explorer
wShshell.Run "iexplore.exe"
End If

WScript.Quit