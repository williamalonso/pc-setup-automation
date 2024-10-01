# Verifica se o Chocolatey está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey não está instalado. Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Função para verificar se um programa já está instalado
function Is-InstalledProgram {
    param (
        [string]$programName
    )
    # Obtém pacotes instalados
    $installedPackages = Get-Package | Where-Object { $_.Name -like "*$programName*" }

    # Se não encontrar pacotes instalados via Get-Package, tenta verificar na Windows Store
    if ($installedPackages.Count -eq 0) {
        $storePackages = winget list | Where-Object { $_ -like "*$programName*" }
        return $storePackages.Count -gt 0
    }

    return $installedPackages.Count -gt 0
}

# Função para instalar programas via winget (usado como fallback)
function Install-ViaWinget {
    param (
        [string]$programId,
        [string]$programName
    )
    Write-Output "Tentando instalar $programName via Windows Store usando winget..."
    winget install -e --id $programId --accept-source-agreements --accept-package-agreements
}

# Lista de programas para instalar via Chocolatey
$programs = @(
    @{name="Google Chrome"; chocoName="googlechrome"; wingetId="Google.Chrome"},
    @{name="Visual Studio Code"; chocoName="vscode"; wingetId="Microsoft.VisualStudioCode"},
    @{name="Git"; chocoName="git"; wingetId="Git.Git"},
    @{name="Node.js"; chocoName="nodejs"; wingetId="OpenJS.Nodejs"},
    @{name="NVM"; chocoName="nvm"; wingetId="nvm-sh.nvm"},
    @{name="Docker"; chocoName="docker"; wingetId="Docker.DockerDesktop"},
    @{name="7-Zip"; chocoName="7zip"; wingetId="7zip.7zip"},
    @{name="OBS Studio"; chocoName="obs-studio"; wingetId="OBSProject.OBSStudio"},
    @{name="WhatsApp"; chocoName="whatsapp"; wingetId="9NKSQGP7F2NH"},
    @{name="CapCut"; chocoName="capcut"; wingetId="Bytedance.CapCut"},
    @{name="Python"; chocoName="python"; wingetId="Python.Python.3"}
)

# Loop para verificar e instalar os programas
foreach ($program in $programs) {
    if (-not (Is-InstalledProgram -programName $program.name)) {
        try {
            Write-Output "Tentando instalar $($program.name) via Chocolatey..."
            choco install $program.chocoName -y
            Write-Output "$($program.name) instalado com sucesso via Chocolatey."
        }
        catch {
            Write-Output "Falha ao instalar $($program.name) via Chocolatey. Tentando via Windows Store..."
            try {
                Install-ViaWinget -programId $program.wingetId -programName $program.name
                Write-Output "$($program.name) instalado com sucesso via Windows Store."
            }
            catch {
                Write-Output "Falha ao instalar $($program.name) via Windows Store."
            }
        }
    } else {
        Write-Output "$($program.name) ja esta instalado."
    }
}
