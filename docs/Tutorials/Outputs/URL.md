# URL

This page details the output actions available to redirect users to other URLs.

## Move

You can redirect a user to another URL by using [`Move-PodeWebUrl`](../../../Functions/Outputs/Move-PodeWebUrl):

```powershell
New-PodeWebContainer -NoBackground -Content @(
    New-PodeWebButton -Name 'GitHub' -ScriptBlock {
        Move-PodeWebUrl -Url 'https://github.com'
    }
)
```

The URL can be opened in a new tab via the `-NewTab` switch.
