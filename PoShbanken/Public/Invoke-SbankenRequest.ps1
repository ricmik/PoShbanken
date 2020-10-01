function Invoke-SbankenRequest {
    [CmdletBinding()]
    param (
        [string]$APIApplication,
        [string]$APIEndpoint,
        [string]$APIVersion = 'v1',
        $Parameters,
        $Body,
        [ValidateSet("GET","POST")][string]$Method
    )
    
    begin {
        Write-Verbose "Checking if Connect-Sbanken has been run successfully."
        if(!$Script:SbankenConnection) {
            Write-Error "Not connected to Sbanken"
            break
        }
        $Headers = @{
            'customerId' = $SbankenConnection.customerID
            'Authorization' = "Bearer $($SbankenConnection.access_token)"
        }
    }
    
    process {
        $APIUrl = "$($SbankenConnection.apiUrl)" + "$APIApplication" + "/api/$APIVersion/"  + "$APIEndpoint"
        try {
            if($Method -eq "GET") {
                $Response = Invoke-RestMethod -Uri $APIUrl -Headers $Headers -Method $Method -body $parameters
            }
        }
        catch {
            
        }
    }
    
    end {
        if($Response.items) {
            $Response.items
        }
        elseif($Response.item) {
            $Response.item
        }
    }
}


