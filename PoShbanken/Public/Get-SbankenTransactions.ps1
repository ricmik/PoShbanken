function Get-SbankenTransactions {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$AccountID,
        [datetime]$StartDate,
        [datetime]$EndDate
    )
    Begin {
        $parameters = @{
            length = '1000'
        } 
        if ($StartDate) { $parameters.Add('startDate', "$($StartDate.ToString('yyyy-MM-dd'))") }
        if ($EndDate) { $parameters.Add('endDate', "$($EndDate.ToString('yyyy-MM-dd'))") }
    }
    Process {
        Invoke-SbankenRequest -APIApplication 'exec.bank' -APIEndpoint "Transactions/$AccountID" -parameters $parameters -Method GET
    }
    End {}
}


