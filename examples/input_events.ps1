Import-Module Pode -MaximumVersion 2.99.99 -Force
Import-Module ..\src\Pode.Web.psm1 -Force

Start-PodeServer -Threads 2 {
    # add a simple endpoint
    Add-PodeEndpoint -Address localhost -Port 8090 -Protocol Http
    New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    # set the use of templates, and set a login page
    Use-PodeWebTemplates -Title 'Input Events' -Theme Dark


    # select event
    $select = New-PodeWebContainer -Content @(
        New-PodeWebText -Value 'Please select a value: '
        New-PodeWebSelect -Name 'Bellows' -NoForm -Options 'Bellow 1', 'Bellow 2', 'Bellow 3' |
            Register-PodeWebEvent -Type Change -ScriptBlock {
                Move-PodeWebAccordion -Name $WebEvent.Data['Bellows']
            }
    )

    $acc1 = New-PodeWebAccordion -Bellows @(
        New-PodeWebBellow -Name 'Bellow 1' -Icon 'information' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 2' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 3' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
    )

    Add-PodeWebPage -Name 'Select' -Layouts $select, $acc1


    # textbox event
    $textbox = New-PodeWebContainer -Content @(
        New-PodeWebText -Value 'Search for processes: '
        New-PodeWebTextbox -Name 'Filter' -NoForm |
            Register-PodeWebEvent -Type KeyUp -ScriptBlock {
                Get-Process -Name "*$($WebEvent.Data['Filter'])*" |
                    Sort-Object -Property CPU -Descending |
                    Select-Object -First 15 -Property Name, ID, WorkingSet, CPU |
                    Update-PodeWebTable -Name 'Processes'
            }
        New-PodeWebLine
        New-PodeWebTable -Name 'Processes'
    )

    Add-PodeWebPage -Name 'Textbox' -Layouts $textbox


    # range event
    $range = New-PodeWebContainer -Content @(
        New-PodeWebText -Value 'Move the slider: '
        New-PodeWebRange -Name 'Value' -NoForm |
            Register-PodeWebEvent -Type Change -ScriptBlock {
                Update-PodeWebText -Id 'txt_value' -Value $WebEvent.Data['Value']
            }
        New-PodeWebLine
        New-PodeWebText -Id 'txt_value' -Style Bold -Value '0'
    )

    Add-PodeWebPage -Name 'Range' -Layouts $range


    # radio event
    $radio = New-PodeWebContainer -Content @(
        New-PodeWebText -Value 'Select options: '
        New-PodeWebRadio -Name 'Options' -NoForm -Options 'Bellow 1', 'Bellow 2', 'Bellow 3' |
            Register-PodeWebEvent -Type Change -ScriptBlock {
                Move-PodeWebAccordion -Name $WebEvent.Data['Options']
            }
    )

    $acc2 = New-PodeWebAccordion -Bellows @(
        New-PodeWebBellow -Name 'Bellow 1' -Icon 'information' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 2' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 3' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
    )

    Add-PodeWebPage -Name 'Radio' -Layouts $radio, $acc2


    # checkbox event
    $checkbox = New-PodeWebContainer -Content @(
        New-PodeWebText -Value 'Select options: '
        New-PodeWebCheckbox -Name 'Options' -NoForm -Options 'Bellow 1', 'Bellow 2', 'Bellow 3' |
            Register-PodeWebEvent -Type Change -ScriptBlock {
                Move-PodeWebAccordion -Name $WebEvent.Data['Options']
            }
    )

    $acc3 = New-PodeWebAccordion -Bellows @(
        New-PodeWebBellow -Name 'Bellow 1' -Icon 'information' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 2' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
        New-PodeWebBellow -Name 'Bellow 3' -Content @(
            New-PodeWebText -Value 'Some random text' -InParagraph
        )
    )

    Add-PodeWebPage -Name 'Checkbox' -Layouts $checkbox, $acc3
}