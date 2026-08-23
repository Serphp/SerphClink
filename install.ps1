<#
==================================================================================
 ⚡ SERPH CYBERPUNK TERMINAL SUITE - AUTOMATED INSTALLER ⚡
 Automatically sets up Starship, Clink, Fastfetch, MSYS2, Cyberpunk 2077 HUD & Aliases
==================================================================================
#>

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Stop"

Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Yellow
Write-Host "║   ⚡ SERPH CYBERPUNK 2077 TERMINAL SUITE - AUTOMATED INSTALL ⚡   ║" -ForegroundColor Yellow
Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Yellow

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 1. Rutas de instalacion
$starshipBinDir  = "$HOME\AppData\Local\Programs\starship\bin"
$clinkBinDir     = "$HOME\AppData\Local\Programs\clink"
$clinkStateDir   = "$HOME\AppData\Local\clink"
$fastfetchBinDir = "$HOME\AppData\Local\Programs\fastfetch"
$configDir       = "$HOME\.config"
$psConfigDir     = "$HOME\.config\powershell"

foreach ($dir in @($starshipBinDir, $clinkBinDir, $clinkStateDir, $fastfetchBinDir, $configDir, $psConfigDir)) {
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
}

# 2. Descargar e Instalar Starship
Write-Host "`n[1/8] Verificando Starship..." -ForegroundColor Cyan
if (!(Test-Path "$starshipBinDir\starship.exe")) {
    Write-Host "  -> Descargando ultima version de Starship..." -ForegroundColor Gray
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/starship/starship/releases/latest" -UseBasicParsing
    $asset = $release.assets | Where-Object { $_.name -like "*x86_64-pc-windows-msvc.zip" } | Select-Object -First 1
    $zipPath = "$env:TEMP\starship.zip"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $starshipBinDir -Force
    Remove-Item -Path $zipPath -Force
    Write-Host "  [OK] Starship instalado." -ForegroundColor Green
} else {
    Write-Host "  [OK] Starship ya se encuentra instalado." -ForegroundColor Green
}

# 3. Descargar e Instalar Clink
Write-Host "`n[2/8] Verificando Clink..." -ForegroundColor Cyan
if (!(Test-Path "$clinkBinDir\clink_x64.exe")) {
    Write-Host "  -> Descargando ultima version de Clink..." -ForegroundColor Gray
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/chrisant996/clink/releases/latest" -UseBasicParsing
    $asset = $release.assets | Where-Object { $_.name -match "^clink\..*\.zip$" } | Select-Object -First 1
    $zipPath = "$env:TEMP\clink.zip"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $clinkBinDir -Force
    Remove-Item -Path $zipPath -Force
    Write-Host "  [OK] Clink instalado." -ForegroundColor Green
} else {
    Write-Host "  [OK] Clink ya se encuentra instalado." -ForegroundColor Green
}

# 4. Descargar e Instalar Fastfetch
Write-Host "`n[3/8] Verificando Fastfetch..." -ForegroundColor Cyan
if (!(Test-Path "$fastfetchBinDir\fastfetch.exe")) {
    Write-Host "  -> Descargando ultima version de Fastfetch..." -ForegroundColor Gray
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest" -UseBasicParsing
    $asset = $release.assets | Where-Object { $_.name -match "fastfetch-windows-amd64\.zip$" } | Select-Object -First 1
    $zipPath = "$env:TEMP\fastfetch.zip"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath -UseBasicParsing
    $extractTemp = "$env:TEMP\fastfetch_extract"
    if (Test-Path $extractTemp) { Remove-Item -Path $extractTemp -Recurse -Force }
    Expand-Archive -Path $zipPath -DestinationPath $extractTemp -Force
    $exe = Get-ChildItem -Path $extractTemp -Filter "fastfetch.exe" -Recurse | Select-Object -First 1
    if ($exe) {
        Copy-Item -Path "$($exe.DirectoryName)\*" -Destination $fastfetchBinDir -Recurse -Force
    }
    Remove-Item -Path $zipPath -Force
    Remove-Item -Path $extractTemp -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  [OK] Fastfetch instalado." -ForegroundColor Green
} else {
    Write-Host "  [OK] Fastfetch ya se encuentra instalado." -ForegroundColor Green
}

# 5. Actualizar PATH de Usuario
Write-Host "`n[4/8] Configurando variables de entorno PATH..." -ForegroundColor Cyan
$userPath = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User)
$pathsToAdd = @($starshipBinDir, $clinkBinDir, $fastfetchBinDir)
$modifiedPath = $userPath

