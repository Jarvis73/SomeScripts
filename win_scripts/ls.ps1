Import-Module "DirColors"   # Install-Module -Name DirColors
Update-DirColors "$PSScriptRoot\dircolors"

function Get-ChildItem-Wide {

    $width =  $host.UI.RawUI.WindowSize.Width
    $pad = 2

    # get the longest string and get the length
    $childs = Get-ChildItem $Args
    # $lnStr = $childs | select-object Name | sort-object { "$_".length } -descending | select-object -first 1
    $lnStr = $childs | Select-Object Name | Sort-Object { $_.Name.Length + ([regex]::Matches($_.Name, "[\u4e00-\u9fa5]")).count } -Descending | Select-Object -First 1
    $len = $lnStr.name.length + ([regex]::Matches($lnStr.name, "[\u4e00-\u9fa5]")).count

    $childs |
    ForEach-Object {
        $curFile = Format-ColorizedFilename($_)
        $output = $curFile + (" "*($len - $_.Name.Length - ([regex]::Matches($_.Name.Length, "[\u4e00-\u9fa5]")).count + $pad))
        $count += $len + $pad

        Write-Host $output -nonewline

        if ( $count -ge ($width - ($len+$pad)) ) {
          Write-Host ""
          $count = 0
      }
  }
}

Set-Alias -Name ls -Value Get-ChildItem-Wide -option AllScope -Scope Global