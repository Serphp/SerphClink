@echo off

doskey /listsize=10000
title Serphp Console x

rem ==============================================================================
rem  ? CONFIGURACION & AYUDA
rem ==============================================================================
DOSKEY sphp=notepad "%~f0"
DOSKEY sphp2=notepad "%USERPROFILE%\Desktop\Bryan}\Programacion\SerphClink\serph.cmd"
DOSKEY reload="%~f0"
DOSKEY aliases=doskey /macros
DOSKEY serph-help=doskey /macros

rem ==============================================================================
rem  ? NAVEGACION & PRODUCTIVIDAD
rem ==============================================================================
DOSKEY h=doskey /history
DOSKEY q=exit
DOSKEY c=cls
DOSKEY o=explorer .
DOSKEY v=code .
DOSKEY ag=antigravity-ide .
DOSKEY agy=antigravity-ide $*
DOSKEY antigravity=antigravity-ide $*
DOSKEY vs=code $*
DOSKEY s=start . $*

rem Rutas Rapidas
DOSKEY root=cd /d "C:\"
DOSKEY d=cd /d "%USERPROFILE%\Downloads"
DOSKEY dt=cd /d "%USERPROFILE%\Desktop"
DOSKEY doc=cd /d "%USERPROFILE%\Documents"
DOSKEY music=cd /d "%USERPROFILE%\Music"
DOSKEY pic=cd /d "%USERPROFILE%\Pictures"
DOSKEY vid=cd /d "%USERPROFILE%\Videos"
DOSKEY prog=cd /d "%PROGRAMFILES%"
DOSKEY home=cd /d "%USERPROFILE%"
DOSKEY cd~=cd /d "%USERPROFILE%"
DOSKEY p=cd /d "%USERPROFILE%\Desktop\Bryan}\Programacion"
DOSKEY rt=cd /d "%USERPROFILE%\Desktop\Bryan}\Programacion\Proyectos\React"
DOSKEY 1=cd /d "E:\ProgramData\Serphp\Tools"
DOSKEY 2=cd /d "E:\ProgramData\Serphp\Fuzz & Payloads"

rem Navegacion de Directorios Superior
DOSKEY ..=cd ..
DOSKEY ...=cd ..\..
DOSKEY ....=cd ..\..\..

rem Listado de Archivos (Compatible con GNU tools o Windows)
DOSKEY ll=ls -la --group-directories-first --color=auto 2>nul || dir /q
DOSKEY la=ls -A --color=auto 2>nul || dir /a
DOSKEY lsd=ls -d */ 2>nul || dir /ad
DOSKEY lt=ls -ltr --color=auto 2>nul || dir /od
DOSKEY lr=ls -lR --color=auto 2>nul || dir /s

rem Operaciones de Archivos
DOSKEY rm=rm -r $*
DOSKEY rf=rm -rf $*
DOSKEY dr=rmdir /s /q $*
DOSKEY cp=cp -r $*

rem ==============================================================================
rem  ? GITHUB & CONTROL DE VERSIONES
rem ==============================================================================
DOSKEY gs=git status $*
DOSKEY gst=git status -s $*
DOSKEY ga=git add $*
DOSKEY gaa=git add -A $*
DOSKEY gc=git commit -m $*
DOSKEY gcam=git commit -a -m $*
DOSKEY gcr=git commit --amend -m $*
DOSKEY gp=git push $*
DOSKEY gpp=git push --set-upstream origin master $*
DOSKEY gpo=git push origin HEAD $*
DOSKEY gpl=git pull $*
DOSKEY gpr=git pull --rebase origin main $*
DOSKEY gb=git branch $*
DOSKEY gba=git branch -a $*
DOSKEY gck=git checkout main $*
DOSKEY gco=git checkout $*
DOSKEY gcb=git checkout -b $*
DOSKEY gz=git switch $*
DOSKEY gm=git merge --no-ff $*
DOSKEY gl=git log --oneline $*
DOSKEY glg=git log --graph --oneline --decorate --all $*
DOSKEY gsta=git stash $*
DOSKEY gstp=git stash pop $*
DOSKEY grm=git remote rm origin $*
DOSKEY gundo=git reset --soft HEAD~1 $*

rem ==============================================================================
rem  ? DESARROLLO WEB (NPM, PNPM, YARN, BUN)
rem ==============================================================================
rem NPM
DOSKEY ni=npm install $*
DOSKEY ns=npm start $*
DOSKEY nrd=npm run dev $*
DOSKEY nrb=npm run build $*
DOSKEY nu=npm uninstall $*
DOSKEY nf=npm audit fix $*
DOSKEY nff=npm audit fix --force $*
DOSKEY npx=npx $*

rem PNPM
DOSKEY pni=pnpm install $*
DOSKEY pnd=pnpm dev $*
DOSKEY pnb=pnpm build $*
DOSKEY pnu=pnpm remove $*

rem Bun
DOSKEY buni=bun install $*
DOSKEY bund=bun dev $*
DOSKEY bunb=bun run build $*

rem Prisma ORM
DOSKEY np=npx prisma generate $*
DOSKEY npmd=npx prisma migrate dev --name $*
DOSKEY npmm=npx prisma migrate dev --create-only $*
DOSKEY nps=npx prisma studio $*

