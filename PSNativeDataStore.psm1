<##################################################################################################
    PowerShell Native Data Store
    A simple and effective method for accessing PowerShell scripts and storing PowerShell objects.
    Especially, effective for storing data that is specific to an environment!
        (ie, storing database connections, drive mappings, file paths and computer names unique
            whatever environment your in )

    It is designed for speed and efficency and, as such, does not go overboard with error checking.
    After all, you're smart enough to use PowerShell.  We're sure you can handle the one simple 
    initialization step:

    -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   
    
            CREATE AN ENVIRONMENT VARIABLE NAMED 'PSNativeDataStore' 
            AND POINT IT TO A DIRECTORY OF YOUR CHOICE!!!!
    
    -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   -- CRITICAL --   

    Help only provided for top-level users functions.  Others were created to support a specific
    aspect of this module and are not meant for stand-only use.
##################################################################################################>

###############################################################################
##  initialization - all data held in repository object to decrease chances of
##  duplicate naming and provide single source of all data
###############################################################################

## Repository object - Maintains session attributes
$psnativedatastoreeattributerepository = New-Object –TypeName PSObject –Property @{
    'Path' = $null;
    'SharedPathName' = '__Shared'
    'LogToConsole' = $true;
    'LogToFile' = $false;              ## Considering log files in future.  Not sure whether they are worth it.
    'LogFile' = $null
}

##############################################################
##   Function Declarations
##############################################################

## Central Message output control
## Determines whether display to screen, send to logfile or neither
function Make-NDSReport( $msg )
{
    if( $psnativedatastoreeattributerepository.LogToConsole )
    {
        Write-Host $msg
    }
}

#####################
## The following functions build paths for us to keep them consistent
#####################
## Build and return path to project directory
function Get-NDSProjectPath( $projectname )
{
    return "$($psnativedatastoreeattributerepository.Path)\$projectname"
}

## Build and return path to data objects
function Get-NDSProjectDataPath( $projectname )
{
    return "$(Get-NDSProjectPath -projectname $projectname)\data"
}

## Build and return path to script objects
function Get-NDSProjectScriptPath( $projectname )
{
    return "$(Get-NDSProjectPath -projectname $projectname)\script"
}

## Build and return path to project object
function Get-NDSObjectPath( $projectname, $objectname )
{
    return "$(Get-NDSProjectDataPath -projectname $projectname)\$objectname.clixml"
}

## Build and return path to project script
function Get-NDSScriptPath( $projectname, $scriptname )
{
    return "$(Get-NDSProjectScriptPath -projectname $projectname)\$scriptname"
}

#####################
## Native Data Store Worker Functions
## These are the only functions exported in the module
#####################


