# Verifica se o Chocolatey está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Output "Chocolatey não está instalado. Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; `
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
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
    @{name="Node.js LTS"; chocoName="nodejs-lts"; wingetId="OpenJS.Nodejs.LTS"},
    @{name="Docker"; chocoName="docker"; wingetId="Docker.DockerDesktop"},
    @{name="7-Zip"; chocoName="7zip"; wingetId="7zip.7zip"},
    @{name="OBS Studio"; chocoName="obs-studio"; wingetId="OBSProject.OBSStudio"},
    @{name="WhatsApp"; chocoName="whatsapp"; wingetId="9NKSQGP7F2NH"},
    @{name="CapCut"; chocoName="capcut"; wingetId="Bytedance.CapCut"}
)

# Tenta instalar cada programa
foreach ($program in $programs) {
    try {
        Write-Output "Tentando instalar $($program.name) via Chocolatey..."
        choco install $program.chocoName -y
        Write-Output "$($program.name) instalado com sucesso via Chocolatey."
    }
    catch {
        Write-Output "Falha ao instalar $($program.name) via Chocolatey. Tentando via Windows Store..."
        Install-ViaWinget -programId $program.wingetId -programName $program.name
    }
}
