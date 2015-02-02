
#     UNDER CONSTRUCTION

# PSNativeDataStore( NDS )
PSNativeDataStore is a script module designed to store and organize PowerShell objects in a native format to disk.  
Some of nifty uses for PSNativeDataStore

      - Configuration files!  Store server specific configurations on the server itself, not in your code.
      - Persist values from one session to the next
      - Store values based on project.  Access with the same code everytime!
      - Special functions allow you to include external scripts you store in the NDS Repository

NDS also has some interesting features:

      - The NDS Repository is organized by Project. Keep your related files together automatically
      - You load everything by Project.  This allows you to use the same code everywhere - even if the 
         files are stored in different locations on different servers. Never change your code!
      - You can save your include scripts by Project as well. 
      Helpful if you want a script that works differently in each project and want to 
        use the same name across projects.

One note about Projects:  NDS will automatically create a project called '__Shared' for you.  This is for any objects or scripts you want to 'Share' across all projects. Feel free to use it but be aware than NDS stores system objects or scripts here as well. They have exceptionally long names so it's doubtful your file names will collide with these system files.

Feel free to change any values in the system objects you desire.  If a system object becomes corrupted, simply delete it and it will be recreated with default values the next time you load the PSNativeDataStore module.

NDS is designed for simplicity and efficiency.  Anything you create in memory then save to disk will be created, automatically.  Watch those typos!

      - If you request a non-existent object from a non-existent project, it is created and exists only in memory.
        When use the Save() the object, both the specified object and project will be created for you.

How can it do this? NDS objects are self-aware!!!
That's right, when you create an in-memory object or load a NDS object from disk, it is aware of it's own location.  Calling the objects Save() method will automatically store to disk for you!  No need remember where separate objects are located.

      - If you copy an object to a different project and load it into your script, it will 'remember' its 
      new location! Each successive save will automatically save to the new project!!  Ain't that just fancy??!?!

#System Requirements
PSNativeDataStore has been tested with the following versions/environments
     - PowerShell v2.0 on Windows 7 Home
     - PowerShell v4.0 on Windows 7 Ultimate
     - Powershell v4.0 on Windows 8.1 Professional
     - PowerShell v4.0 on Windows Server 2008
     
On the Windows Server Installation, Powershell expected the files to be signed even though they were executed locally and the 'remote flag' had been removed.  This is either due to a group policy which superseded my session settings or Microsoft's typical reaction to security flaws where they simply will not allow you to do something.  Changing the execution policy setting to 'Unrestricted' allowed the file to run fine.  Let's face it.  If I have the ability to change the policy, who do they think they are stopping by not allowing the files to run at a security they already state is acceptable??!?!?!?!?

The moral of the story:  Work with your IT group if you are having issues with Windows Server.

#Getting Started
Very important, do this immediately. Even if you are only considering downloading NDS, do it anyway.  The primary component of NDS is an environment variable named  'PSNativeDataStore'
Create this environment variable first thing and assign it the directory path where you want the NDS repository to live.  This will be your root direcctory.  All projects will be created beneath this root directory.  

Do not create the variable from the command line shell unless you know how to promote the change to the system level.  Any changes in your session will only be available for that session.  Not sure what Microsoft was thinking when they decided to create ENVIRONMENT variables that are only available for a SESSION!!!!  (Doesn't sound right, does it?).  Use the Windows GUI for safety.

Next, you will need to save the PSNativeDataStore.psm1 into one of the directories in PSModulePath.  If you are not familiar with modules, just create a directory called 'PSNativeDataStore' in the default PowerShell module directory as shown here:

(windows 7 path)
C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSNativeDataStore   <-- This will make it available to ALL users
Save PSNativeDataStore.psm1 in this directory

For more customized implementation, see the Microsoft documentation on PowerShell Modules

Copy the example files to a folder of your choice.  When you run these files, you will receive a error if you attempt to run them at the execution policy of 'Remote Signed' or higher.  For higher level security, you will need to sign the files to run them.  For 'Remote Signed', you can remove the security flag by right-clicking on the file and selecting 'Properties' from the quick menu.  If the file is blocked, there will be a button at the bottom [General] tab of the Properties dialog box that reads [UnBlock].  (It is grayed out or not displayed if the file is not blocked).  Click this button and your files will now be considered 'local' files and will run without being signed under 'Remote Signed' execution policy.  (Except under Windows Server as specified in the System Requirements section)

You're all set!!!!!!!

#Usage
Three example files are provided to demonstrate the functionality you will use most. (More details can be found in the documentation located in the downloadable project .zip file.  These files primarily concern creating/loading/modifying objects and are commented for you're edification

  - CreateObjectExample.ps1  - Creates/Loads a NDS object
  - TransformObject.ps1 - Turns a user created PSObject into a self-aware NDS Object!!!
  - LoadPSScriptFromNDS - Loads a into your session
                          The script will announce when it is loaded
                          
I hope you find PSNativeDataStore as useful as it is easy.
