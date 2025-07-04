Clear-Host

function Mostrar-Menu {
    Write-Host ""
    Write-Host "======= MENÚ DE SCRIPTS ========" -ForegroundColor Cyan
    Write-Host "1. Ejecutar JarParser.ps1"
    Write-Host "2. Ejecutar BamParser.ps1"
    Write-Host "3. Ejecutar BatParser.ps1"
    Write-Host "4. Ejecutar DllParser.ps1"
    Write-Host "0. Salir"
    Write-Host "===============================" -ForegroundColor Cyan
}

function Ejecutar-Script($url) {
    try {
        $tempPath = "$env:TEMP\temp_script_$(Get-Random).ps1"
        Invoke-WebRequest -Uri $url -OutFile $tempPath -UseBasicParsing
        Write-Host ""
        Write-Host "--- Ejecutando script desde $url ---" -ForegroundColor Yellow
        Write-Host ""

        . $tempPath

        Remove-Item $tempPath -Force
    }
    catch {
        Write-Host "`n✖ Error al ejecutar el script:`n$($_.Exception.Message)" -ForegroundColor Red
    }
}

$seguir = $true

do {
    Mostrar-Menu
    $opcion = Read-Host "Selecciona una opción (0-4)"

    switch ($opcion) {
        '1' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/ElixirMC.Jar/refs/heads/main/JarParser.ps1" }
        '2' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/ElixirMCBam/refs/heads/main/BamParser.ps1" }
        '3' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/BatParser/refs/heads/main/BatParser.ps1" }
        '4' { Ejecutar-Script "https://raw.githubusercontent.com/lea13245/DllParser/refs/heads/main/dllParser.ps1" }
        '0' {
            Write-Host "Saliendo..." -ForegroundColor Cyan
            $seguir = $false
        }
        default {
            Write-Host "Opción inválida. Intenta de nuevo." -ForegroundColor Red
        }
    }

    if ($seguir) {
        Write-Host ""
        Write-Host "Presiona Enter para continuar..."
        [void][System.Console]::ReadLine()
    }

} while ($seguir)
