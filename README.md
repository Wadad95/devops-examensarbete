# DevOps Examensarbete – Automated VM Lifecycle & Monitoring

## 📌 Projektöversikt
Detta examensarbete demonstrerar ett komplett automatiserat flöde för livscykelhantering av virtuella maskiner med integrerad övervakning.

Projektet kombinerar Infrastructure as Code, konfigurationshantering och API-integration.

---

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

Se mappen `/screenshots` för bilder från projektet.

---

## 🚀 Syfte

Projektet visar hur DevOps-principer kan användas för att automatisera hela livscykeln för virtuella maskiner inklusive övervakning och rensning.