foreach ($p in $pathsToAdd) {
    if ($modifiedPath -notlike "*$p*") {
        $modifiedPath = if ($modifiedPath) { "$modifiedPath;$p" } else { $p }
    }
    if ($env:PATH -notlike "*$p*") {
        $env:PATH = "$p;$env:PATH"
    }
}
if ($modifiedPath -ne $userPath) {
    [Environment]::SetEnvironmentVariable("PATH", $modifiedPath, [EnvironmentVariableTarget]::User)
}
Write-Host "  [OK] PATH actualizado." -ForegroundColor Green

# 6. Configurar Clink para CMD
Write-Host "`n[5/8] Configurando Clink y Starship en CMD..." -ForegroundColor Cyan
& "$clinkBinDir\clink_x64.exe" autorun install | Out-Null
& "$clinkBinDir\clink_x64.exe" set autosuggest.enable true | Out-Null

Set-Content -Path "$clinkStateDir\starship.lua" -Value 'load(io.popen("starship init cmd"):read("*a"))()' -Encoding UTF8

$serphCmdPath = "$scriptDir\serph.cmd"
$serphLuaLines = @(
    "-- SerphClink auto-loader for Clink CMD",
    'local userprofile = os.getenv("USERPROFILE")',
    'if userprofile then',
    '    local serph_cmd = userprofile .. [[\Desktop\Bryan}\Programacion\SerphClink\serph.cmd]]',
    '    os.execute("call \"" .. serph_cmd .. "\" >nul 2>&1")',
    'end'
)
Set-Content -Path "$clinkStateDir\serph_init.lua" -Value ($serphLuaLines -join "`r`n") -Encoding UTF8
Write-Host "  [OK] Clink autorun y scripts Lua configurados." -ForegroundColor Green

# 7. Desplegar temas y atajos
Write-Host "`n[6/8] Desplegando configuraciones Cyberpunk 2077 y atajos..." -ForegroundColor Cyan
if (Test-Path "$scriptDir\starship.toml") {
    Copy-Item "$scriptDir\starship.toml" "$configDir\starship.toml" -Force
}
if (Test-Path "$scriptDir\serph_aliases.ps1") {
    Copy-Item "$scriptDir\serph_aliases.ps1" "$psConfigDir\serph_aliases.ps1" -Force
}
Write-Host "  [OK] Archivos starship.toml y serph_aliases.ps1 desplegados." -ForegroundColor Green

# 8. Configurar Perfiles de PowerShell
Write-Host "`n[7/8] Configurando perfiles de PowerShell..." -ForegroundColor Cyan
$profilePaths = @(
    "$HOME\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\OneDrive\Documents\PowerShell\Microsoft.PowerShell_profile.ps1",
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)

$cleanProfileLines = @(
    "# Ensure Starship and Fastfetch are in PATH",
    'if ($env:PATH -notlike "*AppData\Local\Programs\starship\bin*") {',
    '    $env:PATH = "$HOME\AppData\Local\Programs\starship\bin;$env:PATH"',
    '}',
    'if ($env:PATH -notlike "*AppData\Local\Programs\fastfetch*") {',
    '    $env:PATH = "$HOME\AppData\Local\Programs\fastfetch;$env:PATH"',
    '}',
    "",
    "# Starship Prompt Initialization",
    'if (Get-Command starship -ErrorAction SilentlyContinue) {',
    '    Invoke-Expression (&starship init powershell)',
    '}',
    "",
    "# Serph Cyberpunk Toolkit (Aliases & Functions)",
    'if (Test-Path "$HOME\.config\powershell\serph_aliases.ps1") {',
    '    . "$HOME\.config\powershell\serph_aliases.ps1"',
    '}'
)
$cleanProfile = $cleanProfileLines -join "`r`n"

