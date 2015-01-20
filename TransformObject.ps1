<##################################################################################################
    Takes a user created object, transforms it to Native Data Store object.  
    
    This transformation adds a few extra properties and the Save() method. (self-aware feature)
##################################################################################################>
clear-host

Remove-Module -Name PSNativeDataStore 
Import-Module -Name PSNativeDataStore -DisableNameChecking

$prj = 'Inspector1'
$obj = 'tester4'
$properties = @{
    'BreakFast' = 'burger'
    'Lunch' = 'burger'
    'Supper' = 'I will gladly pay you Tuesday for a hamburger today'
}

## Create an object
$test4 = New-Object –TypeName PSObject –Property $properties

## Convert to a PS Native Data Store object 
TransformTo-NDSObject -inputobject $test4 -projectname $prj -objectname $obj 

## Now object has ability to save itself
$test4.Save()



