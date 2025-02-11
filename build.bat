@echo off

mkdir export\vpk
copy dir\englishclient_frontend.bsp.pak000_dir.vpk export\vpk /y
pushd export\vpk
RSPNVPK englishclient_frontend.bsp.pak000_dir.vpk -s -d ..\..\src

if "%1"=="" (
    popd
)

if "%1"=="test" (
    cd ..
    xcopy vpk "C:\Program Files (x86)\Steam\steamapps\common\Titanfall2\vpk" /y
    copy midimap.dll "C:\Program Files (x86)\Steam\steamapps\common\Titanfall2" /y
    popd
    echo Test build inserted!
)

if "%1"=="release" (
    cd ..
    7z a SRMM-v%2-main.zip vpk midimap.dll
    cd ..
    move src\resource\*.dat .
    move src\resource\*.txt .
    copy dir\englishclient_frontend.bsp.pak000_dir.vpk export\vpk /y
    cd export\vpk
    RSPNVPK englishclient_frontend.bsp.pak000_dir.vpk -s -d ..\..\src
    cd ..
    7z a SRMM-v%2-this-version-is-for-chinese-runners-who-want-to-keep-their-game-text-in-chinese-instead-of-swapping-it-out-for-english-text.zip vpk midimap.dll
    popd
    move *.dat src\resource
    move *.txt src\resource
    echo Release build v%2 packed!
)