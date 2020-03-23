Function Unregister-PSCalendarificDefaultConfiguration
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [Switch]
        $APIKey
    )

    if (Test-Path -Path $apiStore)
    {
        if (Test-Path -Path $storeFile)
        {
            $calendarific = Get-Content -Path $storeFile -Raw | ConvertFrom-Json

            if ($APIKey)
            {
                Write-Verbose -Message 'Removing API Key from the store file'
                $calendarific.APIKey = ''

                # Save the changes
                $calendarific | ConvertTo-Json | Out-File -FilePath $storeFile -Force                
            }
            else
            {
                Write-Verbose -Message 'Deleting the store file'
                Remove-Item -Path $storeFile -Force
            }
        }
        else
        {
            Write-Verbose -Message 'Store file does not exist'
        }
    }
}
