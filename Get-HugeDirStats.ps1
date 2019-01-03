function Get-HugeDirStats($directory) {
    function go($dir, $stats)
    {
        foreach ($f in [system.io.Directory]::EnumerateFiles($dir))
        {
            $stats.Count++
            $stats.Size += (New-Object io.FileInfo $f).Length
        }
        foreach ($d in [system.io.directory]::EnumerateDirectories($dir))
        {
            go $d $stats
        }
    }
    $statistics = New-Object PsObject -Property @{Count = 0; Size = [long]0 }
    go $directory $statistics

    $statistics
}

#example
#$stats = Get-HugeDirStats c:\windows
$stats = Get-HugeDirStats C:\Users\ak045346\Documents\CWx