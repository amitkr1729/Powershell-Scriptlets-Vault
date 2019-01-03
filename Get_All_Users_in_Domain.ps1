# Script source: www.itbigbang.com
# Description: This script will search and find all active directory users in particular domain
# How to use this script: http://www.itbigbang.com/how-to-list-all-active-directory-users-in-a-particular-domain-using-powershell/

# Create New Directory Service Object
$objDomain = New-Object System.DirectoryServices.DirectoryEntry "LDAP://dc=test,dc=com"

$Result = Get-QADUser -SearchRoot $objDomain.distinguishedName -LdapFilter "(proxyAddresses=smtp:*@test.com)" | Get-QADUser | Select Email,SamAccountName,DisplayName,Name
IF($Result)
{
$Ouput = $Result.Email+","+$Result.SamAccountName+","+$Result.ProxyAddresses+","+$Result.DisplayName
$Ouput >> Output.txt
}