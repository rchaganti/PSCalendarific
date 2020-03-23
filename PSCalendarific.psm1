$apiStore = "${env:AppData}\Calendarific"
$storeFile = "$apiStore\Calendarific.json"

$baseUrl = @{
    Holidays = 'https://calendarific.com/api/v2/holidays'
    Countries = 'https://calendarific.com/api/v2/countries'
}

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\ -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

Foreach($import in @($Public + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename