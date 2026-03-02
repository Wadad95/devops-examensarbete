# Script: Create Linux VM in Hyper-V (from template VHDX)
# Purpose: Automate VM creation and startup using a prepared Linux template disk

param(
    [Parameter(Mandatory = $true)]
    [string]$VMName,

    [int]$CPU = 2,

    [int64]$Memory = 2GB,

    [string]$VMSwitch = "Intel(R) 82579LM Gigabit Network Connection - Virtual Switch",

    [Parameter(Mandatory = $true)]
    [string]$TemplateVHD,

    [string]$BaseVMPath = "C:\EXarbete-VM"
)

# Paths
$VMPath  = Join-Path $BaseVMPath $VMName
$VHDPath = Join-Path $VMPath "$VMName.vhdx"

# Basic validations
if (-not (Test-Path $TemplateVHD)) {
    throw "Template VHDX not found: $TemplateVHD"
}

if (Get-VM -Name $VMName -ErrorAction SilentlyContinue) {
    throw "A VM with name '$VMName' already exists."
}

# Create folder
New-Item -ItemType Directory -Path $VMPath -Force | Out-Null

# Copy template disk
Copy-Item -Path $TemplateVHD -Destination $VHDPath -Force

# Create VM (Gen 2)
New-VM `
    -Name $VMName `
    -Generation 2 `
    -MemoryStartupBytes $Memory `
    -VHDPath $VHDPath `
    -Path $VMPath | Out-Null

# CPU
Set-VMProcessor -VMName $VMName -Count $CPU

# Network
Connect-VMNetworkAdapter -VMName $VMName -SwitchName $VMSwitch

# Secure Boot off (Linux)
Set-VMFirmware -VMName $VMName -EnableSecureBoot Off

# Start VM
Start-VM -Name $VMName | Out-Null

Write-Host "VM '$VMName' created from template and started successfully." -ForegroundColor Green
