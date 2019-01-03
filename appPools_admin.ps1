<#
.Synopsis
   Get IIS application pool status
.DESCRIPTION
   The function would provide IIS application pool status
.EXAMPLE
   Get-AppPool -Server server1,server2 -Pool powershell
.FUNCTIONALITY
   It uses Microsoft.Web.Administration assembly to get the status
#>

function Get-AppPool {
  [CmdletBinding()]
  param
  (
    [string[]]$Server,
    [String]$Pool
  )
#region loadAssembly 

[Reflection.Assembly]::LoadWithPartialName('Microsoft.Web.Administration')

#endregion loadAssembly
#$Server = "W1571622"
$Server = "W1752238"
$Pool = '*Pool*'
foreach ($s in $server)
{  
$sm = [Microsoft.Web.Administration.ServerManager]::OpenRemote($s)
$apppools = $sm.ApplicationPools["$pool"]

$apppools = $sm.

$PoolName = $apppools.
$status = $apppools.State

$stat = $apppools.Status

      $info = @{
        'Pool Name'=$PoolName;
        'Status'=$status;
        'Server'=$S;
      }

      Write-Output (New-Object –Typename PSObject –Prop $info)
      #Write-Host $s;
      
      }

      
    }
    
    Get-AppPool