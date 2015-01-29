<##################################################################################################
    Create Object Example

    You can create an object with Get-NDSObject.  PSNativeDataStore will always create any project
    or object specified.

    NOTE:  When the object is first created it exists only in memory.  Use the Save() method to 
            create the object and project permanently on disk.

    Use the Add-Member cmdlet to add properties as shown below.
    The script will error if one of the properties you attempt to add already exists.

##################################################################################################>
clear-host

$prj = 'Inspector1'
$obj = 'tester3'
 
### Load PSNativeDataStore!

Import-Module -Name PSNativeDataStore -DisableNameChecking


### Get-NDSObject retrieves an existing object from disk, if it exists
### If not, it will create an empty NDS object - just add your own properties

$tester3 = Get-NDSObject -projectname $prj -objectname $obj


### If object did not exist, it will not contain only default NDS properties
### In the following section will add any properties that are missing.
### Note:  If the properties already exist, the script will abort
### The following examples shows you how to test for the property and assign if missing


if( -not ($tester3.PSObject.Properties['First'] ) )  ## test if property exists for this object.
{
    ## Add the non-existing property using Add-Member

    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name First -Value "This is the first value"
}

if( -not ($tester3.PSObject.Properties['Second'] ) )
{
    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name Second -Value 5490393854
}


### Note in this example, we are testing for 'Third' with a capitial T but are creating 'third' with a small 't'
### This is strictly for example to show you principals of PowerShell  (It will also alert us if Microsoft changes something in future!!!! - because you know they will)

if( -not ($tester3.PSObject.Properties['Third'] ) )
{
    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name third -Value "And now for something completely different"
}


### Permanently save this object to the Project named 'Inspector1'... feel free to Inspect this directory :)
$tester3.Save()
