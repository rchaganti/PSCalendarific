function Register-PSCalendarificDefaultConfiguration
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [String]
        $APIKey,

        [Parameter()]
        [String]
        $Country
    )

    # if none of the parameters are provided, there is no need to go forward
    if (!$APIKey -and !$Country)
    {
        Write-Verbose -Message 'Nothing to add to or update the store'
        return
    }
    else
    {
        if (!(Test-Path -Path $apiStore))
        {
            $null = New-Item -Path $apiStore -ItemType Directory -Force
        }

        # Check if the Calendarific.json exists under the API Store
        if (!(Test-Path -Path $storeFile))
        {
            # we are creating the api store for the first time
            $calendarific = [PSCustomObject]@{
                APIKey = $APIKey
                Country = $Country
            }
        }
        else
        {
            # store file exists; we need to read and update
            $calendarific = Get-Content -Path $storeFile -Raw | ConvertFrom-Json

            if ($APIKey)
            {
                $calendarific.APIKey = $APIKey
            }

            if ($Country)
            {
                $calendarific.Country = $Country
            }
        }

        # save the file
        Write-Warning -Message 'This command stores specified parameters in a local file. API Key is sensitive information. If you do not prefer this, use Unregister-PSCalendarificDefaultConfiguration -APIKey to remove the API key from the store.'
        $calendarific | ConvertTo-Json | Out-File -FilePath $storeFile -Force
    }
}
