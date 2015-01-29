
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
      - You can save your include scripts by Project as well.  Helpful if you want a sript that works differently in each project to have the same name.

Did you know? NDS objects are self-aware!!!
Thats right, when you create or load a NDS object from disk, it is aware of it's own location.  Calling the objects Save() method will automatically store to disk for you!  Not need remember where separate objects are located.

      - If you copy an object to a different project and load it into your script, it will 'remember' it's new location and automatically save to the new project!!  Ain't that just fancy

#Getting Started

  - CreateObjectExample.ps1
      
  - 
