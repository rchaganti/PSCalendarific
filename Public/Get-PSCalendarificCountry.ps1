Function Get-PSCalendarificCountry
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [String]
        $APIKey
    )

    # get the API Store defaults
    $calendarific = Get-PSCalendarificDefaultConfiguration

    # Check if API Key is provided
    if (!$APIKey)
    {
        if ($calendarific.APIKey -ne '')
        {
            $apiKey = $calendarific.APIKey
        }
        else
        {
            throw 'Cannot continue as API Key is neither provided nor available in the API Store'
        }
    }

    # create a param hashtable
    $paramHashtable = @{
        api_key = $APIKey
    }

    $requestUrl = Get-APIUrl -RequestType Countries -Parameter $paramHashtable -Verbose
    $response = Invoke-RestMethod -Uri $requestUrl -UseBasicParsing

    if ($response.meta.code -eq 200)
    {
        $response.response.Countries
    }
}
