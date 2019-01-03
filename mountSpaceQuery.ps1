<#  
.SYNOPSIS  
    Retrieves service status information from remote computers, and lets you decide what to do using multiple options.

.DESCRIPTION
    This script has multiple functions which uses Windows Management Instrumentation (WMI) to retrieve service information, from TARGETED remote computer. 
    Computer names or IP addresses are expected as SWITCH CASE input.
    Each computer is contacted sequentially, not in parallel.

.NOTES  
    File Name  : mountSpaceQuery.ps1  
    Author     : Amit Kumar 
    Requires   : PowerShell V2 and above
    
.PARAMETER
    a single computer name or multiple servers. You may also provide IP addresses.
        
.EXAMPLE
    Choose an option to proceed and provide computer name as params and retrieve their service information
    
    mountSpaceQuery.ps1

PS C:\WINDOWS\system32> \\fakepath\scriptlets\mountSpaceQuery.ps1
    
.LINK  
.NOTES
    You need to run this function as a Administrator; doing so is the only way to ensure you have permission to query WMI from the remote computers.

#>
$filename = ".\filename.txt";
$filecontents = Get-Content $filename
$ServerArray = $filecontents
Write-Host $ServerArray

$Data = @()
Foreach ($Server in $ServerArray ) {
    Write-Host "Retrieving services for $Server "
    foreach ($srvr in (Get-WmiObject -ComputerName $Server -Class Win32_Volume )) {
        $Data += New-Object PSObject -Property @{
            'Server' = $srvr.Systemname
            'Drive' = $srvr.DriveLetter
            'VolLabel' = $srvr.Label
            'TotalSpace(gb)' = "{0:N0}" -f ($srvr.Capacity/1gb)
            'UsedSpace(gb)' = "{0:N0}" -f ($srvr.Capacity/1gb) - "{0:N0}" -f ($srvr.FreeSpace/1gb)
            'FreeSpace(gb)' = "{0:N0}" -f ($srvr.FreeSpace/1gb)
            'FreePercent(%)' = "{0:P0}" -f ($srvr.FreeSpace/$srvr.Capacity)
            #'Service Account' = $srvr.StartName
            
        }
        Write-Host $Data | Format-Table -AutoSize
    }
 }
# Write-Host $Data;
 #$Data | Export-Csv ".\test.csv" -NoTypeInformation

$a = "<style>"
$a = $a + "BODY{background-color:#fff;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 10px;border-style: solid;border-color: black;background-color:#eee}"
$a = $a + "</style>"

$head = @"
<style>
body{
    margin: 4px 4px;
    background-color:#f2f2f2;
    font-family:Roboto;
    font-size:10Ppt;
}
table{
    width: 100%;
    border: 1px solid black;
}
td, th {
    padding:2px 2px;
}
th{
    border:1px solid #000;
    color:white;
    background-color:black;
}
td{
    font-family: Roboto;
    font-size: 15px;
    border: 1px solid black;
    padding: 4px 4px;
}
tr{
    bgcolor: #aaa;
}

</style>
"@

##table data-rows
<#
$dataRow = "
    <tr >
        <td>$Data.Server</td>
        <td>$Data.Drive</td>
        <td>$Data.VolLabel</td>
        <td>$Data.TotalSpace(gb)</td>
        <td>$Data.UsedSpace(gb)</td>
        <td>$Data.FreeSpace(gb)</td>
        <td bgcolor='$color'>$Data.FreePercent(%)</td>
    </tr>
#>
#        Add-Content $diskReport $dataRow;

#Add-Content 
$Report = $Data | ConvertTo-Html -Fragment -As Table | Out-String

$Report = $Data.Server,$Data.Drive,$Data.VolLabel,$Data.TotalSpace,$Data.UsedSpace,$Data.FreeSpace,$Data.FreePercent | ConvertTo-Html -Fragment -As Table | Out-String

$body = "Combined Server Service Report$(Get-Date -Format D)"
ConvertTo-Html -head $head -PostContent $Report -Body $body | Out-File ".\disktest.htm"
Invoke-Expression .\disktest.htm