function Get-NDSObject
{
<# 
   .Description 
    Retrieves a PSNativeDataStore object from disk
    If the object does not exist, it will be created in memory with basic properties.
    The object will not be created on disk until saved
   .Example 
    Get-NDSObject -projectname MyNewProject -objectname configurations
   .Parameter projectname
    Name of the project this objects belongs
   .Parameter objectname
    Name of the object to load
   .Notes 
    NAME:  Get-NDSObject
    AUTHOR: Jerry W. Francis II.
    LASTEDIT: 01/08/2015
    KEYWORDS: PSNativeDataStore, Persistent storage, Object Store
 #Requires -Version 2.0 
 #> 
 [CmdletBinding()] 
 Param( 
  [Parameter(Position=0, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $projectname, 
  [Parameter(Position=1, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $objectname
 ) 
    $pospath = Get-NDSObjectPath -projectname $projectname -objectname $objectname
    if( (Test-Path $pospath) )
    {
        $posobject = Import-Clixml -Path "$pospath"
    }
    else
    {
        $posobject = New-Object –TypeName PSObject 
    }
    TransformTo-NDSObject -inputobject $posobject -projectname $projectname -objectname $objectname
    
    return $posobject
}


function Load-NDSScript
{
<# 
   .Synopsis 
    Retrieves and instantiates a PowerShell Script
   .Description 
    Retrieves and instantiates a PowerShell Script
    
    NOTE: Extention must be provided with script name
    This is the same as dot sourcing a file but it uses the 
    data store structure to store the script. This provides
    two benefits over dot sourcing
    - You can have the same script name in multiple projects
    - Most importantly, the script can be in different locations on 
      different servers but requires no change to your code to access
   .Example 
    Load-NDSScript -projectname MyNewProject -scriptname "MyCommonScripts.ps1"
   .Parameter projectname
    Name of the project this objects belongs
   .Parameter scriptname
    Name of the script to load
   .Notes 
    NAME:  Load-NDSScript
    AUTHOR: Jerry W. Francis II.
    LASTEDIT: 01/08/2015
    KEYWORDS: PSNativeDataStore, Persistent storage, Script Store
 #Requires -Version 2.0 
 #> 
 [CmdletBinding()] 
 Param( 
  [Parameter(Position=0, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $projectname, 
  [Parameter(Position=1, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $scriptname
 ) 
    $scriptfile = Get-NDSScriptPath -project $projectname -scriptname $scriptname  ## .ps1 required.  Microsoft may change extension in future
    .($scriptfile)    
}


function TransformTo-NDSObject
{
<# 
   .Description 
    Turns a user object into a PSNativeDataStore object
    Will not error if passed an existing PSNativeStore object
   .Example 
    TransformTo-NDSObject -inputobject <PSObject> -projectname <string> -objectname <string>
   .Parameter inputobject
    The object to transform. Maybe any object inherited from PSObject
   .Parameter projectname
    Name of the project this object belongs
   .Parameter objectname
    Name of the object within the NDS repository. It is the file name on disk
   .Notes 
    NAME:  TransformTo-NDSObject
    AUTHOR: Jerry W. Francis II.
    LASTEDIT: 01/08/2015
    KEYWORDS: PSNativeDataStore, Persistent storage, Script Store
 #Requires -Version 2.0 
 #> 
 [CmdletBinding()] 
 Param( 
  [Parameter(Position=0, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $inputobject, 
  [Parameter(Position=1, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $projectname, 
  [Parameter(Position=2,
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $objectname
 ) 
    if( -not ($inputobject.PSObject.Properties['NDSProject'] ) )
    {    
        Add-Member -inputobject $inputobject -MemberType NoteProperty -Name NDSProject -Value $projectname
    }

    if( -not ($inputobject.PSObject.Properties['NDSObject'] ) )
    {    
        Add-Member -inputobject $inputobject -MemberType NoteProperty -Name NDSObject -Value $objectname
    }

    if( -not ($inputobject.PSObject.Properties['NDSCreated'] ) )
    {    
        Add-Member -inputobject $inputobject -MemberType NoteProperty -Name NDSCreated -Value $(Get-Date)
    }

    if( -not ($inputobject.PSObject.Properties['NDSUpdated'] ) )
    {    
        Add-Member -inputobject $inputobject -MemberType NoteProperty -Name NDSUpdated -Value $(Get-Date)
    }

    if( -not ($inputobject.PSObject.Properties['NDSGUID'] ) )
    {    
        Add-Member -inputobject $inputobject -MemberType NoteProperty -Name NDSGUID -Value $([System.Guid]::NewGuid())
    }
    
    $savescript = { 
        Make-NDSProject -projectname $this.NDSProject   ## Insure the full project structure is created
        $objectpath = Get-NDSProjectDataPath -projectname $this.NDSProject
        Make-NDSSafeDIR -path $objectpath               ## Insure full object path is created
        $fullobjectpath = Get-NDSObjectPath -projectname $this.NDSProject -objectname $this.NDSObject
        Export-Clixml -Path $fullobjectpath -InputObject $this   ## Save object in native Powershell clixml
    }
    
    
    ## add self-save method
    if( -not ($inputobject.PSObject.Methods['Save'] ) )
    {
        Add-Member -InputObject $inputobject -MemberType ScriptMethod -Name 'Save' -Value $savescript
    }
}




## Create a new project - if exists, will not return error
## This exists if user wants to create multiple projects all at once (w/o need to create object)
function Make-NDSProject
{
 <# 
   .Synopsis 
    Creates a NDSProject directory in the repository
   .Description 
    Creates NDSProject directory in the repository.  Projects are normally created
    with objects.  This cmdlet is made available to create multiple projects at a time.
   .Example 
    Make-NDSProject -projectname MyNewProject
   .Parameter projectname
    Name of the project this object belongs
   .Notes 
    NAME:  Make-NDSProject
    AUTHOR: Jerry W. Francis II.
    LASTEDIT: 01/08/2015
    KEYWORDS: PSNativeDataStore, Persistent storage, Project
 #Requires -Version 2.0 
 #> 
 [CmdletBinding()] 
 Param( 
  [Parameter(Position=0, 
      Mandatory=$True, 
      ValueFromPipeline=$True)] 
      $projectname
 )
    Make-NDSSafeDIR -path $(Get-NDSProjectDataPath -projectname $projectname )
    Make-NDSSafeDIR -path $(Get-NDSProjectScriptPath -projectname $projectname )
}


## I find it ignorant that the mkdir function errors if the directory already exists.
## Sure, it has its purpose --- but is it really an error if the result is what I want?
## This function checks first then creates if not in existence.  (The way mkdir should work)
function Make-NDSSafeDIR( $path )
{
    if( -not (Test-Path -Path $path) )
    {
        mkdir $path | Out-Null
    }
}


##############################################################
##   Initialization Script
##############################################################

## Test if environment variable is set - stop processing if not
if( -not (Test-Path Env:\PSNativeDataStore) )
{
    Make-NDSReport "------------------------------------------------------------`n" 
    Make-NDSReport '   The environment variable ENV:PSNativeDataStore' 
    Make-NDSReport '   has not been initialized. Set this environment variable' 
    Make-NDSReport '   to the location where the files will be stored' 
    Make-NDSReport "`n------------------------------------------------------------"
    break
}
else   ## variable is set
{
    $psnativedatastoreeattributerepository.Path = $env:PSNativeDataStore

    ## Remove trailing backslash if exists - all functions expect this
    if( $psnativedatastoreeattributerepository.Path[-1] -eq '\' )
    {
        $psnativedatastoreeattributerepository.Path = $psnativedatastoreeattributerepository.Path.Substring(0, $psnativedatastoreeattributerepository.Path.Length - 1 )
    }
} 

##############################################################
##   At this point you're rip, roarin' and ready to go
##############################################################
