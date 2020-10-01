function Connect-Sbanken {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true,
            HelpMessage = "Personnummer")]
        [int64]$CustomerID,
        [parameter(Mandatory = $true,
            HelpMessage = "Client ID from the API page")]
        [string]$ClientID,
        [parameter(Mandatory = $true,
            HelpMessage = "Secret from the API page")]
        [string]$Secret
    )
    $AuthUrl = 'https://auth.sbanken.no/identityserver/connect/token'
    $APIUrl = 'https://api.sbanken.no/'

    $URLEncodedClientID = [System.Web.HTTPUtility]::UrlEncode($ClientID)
    $URLEncodedSecret = [System.Web.HTTPUtility]::UrlEncode($Secret)
    $EncodedAuthString = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($URLEncodedClientID + ':' + $URLEncodedSecret))
    [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($EncodedAuthString))
    $Headers = @{
        'Accept'        = 'application/json'
        'Content-Type'  = 'application/x-www-form-urlencoded'
        'Authorization' = "Basic $EncodedAuthString"
    }
    $Body = @{
        'grant_type' = 'client_credentials'
    }
    $json = Invoke-RestMethod -Uri $AuthUrl -Headers $Headers -Method Post -Body $Body

    New-Variable -Name 'SbankenConnection' -Scope Script -Visibility Private -Value @{
        access_token = $json.access_token
        customerID   = $CustomerID
        expires      = (Get-Date).AddSeconds($json.expires_in)
        scope        = $json.scope
        apiUrl       = $APIUrl
    }
}