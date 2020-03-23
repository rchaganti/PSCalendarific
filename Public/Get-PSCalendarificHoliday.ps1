function Get-PSCalendarificHoliday
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [String]
        $APIKey,

        [Parameter()]
        [String]
        $Country ='US',

        [Parameter()]
        [Int]
        $Year,

        [Parameter()]
        [ValidateRange(1,12)]
        [Int]
        $Month,

        [Parameter()]
        [ValidateRange(1,31)]
        [Int]
        $Day,

        [Parameter()]
        [ValidateSet('national','local','religious','observance')]
        [String]
        $Type
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

    if ($calendarific.Country)
    {
        $country = $calendarific.Country
    }

    if (!$Year)
    {
        $Year = Get-Date -Format yyyy
    }

    # create a param hashtable
    $paramHashtable = @{
        api_key = $APIKey
        country = $Country
        year = $Year
    }

    if ($Month)
    {
        $paramHashtable.Add('month', $Month)
    }

    if ($Day)
    {
        $paramHashtable.Add('day', $Day)
    }

    if ($Type)
    {
        $paramHashtable.Add('type', $Type)
    }

    $requestUrl = Get-APIUrl -RequestType Holidays -Parameter $paramHashtable -Verbose
    $response = Invoke-RestMethod -Uri $requestUrl -UseBasicParsing

    if ($response.meta.code -eq 200)
    {
        $response.response.Holidays
    }
}
