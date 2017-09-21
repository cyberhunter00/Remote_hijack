#
# NetworkDeviceDiscovery.ps1
#

$Community = 'SCOM_******' #Community string configured on the network device for the SCOM monitoring  

$IpList = Get-Content  C:\Users\Christopher\Desktop\Network\list.txt
$ExportFile = "C:\Users\Christopher\Desktop\Network\export.csv"

$myArray = @()

foreach($ip in $Iplist)
       {
       write-output $IP     
       $SNMP = new-object -ComObject olePrn.OleSNMP 
       $snmp.open($ip,$community,2,1000)   

       $Available = $null
       $Available = $snmp.Get(".1.3.6.1.2.1.1.5.0")

       if($Available -ne $null)
              {
              $SysName = $snmp.Get(".1.3.6.1.2.1.1.5.0")
              $SysDescription = $snmp.Get(".1.3.6.1.2.1.1.1.0")  
              $SysObjectID = $snmp.Get(".1.3.6.1.2.1.1.2.0") 
              $SysContact = $snmp.Get(".1.3.6.1.2.1.1.4.0")  
              $SysLocation = $snmp.Get(".1.3.6.1.2.1.1.6.0")
              $SNMP.Close()
                     
              write-output "SysName : $SysName"
              Write-output "SysDescription : $SysDescription"  
              Write-output "SysObjectID : $SysObjectID "
              Write-output "SysContact : $SysContact" 
              Write-output "SysLocation : $SysLocation" 

              $obj = New-object PSObject
              Add-member -inputObject $obj -name SysName -MemberType NoteProperty -value $SysName
              Add-member -inputObject $obj -name SysDescription -MemberType NoteProperty -value $SysDescription
              Add-member -inputObject $obj -name SysObjectID -MemberType NoteProperty -value $SysObjectID 
              Add-member -inputObject $obj -name SysContact -MemberType NoteProperty -value $SysContact
              Add-member -inputObject $obj -name SysLocation -MemberType NoteProperty -value $SysLocation
              Add-member -inputObject $obj -name IP -MemberType NoteProperty -value $IP
              $myArray += $obj
              }
       else{

              $obj = New-object PSObject
              Add-member -inputObject $obj -name SysName -MemberType NoteProperty -value $null
              Add-member -inputObject $obj -name SysDescription -MemberType NoteProperty -value $null
              Add-member -inputObject $obj -name SysObjectID -MemberType NoteProperty -value $null
              Add-member -inputObject $obj -name SysContact -MemberType NoteProperty -value $null
              Add-member -inputObject $obj -name SysLocation -MemberType NoteProperty -value $null
              Add-member -inputObject $obj -name IP -MemberType NoteProperty -value $IP
              $myArray += $obj
       }
}

$myArray | Export-Csv -NoTypeInformation $ExportFile
