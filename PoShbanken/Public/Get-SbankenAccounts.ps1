function Get-SbankenAccounts {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [string]$AccountID
    )
    if ($AccountID) {
        Invoke-SbankenRequest -APIApplication 'exec.bank' -APIEndpoint "Accounts/$AccountID" -Method GET
    } else {
        Invoke-SbankenRequest -APIApplication 'exec.bank' -APIEndpoint "Accounts" -Method GET
    }
}