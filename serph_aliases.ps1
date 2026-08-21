# ==============================================================================
#  ⚡ SERPH CYBERPUNK TOOLKIT - POWERSHELL ALIASES & FUNCTIONS ⚡
# ==============================================================================

# Ayuda y Configuracion
function serph-help {
    Write-Host "`n⚡ SERPH CYBERPUNK TOOLKIT - ATAJOS DISPONIBLES ⚡`n" -ForegroundColor Yellow
    [PSCustomObject]@{
        "Navegacion"   = "root, d, dt, doc, music, pic, vid, home, p, rt, .., ..., ...."
        "Productividad"= "v (code .), ag (agy .), o (explorer), c (clear), s (start)"
        "Git Basico"   = "gs (status), gst (status -s), ga (add), gaa (add -A), gc (commit), gp (push)"
        "Git Avanzado" = "gl (log), glg (grafico visual), gco (checkout), gcb (new branch), gundo (undo commit)"
        "NPM / Bun"    = "ni (install), ns (start), nrd (dev), nrb (build), buni, bund, pni, pnd"
        "Prisma/Flutter"= "np (generate), npmd (migrate), nps (studio), fr (run), fb (build), fd (doctor)"
        "Python"       = "py2, py3, pmr (django), serve (http server), venv, act (activate)"
        "Docker"       = "dps, dpsa, dimg, dcu (compose up), dcd (down), dlogs"
        "Red / Procesos"= "ifconfig, myip, ports (ver puertos), psg <nombre>, sudo"
        "Multimedia"   = "yt, ytmp3, ythd"
    } | Format-List
}
Set-Alias -Name aliases -Value serph-help -Option AllScope -ErrorAction SilentlyContinue

# ------------------------------------------------------------------------------
# ⚡ Navegacion & Sistema
# ------------------------------------------------------------------------------
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function root { Set-Location "C:\" }
function d { Set-Location "$HOME\Downloads" }
function dt { Set-Location "$HOME\Desktop" }
function doc { Set-Location "$HOME\Documents" }
function music { Set-Location "$HOME\Music" }
function pic { Set-Location "$HOME\Pictures" }
function vid { Set-Location "$HOME\Videos" }
function home { Set-Location $HOME }
function p { Set-Location "$HOME\Desktop\Bryan}\Programacion" }
function rt { Set-Location "$HOME\Desktop\Bryan}\Programacion\Proyectos\React" }

function o { Start-Process explorer.exe -ArgumentList "." }
function v { code . }
function vs { code $args }
function ag { antigravity-ide . }
function agy { antigravity-ide $args }
function antigravity { antigravity-ide $args }
function c { Clear-Host }
function s { Start-Process . }

# Listado
function ll { Get-ChildItem -Force | Format-Table Mode, Length, LastWriteTime, Name -AutoSize }
function la { Get-ChildItem -Force }

# ------------------------------------------------------------------------------
# ⚡ Git & Control de Versiones
# ------------------------------------------------------------------------------
function gs { git status $args }
function gst { git status -s $args }
function ga { git add $args }
function gaa { git add -A $args }
function gc { git commit -m "$args" }
function gcam { git commit -a -m "$args" }
function gcr { git commit --amend -m "$args" }
function gp { git push $args }
function gpp { git push --set-upstream origin master $args }
function gpo { git push origin HEAD $args }
function gpl { git pull $args }
function gpr { git pull --rebase origin main $args }
function gb { git branch $args }
function gba { git branch -a $args }
function gck { git checkout main $args }
function gco { git checkout $args }
function gcb { git checkout -b $args }
function gz { git switch $args }
function gm { git merge --no-ff $args }
function gl { git log --oneline $args }
function glg { git log --graph --oneline --decorate --all $args }
function gsta { git stash $args }
function gstp { git stash pop $args }
function grm { git remote rm origin $args }
function gundo { git reset --soft HEAD~1 $args }

# ------------------------------------------------------------------------------
# ⚡ Desarrollo Web (NPM, PNPM, Bun, Prisma, Flutter)
# ------------------------------------------------------------------------------
function ni { npm install $args }
function ns { npm start $args }
function nrd { npm run dev $args }
function nrb { npm run build $args }
function nu { npm uninstall $args }
function nf { npm audit fix $args }
function nff { npm audit fix --force $args }

function pni { pnpm install $args }
function pnd { pnpm dev $args }
function pnb { pnpm build $args }
function pnu { pnpm remove $args }

function buni { bun install $args }
function bund { bun dev $args }
function bunb { bun run build $args }

function np { npx prisma generate $args }
function npmd { npx prisma migrate dev --name $args }
function npmm { npx prisma migrate dev --create-only $args }
function nps { npx prisma studio $args }

function fr { flutter run $args }
function fb { flutter build $args }
function fd { flutter doctor $args }
function fpub { flutter pub get $args }

# ------------------------------------------------------------------------------
# ⚡ Python
# ------------------------------------------------------------------------------
function py2 { py -2 $args }
function py3 { py -3 $args }
function pmr { python manage.py runserver $args }
function serve { python -m http.server 8080 $args }
function venv { python -m venv .venv }
function act { 
    if (Test-Path .\.venv\Scripts\Activate.ps1) {
        . .\.venv\Scripts\Activate.ps1
    } elseif (Test-Path .\venv\Scripts\Activate.ps1) {
        . .\venv\Scripts\Activate.ps1
    } else {
        Write-Warning "No virtualenv found (.venv or venv)."
    }
}

# ------------------------------------------------------------------------------
# ⚡ Docker
# ------------------------------------------------------------------------------
function dps { docker ps $args }
function dpsa { docker ps -a $args }
function dimg { docker images $args }
function dcu { docker compose up -d $args }
function dcd { docker compose down $args }
function dlogs { docker compose logs -f $args }
function dstop { docker stop $args }

# ------------------------------------------------------------------------------
# ⚡ Redes, Servicios & Procesos
# ------------------------------------------------------------------------------
function ifconfig { ipconfig $args }
function myip { (Invoke-RestMethod -Uri "https://ifconfig.me/ip" -UseBasicParsing).Trim() }
function myip1 { (Invoke-RestMethod -Uri "https://ipinfo.io/ip" -UseBasicParsing).Trim() }
function ports { netstat -ano | findstr LISTENING }
function psg ($name) { Get-Process | Where-Object { $_.Name -like "*$name*" } }
function sudo { Start-Process powershell -Verb RunAs }
function poweroff { Stop-Computer -Force }
function reboot { Restart-Computer -Force }

# ------------------------------------------------------------------------------
# ⚡ Multimedia (yt-dlp)
# ------------------------------------------------------------------------------
function yt { yt-dlp $args }
function ytmp3 { yt-dlp -x --audio-format mp3 --embed-thumbnail $args }
function ythd { yt-dlp -f bestvideo+bestaudio $args }

# Fastfetch
function ff { fastfetch $args }
function neofetch { fastfetch $args }

# Ejecutar Fastfetch al inicio de PowerShell
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch
}


