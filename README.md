# PowerShell wrapper around the Calendarific API
[Calendarific](https://calendarific.com/) offers a webservice for listing holidays from different countries. They also have an API that can be used by developers to implement this holiday queries in the their own applications. 

Accessing this API requires an API key which can be registered for free at https://calendarific.com/signup.

This module is a wrapper around the Calendarific API. You can install the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/PSCalendarific/1.0.0.0).

```powershell
Install-Module -Name PSCalendarific -Force
```

The following commands are available in this module.

```powershell
PS C:\> Get-Command -Module PSCalendarific

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-PSCalendarificCountry                          1.0.0.0    PSCalendarific
Function        Get-PSCalendarificDefaultConfiguration             1.0.0.0    PSCalendarific
Function        Get-PSCalendarificHoliday                          1.0.0.0    PSCalendarific
Function        Register-PSCalendarificDefaultConfiguration        1.0.0.0    PSCalendarific
Function        Unregister-PSCalendarificDefaultConfiguration      1.0.0.0    PSCalendarific
```

### Register-PSCalendarificDefaultConfiguration

This command helps set the parameter defaults for accessing the API. At present, this command supports only storing APIKey and Country values as default configuration. API key must always be provided and the `Get-PSCalendarificHoliday` requires Country name as well for listing the holidays. Therefore, these configuration settings can be stored locally so that other commands in the module can be used without explicitly providing any of these parameters. 

> Note: Storing API key on local filesystem is not a good practice.

```powershell
PS C:\> Register-PSCalendarificDefaultConfiguration -APIKey '1562567d51443af046079a9bca8a84a358e2c393' -Country IN -Verbose
WARNING: This command stores specified parameters in a local file. API Key is sensitive information. If you do not 
prefer this, use Unregister-PSCalendarificDefaultConfiguration -APIKey to remove the API key from the store.
```

This command has no mandatory parameters. You can specify either APIKey or Country or both. When you need to update either configuration parameters, just specify the parameter you want to update.

### Unregister-PSCalendarificDefaultConfiguration

 This command helps you remove the stored API key or just delete the configuration store itself.

```powershell
Unregister-PSCalendarificDefaultConfiguration -APIKey -Verbose
```

 If you do not specify any parameters, the configuration store gets deleted.

### Get-PSCalendarificDefaultConfiguration

This command gets the stored defaults from the configuration store.

```powershell
PS C:\> Get-PSCalendarificDefaultConfiguration -Verbose
APIKey                                   Country
------                                   -------
1562567d51443af046079a9bca8a84a358e2c393 IN
```

### Get-PSCalendarificHoliday

This command lists all holidays for a given country based on the parameters supplied. If you do not provide any parameters, this commands tries to find and use the default parameter values from the configuration store.

```powershell
Get-PSCalendarificHoliday
```

The following are different parameters supported with this command.

| Parameter Name | Description                                     | Default Value                                                |
| -------------- | ----------------------------------------------- | ------------------------------------------------------------ |
| APIKey         | Key to access the API                           | No default Value. When not specified, the command will try to use the default parameter from configuration store. |
| Country        | Country                                         | No default Value. When not specified, the command will try to use the default parameter from configuration store. |
| Year           | Year for which the holidays need to be listed   | The command internally defaults to the current year.         |
| Month          | Month for which the holidays need to be listed. | No default value but the valid values are 1 .. 12            |
| Day            | Day for which the holidays need to be listed.   | No default value but the valid values are 1 .. 31.           |
| Type           | Type of holidays                                | No default value but the valid values are national, local, religious, and observance. |

