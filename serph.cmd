@echo off

doskey /listsize=10000
title Serphp Console x
rem cd /d "%USERPROFILE%\Desktop\"


DOSKEY sphp2=notepad "E:\ProgramData\Serphp\serphp.cmd" $*
DOSKEY sphp=notepad "C:\serph.cmd" $*

DOSKEY h=doskey /history 
DOSKEY q=exit
DOSKEY s=start . */
doskey c=cd "C:\"
DOSKEY d=cd "%UserProfile%\downloads"
DOSKEY p=cd "C:/Users/serph/OneDrive/Escritorio/Bryan}/Programacion"
rem DOSKEY a=cd "C:\Users\serph\StudioProjects"

DOSKEY ws=cd "C:\Program Files\JetBrains\WebStorm 2023.3.5\bin\webstorm64.exe" $*

DOSKEY 1=cd "E:\ProgramData\Serphp\Tools"
DOSKEY 2=cd "E:\ProgramData\Serphp\Fuzz & Payloads"
DOSKEY wget=wget -c $*

DOSKEY p2="C:\Python27\Python2.exe" $*
DOSKEY p3="C:\Python38\python38.exe" $*
DOSKEY sudo=runas /user:administrator $*

DOSKEY pmr=python manage.py runserver $*

DOSKEY ni=npm install $*
DOSKEY ns=npm start $*
DOSKEY nrd=npm run dev $*
DOSKEY nrb=npm run build $*
DOSKEY nu=npm uninstall $*
DOSKEY nf=npm audit fix $*
DOSKEY nff=npm audit fix --force $*

DOSKEY grm=git remote rm origin $*

DOSKEY gaa=git add * $*
DOSKEY ga=git add $*

DOSKEY gcr=git commit --amend -m $*
DOSKEY gc=git commit -m $*

DOSKEY gpr=git pull --rebase origin main $*
DOSKEY gck=git checkout main $*

DOSKEY gm=git merge --no-ff $*


DOSKEY gz=git switch $*
DOSKEY gs=git status $*
DOSKEY gst=git status -s $*
DOSKEY gb=git brach $*
DOSKEY gl=git log --oneline $*
DOSKEY gp=git push $*
DOSKEY gpp=git push --set-upstream origin master $*

DOSKEY fr=flutter run $*
DOSKEY fb=flutter build $*
DOSKEY fd=flutter doctor $*

rem DOSKEY np=npx prisma generate $*
rem DOSKEY npmd=npx prisma migrate dev --name $*
rem DOSKEY npmm=npx prisma migrate dev --create-only $*

DOSKEY rt=cd "%UserProfile%\OneDrive\Escritorio\Bryan}\Programacion\Proyectos\React"

DOSKEY pspath=wmic process get processid,parentprocessid,executablepath
DOSKEY psg=tasklist | findstr /i $*
DOSKEY nsg=netstat -nao | findstr /i $* 


DOSKEY serve=python -m SimpleHTTPServer 8080

DOSKEY ..=cd .. $t ls -Al --color=auto
DOSKEY ...=cd ../.. $t ls -Al --color=auto
DOSKEY ....=cd ../../.. $t ls -Al --color=auto

DOSKEY lsd=ls -d */
DOSKEY ll=ls -l --group-directories-first --color=auto
DOSKEY la=ls -Al --color=auto 
DOSKEY lx=ls -lXB --color=auto
DOSKEY lk=ls -lSr --color=auto
DOSKEY lc=ls -ltcr --color=auto
DOSKEY lu=ls -ltur --color=auto
DOSKEY lt=ls -ltr --color=auto 
DOSKEY lr=ls -lR --color=auto

doskey dr=rmdir $*
DOSKEY rm=rm -r $*
doskey rf=rm -rf $*

DOSKEY cd~=cd "%USERPROFILE%"
DOSKEY home=cd "%USERPROFILE%"
DOSKEY dt=cd "%UserProfile%\Desktop"
DOSKEY doc=cd "%UserProfile%\documents"
DOSKEY music=cd "%UserProfile%\Music"
DOSKEY pic=cd "%UserProfile%\pictures"
DOSKEY vid=cd "%UserProfile%\videos"
doskey prog=cd %PROGRAMFILES%

DOSKEY poweroff=shutdown /s /t 0 /f
DOSKEY reboot=shutdown /r /t 0 /f
DOSKEY ifconfig=ipconfig
DOSKEY myip=curl ifconfig.me
DOSKEY myip1=curl ipinfo.io/ip
doskey javar=java -Xmx345M -jar $*

doskey cp=cp -r
doskey yu=youtube-dl --update
doskey mpython3=youtube-dl -f bestaudio -x --audio-format mpython3 --embed-thumbnail $*
doskey bb=youtube-dl -f bestvideo+bestaudio $*
doskey dff=diff --suppress-common-lines --side-by-side --ignore-space-change $*
doskey grip=grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' $*
doskey gremail=grep -E -o -r "[A-Za-z0-9][A-Za-z0-9._%+-]+@[A-Za-z0-9][A-Za-z0-9.-]+\.[A-Za-z]{2,6}" $*
doskey grpath=grep -Po "^.[^.]+\.[a-zA-Z]{3}$|^.[^.]+\.[a-zA-Z]{2}\.[a-zA-Z]{2}$" $*
doskey grsu=grep -Eo ".*\.bat|.*\.cmd|.*\.class|.*\.exe|.*\.jar|.*\.js|.*\.jse|.*\.SCR|.*\.VBE|.*\.vbs|.*\.reg|.*\.ps1|.*\.psm1" $*
doskey grex=grep -Eo "^.*(exe|dll|bat|sys|htm|html|js|jar|jpg|png|vb|scr|pif|chm|zip|rar|cab|pdf|doc|docx|ppt|pptx|xls|xlsx|swf|gif).*" $*
doskey grsn=grep -Eo "^.*(pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user).*" $*
doskey grurl=grep -Eo "[a-zA-Z]+://[-a-zA-Z0-9.]+(?:/[-a-zA-Z0-9+&@#/%=~_|!:,.;]*)?(?:\?[a-zA-Z0-9+&@#/%=~_|!:,.;]*)?" $*
doskey gruser=grep -Po "([a-z0-9\-._~%!$&'()*+,;=]+@)?" $*
doskey grfind=grep -RnisI $*
doskey grfindx=grep -H -n $*
doskey remove-e=grep . $*
doskey remove-d=awk -F"|" '!_[$2]++'
doskey findsql-url=python %sqlmapa% --batch --technique=BTE -v 3 --crawl=8 --threads=5 --random-agent --dbms="mysql|mssql|postgresql|orcale" --level=5 --risk=3 -u $*
doskey findsql-list=python %sqlmapa% --batch --technique=BTE -v 3 --crawl=8 --threads=5 --random-agent --dbms="mysql|mssql|postgresql|orcale" --level=5 --risk=3 -m $*
doskey sql-layzy=python %sqlmapa% --forms --batch  --crawl=15 --threads=10 -u $*
doskey fix=E:\ProgramData\Serphp\commands\ANSICON\ansicon.exe -p

doskey flutter="C:\src\flutter\bin\flutter" $*

doskey laragon="C:\laragon\laragon.exe" $*
doskey hosts="E:\ProgramData\Serphp\Tools\HostsFileEditor1.2\HostsFileEditor.exe" $*

rem END
neofetch
