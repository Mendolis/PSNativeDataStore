<##################################################################################################
    Create Object Example

    You can create an object with Get-NDSObject.  PSNativeDataStore will always create any project
    or object specified.

    NOTE:  When the object is first created it exists only in memory.  Use the Save() method to 
            created the object and project permanently on disk.

    Use the Add-Member cmdlet to add properties as shown below.
    The script will error if one of the properties you attempt to add already exists.

##################################################################################################>
clear-host

$prj = 'Inspector1'
$obj = 'tester3'
 
Import-Module -Name PSNativeDataStore -DisableNameChecking

$tester3 = Get-NDSObject -projectname $prj -objectname $obj


if( -not ($tester3.PSObject.Properties['First'] ) )
{
    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name First -Value "This is the first value"
}

if( -not ($tester3.PSObject.Properties['First'] ) )
{
    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name Second -Value 5490393854
}

if( -not ($tester3.PSObject.Properties['First'] ) )
{
    Add-Member -InputObject $tester3 -MemberType NoteProperty -Name third -Value "And now for something completely different"
}

$tester3.Save()