foreach ($path in $profilePaths) {
    $parent = Split-Path $path -Parent
    if (!(Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    $prefix = ""
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        if ($content -match "CommandNotFound") {
            $prefix = "# PowerToys CommandNotFound module`r`nImport-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction SilentlyContinue`r`n`r`n"
        }
    }
    Set-Content -Path $path -Value ($prefix + $cleanProfile) -Encoding UTF8
}

# 9. Configurar MSYS2 e Integracion con Windows Terminal
Write-Host "`n[8/8] Verificando MSYS2 e integracion con Windows Terminal..." -ForegroundColor Cyan
if (Test-Path "C:\msys64") {
    # Configurar /etc/nsswitch.conf para usar /home/kali
    $nsswitch = "# Begin /etc/nsswitch.conf`r`n`r`npasswd: files db`r`ngroup: files db`r`n`r`ndb_enum: cache builtin`r`n`r`ndb_home: /home/kali`r`ndb_shell: cygwin desc`r`ndb_gecos: cygwin desc`r`n`r`n# End /etc/nsswitch.conf"
    Set-Content -Path "C:\msys64\etc\nsswitch.conf" -Value $nsswitch -Encoding UTF8
    
    # Asegurar /home/kali y configurar .bashrc
    $msysHomeKali = "C:\msys64\home\kali"
    if (!(Test-Path $msysHomeKali)) { New-Item -ItemType Directory -Path $msysHomeKali -Force | Out-Null }
    
    $msysBashrc = "$msysHomeKali\.bashrc"
    $bashrcAddons = @(
        "# Ensure Windows tools are reachable",
        'export PATH="$PATH:/c/Users/serph.KALI/AppData/Local/Programs/starship/bin:/c/Users/serph.KALI/AppData/Local/Programs/fastfetch:/c/Users/serph.KALI/AppData/Local/Programs/Antigravity IDE/bin"',
        "",
        "# Fastfetch Banner",
        'if command -v fastfetch >/dev/null 2>&1; then',
        '    fastfetch',
        'fi',
        "",
        "# Starship Prompt (Cyberpunk 2077 HUD)",
        'if command -v starship >/dev/null 2>&1; then',
        '    export STARSHIP_CONFIG="/c/Users/serph.KALI/.config/starship.toml"',
        '    eval "$(starship init bash)"',
        'fi'
    ) -join "`n"
    
    if (Test-Path $msysBashrc) {
        $bContent = Get-Content $msysBashrc -Raw
        if ($bContent -notmatch "STARSHIP_CONFIG") {
            Add-Content -Path $msysBashrc -Value "`n$bashrcAddons" -Encoding UTF8
        }
    } else {
        Set-Content -Path $msysBashrc -Value $bashrcAddons -Encoding UTF8
    }
    
    # Registrar perfil en Windows Terminal
    $wtSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    if (Test-Path $wtSettings) {
        try {
            $wtJson = Get-Content $wtSettings -Raw -Encoding UTF8 | ConvertFrom-Json
            $msysGuid = "{17bf3dda-0000-4b96-b633-8a306443c988}"
            $exists = $wtJson.profiles.list | Where-Object { $_.guid -eq $msysGuid -or $_.name -like "*MSYS2*" }
            if (!$exists) {
                $msysProfile = [PSCustomObject]@{
                    guid             = $msysGuid
                    name             = "MSYS2 (UCRT64)"
                    commandline      = "C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64"
                    icon             = "C:\msys64\ucrt64.ico"
                    startingDirectory= "%USERPROFILE%"
                    hidden           = $false
                }
                $wtJson.profiles.list += $msysProfile
                $wtJson | ConvertTo-Json -Depth 32 | Set-Content $wtSettings -Encoding UTF8
                Write-Host "  [OK] Perfil MSYS2 registrado en Windows Terminal." -ForegroundColor Green
            } else {
                Write-Host "  [OK] Perfil MSYS2 ya presente en Windows Terminal." -ForegroundColor Green
            }
        } catch {}
    }
    Write-Host "  [OK] MSYS2 configurado con /home/kali y Starship." -ForegroundColor Green
} else {
    Write-Host "  [INFO] C:\msys64 no encontrado. Omitiendo configuracion de MSYS2." -ForegroundColor Gray
}

# 10. Wrappers para Antigravity IDE (si existe)
$agyDir = "$HOME\AppData\Local\Programs\Antigravity IDE\bin"
if (Test-Path $agyDir) {
    Set-Content -Path "$agyDir\agy.cmd" -Value "@echo off`r`n`"%~dp0antigravity-ide.cmd`" %*" -Encoding ASCII
    Set-Content -Path "$agyDir\antigravity.cmd" -Value "@echo off`r`n`"%~dp0antigravity-ide.cmd`" %*" -Encoding ASCII
}

Write-Host "`n══════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  ✔ INSTALACION COMPLETADA CON EXITO." -ForegroundColor Green
Write-Host "  Abre una nueva terminal (PowerShell, CMD o MSYS2) para disfrutar!" -ForegroundColor Green
Write-Host "══════════════════════════════════════════════════════════════════`n" -ForegroundColor Green
