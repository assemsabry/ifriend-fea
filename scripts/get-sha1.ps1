# get-sha1.ps1
# Usage: run this from PowerShell (you can run from project root):
#   .\scripts\get-sha1.ps1
# It will try to find keytool, run Gradle signingReport (to show SHA1s) and print SHA1 for debug and release keystores.

$ErrorActionPreference = 'Stop'

function Find-Keytool {
    $kt = $null
    try { $kt = (where.exe keytool 2>$null | Select-Object -First 1) }
    catch { }
    if (-not $kt -and $env:JAVA_HOME) {
        $candidate = Join-Path $env:JAVA_HOME 'bin\keytool.exe'
        if (Test-Path $candidate) { $kt = $candidate }
    }
    if (-not $kt) {
        Write-Error "keytool not found on PATH and JAVA_HOME not set to a JDK with keytool. Install JDK or add keytool to PATH."
        exit 2
    }
    return $kt
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$projectRoot = Resolve-Path (Join-Path $scriptDir '..')
$androidDir = Join-Path $projectRoot 'android'

$kt = Find-Keytool
Write-Host "Using keytool: $kt`n"

Write-Host "1) Gradle signingReport (filtered for SHA1):`n"
if (Test-Path (Join-Path $androidDir 'gradlew.bat')) {
    Push-Location $androidDir
    try {
        & .\gradlew.bat signingReport --console plain 2>&1 | Select-String 'SHA1:' | ForEach-Object { $_.ToString() }
    } catch {
        Write-Warning "Gradle signingReport failed: $_"
    } finally { Pop-Location }
} else {
    Write-Host "gradlew.bat not found in android/ — skipping signingReport.`n"
}

Write-Host "`n2) SHA1 from debug keystore:`n"
$debugKs = Join-Path $androidDir 'debug.keystore'
if (Test-Path $debugKs) {
    try {
        & $kt -list -v -keystore $debugKs -alias androiddebugkey -storepass android 2>&1 | Select-String 'SHA1:' | ForEach-Object { $_.ToString() }
    } catch {
        Write-Warning "Failed to read debug keystore: $_"
    }
} else {
    Write-Warning "debug.keystore not found at $debugKs"
}

Write-Host "`n3) SHA1 from release keystore (from android/key.properties if present):`n"
$keyPropsFile = Join-Path $androidDir 'key.properties'
if (Test-Path $keyPropsFile) {
    $props = @{}
    Get-Content $keyPropsFile | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith('#') -and $line -match '=') {
            $parts = $line -split '=',2
            $props[$parts[0].Trim()] = $parts[1].Trim()
        }
    }
    if ($props.ContainsKey('storeFile')) {
        $storeFile = $props['storeFile']
        # if relative path, resolve relative to androidDir
        $releaseKs = if ([System.IO.Path]::IsPathRooted($storeFile)) { $storeFile } else { Join-Path $androidDir $storeFile }
        $storePass = $props['storePassword']
        $keyAlias = $props['keyAlias']
        $keyPass = $props['keyPassword']

        if (Test-Path $releaseKs) {
            try {
                # Prefer to pass storepass non-interactively if present; otherwise keytool will prompt
                $args = @('-list','-v','-keystore',$releaseKs)
                if ($keyAlias) { $args += @('-alias',$keyAlias) }
                if ($storePass) { $args += @('-storepass',$storePass) }
                if ($keyPass) { $args += @('-keypass',$keyPass) }
                & $kt @args 2>&1 | Select-String 'SHA1:' | ForEach-Object { $_.ToString() }
            } catch {
                Write-Warning "Failed to read release keystore: $_"
            }
        } else {
            Write-Warning "Release keystore file not found at: $releaseKs"
        }
    } else {
        Write-Warning "storeFile not set in android/key.properties"
    }
} else {
    Write-Warning "android/key.properties not found — can't locate release keystore automatically."
}

Write-Host "`nDone. If you still don't see SHA1 values, ensure a JDK is installed and keytool is available, or provide the signed APK/AAB and I can guide extracting the certificate fingerprint from it."
