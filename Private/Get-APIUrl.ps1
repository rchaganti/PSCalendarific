function Get-APIUrl
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Countries','Holidays')]
        [String]
        $RequestType,

        [Parameter()]
        [Hashtable]
        $Parameter
    )

    $nvCollection = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
    foreach ($param in $Parameter.Keys)
    {
        $nvCollection.Add($param, $Parameter.$param)
    }

    $uriRequest = [System.UriBuilder]($baseUrl.$RequestType)
    $uriRequest.Query = $nvCollection.ToString()
    return $uriRequest.Uri.OriginalString
}