rem Flutter
DOSKEY fr=flutter run $*
DOSKEY fb=flutter build $*
DOSKEY fd=flutter doctor $*
DOSKEY fpub=flutter pub get $*

rem ==============================================================================
rem  ? PYTHON & SERVIDORES LOCALES
rem ==============================================================================
DOSKEY py2=py -2 $*
DOSKEY py3=py -3 $*
DOSKEY pmr=python manage.py runserver $*
DOSKEY serve=python -m http.server 8080 $*
DOSKEY venv=python -m venv .venv
DOSKEY act=.venv\Scripts\activate

rem ==============================================================================
rem  ? DOCKER & CONTENEDORES
rem ==============================================================================
DOSKEY dps=docker ps $*
DOSKEY dpsa=docker ps -a $*
DOSKEY dimg=docker images $*
DOSKEY dcu=docker compose up -d $*
DOSKEY dcd=docker compose down $*
DOSKEY dlogs=docker compose logs -f $*
DOSKEY dstop=docker stop $*

rem ==============================================================================
rem  ? REDES, SERVICIOS & PROCESOS
rem ==============================================================================
DOSKEY ifconfig=ipconfig
DOSKEY myip=curl -s ifconfig.me
DOSKEY myip1=curl -s ipinfo.io/ip
DOSKEY wget=wget -c $*
DOSKEY ports=netstat -ano ^| findstr LISTENING
DOSKEY nsg=netstat -nao ^| findstr /i $*
DOSKEY psg=tasklist ^| findstr /i $*
DOSKEY pspath=wmic process get processid,parentprocessid,executablepath
DOSKEY sudo=runas /user:administrator $*
DOSKEY poweroff=shutdown /s /t 0 /f
DOSKEY reboot=shutdown /r /t 0 /f

rem ==============================================================================
rem  ? MULTIMEDIA & DESCARGAS (yt-dlp)
rem ==============================================================================
DOSKEY ytu=yt-dlp -U
DOSKEY yt=yt-dlp $*
DOSKEY ytmp3=yt-dlp -x --audio-format mp3 --embed-thumbnail $*
DOSKEY ythd=yt-dlp -f bestvideo+bestaudio $*

rem ==============================================================================
rem  ? BUSQUEDAS AVANZADAS (GREP / AUDITORIA / SEGURIDAD)
rem ==============================================================================
DOSKEY dff=diff --suppress-common-lines --side-by-side --ignore-space-change $*
DOSKEY grip=grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" $*
DOSKEY gremail=grep -E -o -r "[A-Za-z0-9][A-Za-z0-9._%+-]+@[A-Za-z0-9][A-Za-z0-9.-]+\.[A-Za-z]{2,6}" $*
DOSKEY grpath=grep -Po "^.[^.]+\.[a-zA-Z]{3}$|^.[^.]+\.[a-zA-Z]{2}\.[a-zA-Z]{2}$" $*
DOSKEY grsu=grep -Eo ".*\.bat|.*\.cmd|.*\.class|.*\.exe|.*\.jar|.*\.js|.*\.jse|.*\.SCR|.*\.VBE|.*\.vbs|.*\.reg|.*\.ps1|.*\.psm1" $*
DOSKEY grex=grep -Eo "^.*(exe|dll|bat|sys|htm|html|js|jar|jpg|png|vb|scr|pif|chm|zip|rar|cab|pdf|doc|docx|ppt|pptx|xls|xlsx|swf|gif).*" $*
DOSKEY grsn=grep -Eo "^.*(pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user).*" $*
DOSKEY grurl=grep -Eo "[a-zA-Z]+://[-a-zA-Z0-9.]+(?:/[-a-zA-Z0-9+&@#/%=~_|!:,.;]*)?(?:\?[a-zA-Z0-9+&@#/%=~_|!:,.;]*)?" $*
DOSKEY gruser=grep -Po "([a-z0-9\-._~%!$&'()*+,;=]+@)?" $*
DOSKEY grfind=grep -RnisI $*
DOSKEY grfindx=grep -H -n $*
DOSKEY remove-e=grep . $*
DOSKEY remove-d=awk -F"|" "!_[$2]++"
DOSKEY findsql-url=python %sqlmapa% --batch --technique=BTE -v 3 --crawl=8 --threads=5 --random-agent --dbms="mysql|mssql|postgresql|orcale" --level=5 --risk=3 -u $*
DOSKEY findsql-list=python %sqlmapa% --batch --technique=BTE -v 3 --crawl=8 --threads=5 --random-agent --dbms="mysql|mssql|postgresql|orcale" --level=5 --risk=3 -m $*
DOSKEY sql-layzy=python %sqlmapa% --forms --batch --crawl=15 --threads=10 -u $*

rem ==============================================================================
rem  ? HERRAMIENTAS ADICIONALES
rem ==============================================================================
DOSKEY javar=java -Xmx345M -jar $*
DOSKEY laragon="C:\laragon\laragon.exe" $*
DOSKEY hosts="E:\ProgramData\Serphp\Tools\HostsFileEditor1.2\HostsFileEditor.exe" $*

echo [OK] SerphClink Cyberpunk Toolkit cargado. Escribe 'aliases' o 'serph-help' para ver atajos.

