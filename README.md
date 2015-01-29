
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
      - You can save your include scripts by Project as well. 
      Helpful if you want a sript that works differently in each project to have the same name.

NDS is designed for simplicity and efficiency.  Anything you create in memory then save to disk will be created, automatically.

      - If you request a non-existent object from a non-existent project, it is created and exists only in memory.
        When use the Save() the object, both the specified object and project will be created for you.

How can it do this? NDS objects are self-aware!!!
Thats right, when you create an in-memory object or load a NDS object from disk, it is aware of it's own location.  Calling the objects Save() method will automatically store to disk for you!  No need remember where separate objects are located.

      - If you copy an object to a different project and load it into your script, it will 'remember' its 
      new location. Each successive save will automatically save to the new project!!  Ain't that just fancy??!?!

#Getting Started
Very important, do this immediately. Even if you are only considering downloading NDS, do it anyway.  The primary component of NDS is an environment variable named  'PSNativeDataStore'  
Create this environment variable first thing and assign it the directory path where you want the NDS repository to live.  This will be your root direcctory.  All projects will be created beneath this root directory.  

Do not do this from the command line unless you know how to promote the change to the system level.  Any changes in your session will only be available for your session.  Not sure what Microsoft was thinking when they decided to create ENVIRONMENT variables that are only available for a SESSION!!!!  (Doesn't sound right, does it?)

Next, you will need to save the PSNativeDataStore.psm1 into one of the directories in PSModulePath.  If you are not familiar with modules, just create a directory called 'PSNativeDataStore' to the default PowerShell module directory as shown here:

(windows 7 path)
C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSNativeDataStore   <-- Create this sub-dir
Save PSNativeDataStore.psm1 in this directory

You're all set

#Usage
Three example files are provided to demonstrate the functionality you will use most. (More details can be found in the documentation located in the downloadable project .zip file.  These files primarily concern creating/loading/modifying objects and are commented for you're edification

  - CreateObjectExample.ps1  - Creates/Loads a NDS object
  - TransformObject.ps1 - Turns a user created PSObject into a self-aware NDS Object!!!
  - LoadPSScriptFromNDS - Creates a test script in the repository then loads into your session
                          The script will announce when it is loaded
                          
I hope you find PSNativeDataStore as useful as it is easy.
