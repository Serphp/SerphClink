<#
==================================================================================
 ⚡ SERPH CYBERPUNK TERMINAL SUITE - AUTOMATED INSTALLER ⚡
 Automatically sets up Starship, Clink, Fastfetch, Cyberpunk 2077 HUD & Serph Aliases
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
Write-Host "`n[1/7] Verificando Starship..." -ForegroundColor Cyan
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
Write-Host "`n[2/7] Verificando Clink..." -ForegroundColor Cyan
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
Write-Host "`n[3/7] Verificando Fastfetch..." -ForegroundColor Cyan
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
Write-Host "`n[4/7] Configurando variables de entorno PATH..." -ForegroundColor Cyan
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
Write-Host "`n[5/7] Configurando Clink y Starship en CMD..." -ForegroundColor Cyan
& "$clinkBinDir\clink_x64.exe" autorun install | Out-Null
& "$clinkBinDir\clink_x64.exe" set autosuggest.enable true | Out-Null

Set-Content -Path "$clinkStateDir\starship.lua" -Value 'load(io.popen("starship init cmd"):read("*a"))()' -Encoding UTF8

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
Write-Host "`n[6/7] Desplegando configuraciones Cyberpunk 2077 y atajos..." -ForegroundColor Cyan
if (Test-Path "$scriptDir\starship.toml") {
    Copy-Item "$scriptDir\starship.toml" "$configDir\starship.toml" -Force
}
if (Test-Path "$scriptDir\serph_aliases.ps1") {
    Copy-Item "$scriptDir\serph_aliases.ps1" "$psConfigDir\serph_aliases.ps1" -Force
}
Write-Host "  [OK] Archivos starship.toml y serph_aliases.ps1 desplegados." -ForegroundColor Green

# 8. Configurar Perfiles de PowerShell
Write-Host "`n[7/7] Configurando perfiles de PowerShell..." -ForegroundColor Cyan
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

# 9. Wrappers para Antigravity IDE (si existe)
$agyDir = "$HOME\AppData\Local\Programs\Antigravity IDE\bin"
if (Test-Path $agyDir) {
    Set-Content -Path "$agyDir\agy.cmd" -Value "@echo off`r`n`"%~dp0antigravity-ide.cmd`" %*" -Encoding ASCII
    Set-Content -Path "$agyDir\antigravity.cmd" -Value "@echo off`r`n`"%~dp0antigravity-ide.cmd`" %*" -Encoding ASCII
}

Write-Host "`n══════════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  ✔ INSTALACION COMPLETADA CON EXITO." -ForegroundColor Green
Write-Host "  Abre una nueva terminal (PowerShell o CMD) para disfrutar de tu entorno!" -ForegroundColor Green
Write-Host "══════════════════════════════════════════════════════════════════`n" -ForegroundColor Green
