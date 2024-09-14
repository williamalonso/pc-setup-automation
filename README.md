<h1 align="center">
    PC Setup Automation
</h1>

---

</div>



### 🤔 Sobre o Projeto?

Trata-se de um script para instalar programas automaticamente quando você precisar formatar seu PC.

---

## 🚀 Tecnologias

Esse projeto foi desenvolvido com a seguinte tecnologia:

- [Chocolatey](https://chocolatey.org/)

---

### ✨ Sobre a construção do projeto:

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

Obs: para verificar se instalou corretamente:
  
    choco --version



2. Execute o script:

Abra o PowerShell como Administrador e execute o script:

    .\install.ps1


<h3 align="center">William Alonso</h3>
