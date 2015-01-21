# PSNativeDataStore
PSNativeDataStore is a script module designed to store PowerShell objects in a native format to disk.  Ideal of configuration files, your code does not change as you move from server to server.  You can access your objects with the same code even if the object files are located in a different directory or drive on each server!!!

This was designed and testing using PowerShell version 4.0.  Minor changes may be required to work with earlier versions.

PSNativeDataStore is a PowerShell module.  The following installation instructions install the module for all users. If you need different install options, see the Microsoft documentation about placement of PowerShell Modules.

# Installation
  1)  Locate your PowerShell Modules directory.  Typically this is located at:
        %WINDIR%\system32\WindowsPowerShell\v1.0\Modules\
  2)  Create a new directory called PSNativeDataStore under Modules directory specifed above.
        ( %WINDIR%\system32\WindowsPowerShell\v1.0\Modules\PSNativeDataStore)
  3)  Copy the file PSNativeDataStore.psm1 from this project to this newly created directory
  
  4)  Start PowerShell and enter the following command:    Get-Module -ListAvailable PSNativeDataStore
