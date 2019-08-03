$global:_GLOBAL_POWERSHELL_PROMPT = ""

function ActivatePythonEnv($version)
{
    # & cmd /k "activate $version & powershell"
    $_CONDA_EXE_OBJ = Get-Item (Get-Command conda.exe).Path
    $_CONDA_ENV_DIR = Join-Path $_CONDA_EXE_OBJ.Directory.Parent.FullName -ChildPath "envs"
    [string[]]$all_envs_dirs = Get-ChildItem $_CONDA_ENV_DIR -Directory | ForEach-Object { $_.Name } 
    [string[]]$all_envs = $all_envs_dirs | Where-Object { Test-Path (Join-Path $_CONDA_ENV_DIR -ChildPath $_ | Join-Path -ChildPath "python.exe") }
    if ($all_envs.Count -eq 0) {
        Write-Host "No conda virtual environment found!"
        return
    }
    if (!$version) {
        if ($all_envs.Count -eq 1) {
            $version = $all_envs[0]
        } else {
            Write-Host "More than one environment found in $_CONDA_ENV_DIR. Please specify env name exactly."
            return
        }
    }
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
        Write-Host "Environment '$version' not found! Please choice from existed ones."
        Write-Host
        conda env list
        return
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