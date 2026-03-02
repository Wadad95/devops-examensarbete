# DevOps Examensarbete – Automated VM Lifecycle & Monitoring

## 📌 Projektöversikt

Detta examensarbete demonstrerar ett komplett automatiserat flöde för livscykelhantering av virtuella maskiner med integrerad övervakning.

Projektet kombinerar Infrastructure as Code, konfigurationshantering och API-integration.

---

## 📂 Project Structure

devops-examensarbete/
├── scripts/
│ └── powershell/
│ └── create-vm.ps1
├── ansible/
│ └── playbook.yml
├── zabbix-api/
│ └── remove-host.ps1
├── screenshots/
└── README.md

-----
## ⚙️ Funktionalitet

1. Virtuella maskiner skapas automatiskt i Hyper-V (PowerShell)
2. Ubuntu installeras
3. Zabbix Agent installeras och konfigureras automatiskt med Ansible
4. Active monitoring aktiveras i Zabbix
5. Vid borttagning av VM rensas även all övervakningsdata via Zabbix API

---

## 🛠️ Tekniker

- Windows Server 2022 & Hyper-V
- PowerShell
- Ubuntu 20.04 LTS
- Ansible
- Zabbix 6.0 LTS
- REST API (JSON-RPC)

---

---

## ▶️ Så kör du projektet (Översikt)

### 1️⃣ Skapa virtuell maskin

Kör PowerShell-skriptet:

```powershell
.\create-vm.ps1 -VMName TestVM -TemplateVHD "C:\EXarbete-VM\VM4\VM4.vhdx"
```



2️⃣ Installera Zabbix Agent med Ansible

Från Ansible-kontrollnoden:

ansible-playbook playbook.yml --ask-pass --ask-become-pass


3️⃣ Verifiera övervakning i Zabbix

Logga in i Zabbix Web GUI

Navigera till Monitoring → Hosts

Kontrollera att hostens status är Available

4️⃣ Ta bort VM + övervakning

Kör rensningsskriptet:

```
.\remove-host.ps1 `
    -HostName "TestVM" `
    -ZabbixURL "http://<ZABBIX_SERVER>/zabbix/api_jsonrpc.php" `
    -ZabbixUser "<API_USER>" `
    -ZabbixPassword "<API_PASSWORD>"
```

Detta tar bort:

Den virtuella maskinen i Hyper-V

Host-objektet i Zabbix via API

All relaterad övervakningsdata


## 🧱 Arkitektur (Förenklad)

PowerShell → Hyper-V → Ubuntu VM  
Ansible → Zabbix Agent → Zabbix Server  
PowerShell + Zabbix API → Cleanup

---

## 🎯 Vad jag lärde mig

- Automatisering av infrastruktur
- Konfigurationshantering
- API-integration
- Felsökning i Linux & Windows-miljö
- Bygga reproducerbara och skalbara lösningar

---

## 📷 Screenshots
### 🔹 VM Creation (PowerShell)
![PowerShell VM](screenshots/Powershell-create.png)

### 🔹 Ansible Automation
![Ansible Run](screenshots/Ansible-run.png)

### 🔹 Zabbix Monitoring Active
![Zabbix Dashboard](screenshots/Zabbix-dashboard-active.PNG)

### 🔹 Zabbix API Cleanup
![Zabbix Cleanup](screenshots/Zabbix-api-cleanup.png)

---

## 🚀 Syfte

Projektet visar hur DevOps-principer kan användas för att automatisera hela livscykeln för virtuella maskiner inklusive övervakning och rensning.
