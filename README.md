<h1 align="center">
    PC Setup Automation
</h1>

---

</div>



### 🤔 Sobre o Projeto?

Trata-se de um script para instalar programas automaticamente quando você precisar formatar seu PC Windows.

---

## 🚀 Tecnologias

Esse projeto foi desenvolvido com a seguinte tecnologia:

- [Chocolatey](https://chocolatey.org/)

---

### ✨ Sobre a construção do projeto:

- O script verifica se o programa que voce quer já existe (via Get-Package e Windows Store) antes de instalar.
- O script vai tentar instalar os programas via repositório/api do Chocolatey;
- Se determinado programa não conseguir ser instalado ou não existir no repo, o script tenta instalar via Windows Store;

---

## 🙅 Instalações e usos

1. **Instale o Chocolatey:**

   Abra o PowerShell como Administrador e execute o comando abaixo para instalar o Chocolatey:

   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; `
   [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; `
   iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```

    Obs: para verificar se instalou corretamente:
 
    ```powershell
    choco --version
    ```

2. **Insira sua lista de programas**

    No trecho de código abaixo (linha 37) adicione os programas que você quer instalar em sua máquina.

    ```powershell
    $programs = @(
        @{name="Google Chrome"; chocoName="googlechrome"; wingetId="Google.Chrome"},
        ...
    )
    ```
    
    Para buscar os nomes dos programas basta procurar nos repositórios abaixo ou pedir ao ChatGPT (: 
    
    repositório do -[Chocolatey](https://community.chocolatey.org/packages)
    repositório do -[winget](https://winstall.app/)

3. **Execute o script:**

    Abra o PowerShell como Administrador e execute o script:

    ```powershell
    .\install.ps1
    ```
        
4. **Outro comandos:**

    Para atualizar todos os programas instalados pelo Chocolatey:
   
    ```powershell
    choco upgrade all -y
    ```

    Para instalar um programa específico via Chocolatey:

   ```powershell
    choco install whatsapp -y
    ```

   Para instalar um programa específico via Windows Store:

   ```powershell
    winget install whatsapp --accept-source-agreements --accept-package-agreements
    ```
   
    Para remover um programa específico:

    ```powershell
    choco uninstall googlechrome -y
    ```

---

Se você gostou dessas dicas,  clique em Star ( :star: ) no repisório e segue meu canal no [Youtube](https://www.youtube.com/@CavernadoFront)! :upside_down_face:
    
<h3 align="center">William Alonso</h3>
