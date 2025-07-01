Clear-Host

function Mostrar-Menu {
    Write-Host ""
    Write-Host "=========== MENÚ DE SCRIPTS ============" -ForegroundColor Cyan
    Write-Host "1. Analizar JARs            [JarParser.ps1]"
    Write-Host "2. Analizar entradas BAM    [BamParser.ps1]"
    Write-Host "3. Analizar archivos BAT    [BatParser.ps1]"
    Write-Host "4. Analizar DLLs            [DllParser.ps1]"
    Write-Host "0. Salir"
    Write-Host "========================================"
}

function Ejecutar-Script($url, $nombre) {
    try {
        $tempPath = "$env:TEMP\temp_script_$((Get-Random).ToString()).ps1"

        Write-Host ""
        Write-Host "→ Descargando y ejecutando $nombre..." -ForegroundColor Yellow

        Invoke-WebRequest -Uri $url -OutFile $tempPath -UseBasicParsing

        Write-Host "--- Ejecutando script desde $url ---`n" -ForegroundColor Gray
        & powershell.exe -ExecutionPolicy Bypass -NoProfile -File $tempPath

        Remove-Item $tempPath -Force -ErrorAction SilentlyContinue
        Write-Host "`n✔ $nombre ejecutado correctamente." -ForegroundColor Green
    }
    catch {
        Write-Host "`n✖ Error al ejecutar $nombre: $($_.Exception.Message)" -ForegroundColor Red
    }
}

$seguir = $true

do {
    Mostrar-Menu()
    $opcion = Read-Host "`nSelecciona una opción (0-4)"

    switch ($opcion) {
        '1' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/ElixirMC.Jar/refs/heads/main/JarParser.ps1" "JarParser.ps1" }
        '2' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/ElixirMCBam/refs/heads/main/BamParser.ps1" "BamParser.ps1" }
        '3' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/BatParser/refs/heads/main/BatParser.ps1" "BatParser.ps1" }
        '4' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/DllParser/refs/heads/main/dllParser.ps1" "DllParser.ps1" }
        '0' {
            Write-Host "`nSaliendo del menú..." -ForegroundColor Cyan
            $seguir = $false
        }
        default {
            Write-Host "⚠ Opción inválida. Por favor, selecciona entre 0 y 4." -ForegroundColor Red
        }
    }

    if ($seguir) {
        Write-Host ""
        Read-Host "Presiona Enter para continuar..."
    }

} while ($seguir)
