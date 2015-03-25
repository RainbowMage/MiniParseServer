﻿Import-Module $PSScriptRoot\PS-Zip.psm1

# ビルド
./build.bat

# バージョン取得
$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("Build\MiniParseServer.dll").FileVersion

# フォルダ名
$buildFolder = ".\Build"
$archiveFolder = ".\Distribute\MiniParseServer-" + $version

# フォルダが既に存在するなら消去
if ( Test-Path $archiveFolder -PathType Container ) {
	Remove-Item -Recurse -Force $archiveFolder
}

# フォルダ作成
New-Item -ItemType directory -Path $archiveFolder

# コピー
# full
xcopy /Y /R /S /EXCLUDE:full.exclude "$buildFolder\*" "$archiveFolder"

# アーカイブ
New-ZipCompress -source $archiveFolder -destination "$archiveFolder.zip"

pause
