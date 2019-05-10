$global:_GLOBAL_POWERSHELL_PROMPT = ""

function ActivatePythonEnv($version)
{
    # & cmd /k "activate $version & powershell"
    $_CONDA_EXE_OBJ = Get-Item (Get-Command conda.exe).Path
    $_CONDA_ENV_DIR = Join-Path $_CONDA_EXE_OBJ.Directory.Parent.FullName -ChildPath "envs"
    $_CONDA_PREFIX = Join-Path $_CONDA_ENV_DIR -ChildPath $version
    if (Test-Path $_CONDA_PREFIX) {
        $env:CONDA_DEFAULT_ENV = $version
        $env:CONDA_EXE = $_CONDA_EXE_OBJ.FullName
        $env:CONDA_PREFIX = $_CONDA_PREFIX
        $env:CONDA_PYTHON_EXE = Join-Path $_CONDA_EXE_OBJ.Directory.Parent -ChildPath "python.exe"
        if ($env:CONDA_SHLVL) {
            $global:_GLOBAL_POWERSHELL_PROMPT = $global:_GLOBAL_POWERSHELL_PROMPT.SubString($env:CONDA_PROMPT_MODIFIER.Length)
        }
        else {
            $env:PATH_BACKUP = $env:PATH
        }
        $env:Path = $env:CONDA_PREFIX + ";" + 
                    $env:CONDA_PREFIX + "\Library\mingw-w64\bin;" + 
                    $env:CONDA_PREFIX + "\Library\usr\bin;" + 
                    $env:CONDA_PREFIX + "\Library\bin;" +
                    $env:CONDA_PREFIX + "\Scripts;" +
                    $env:CONDA_PREFIX + "\bin;" +
                    $env:Path
        $env:PYTHONIOENCODING=936
        $env:CONDA_PROMPT_MODIFIER = "($version) "
        $global:_GLOBAL_POWERSHELL_PROMPT = $env:CONDA_PROMPT_MODIFIER + $global:_GLOBAL_POWERSHELL_PROMPT
        $env:CONDA_SHLVL=1
    }
    else {
        Write-Host "Environment $version not found!"
    }
}

function DeactivatePythonEnv()
{
    if ($env:CONDA_SHLVL -eq 1) {
        $global:_GLOBAL_POWERSHELL_PROMPT = $global:_GLOBAL_POWERSHELL_PROMPT.SubString($env:CONDA_PROMPT_MODIFIER.Length)
        Remove-Item env:CONDA_PROMPT_MODIFIER
        Remove-Item env:CONDA_DEFAULT_ENV
        Remove-Item env:CONDA_EXE
        Remove-Item env:CONDA_PREFIX
        Remove-Item env:CONDA_PYTHON_EXE
        Remove-Item env:CONDA_SHLVL
        $env:PATH = $env:PATH_BACKUP
        Remove-Item env:PATH_BACKUP
    }
}