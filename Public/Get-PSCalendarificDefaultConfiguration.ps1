function Get-PSCalendarificDefaultConfiguration
{
    [CmdletBinding()]
    param
    (
    )

    if (Test-Path -Path $apiStore)
    {
        if (Test-Path -Path $storeFile)
        {
            $calendarific = Get-Content -Path $storeFile -Raw | ConvertFrom-Json
            return $calendarific
        }
        else
        {
            Write-Verbose -Message 'Store file does not exist'
        }
    }
    else
    {
        Write-Verbose -Message 'API Store folder does not exist'
    }
}
