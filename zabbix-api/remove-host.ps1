# Script: Remove Zabbix Host via API
# Purpose: Removes a host from Zabbix monitoring using JSON-RPC API

param(
    [Parameter(Mandatory = $true)]
    [string]$HostName,

    [Parameter(Mandatory = $true)]
    [string]$ZabbixURL,

    [Parameter(Mandatory = $true)]
    [string]$ZabbixUser,

    [Parameter(Mandatory = $true)]
    [string]$ZabbixPassword
)

# ===== LOGIN =====
$loginBody = @{
    jsonrpc = "2.0"
    method  = "user.login"
    params  = @{
        user     = $ZabbixUser
        password = $ZabbixPassword
    }
    id = 1
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod `
    -Uri $ZabbixURL `
    -Method Post `
    -ContentType "application/json" `
    -Body $loginBody

$AuthToken = $loginResponse.result

if (-not $AuthToken) {
    throw "Authentication failed."
}

# ===== GET HOST =====
$getHostBody = @{
    jsonrpc = "2.0"
    method  = "host.get"
    params  = @{
        filter = @{
            host = @($HostName)
        }
    }
    auth = $AuthToken
    id   = 2
} | ConvertTo-Json

$getHostResponse = Invoke-RestMethod `
    -Uri $ZabbixURL `
    -Method Post `
    -ContentType "application/json" `
    -Body $getHostBody

if ($getHostResponse.result.Count -eq 0) {
    Write-Host "Host '$HostName' does not exist in Zabbix." -ForegroundColor Yellow
    return
}

$HostID = $getHostResponse.result[0].hostid

# ===== DELETE HOST =====
$deleteHostBody = @{
    jsonrpc = "2.0"
    method  = "host.delete"
    params  = @($HostID)
    auth    = $AuthToken
    id      = 3
} | ConvertTo-Json

Invoke-RestMethod `
    -Uri $ZabbixURL `
    -Method Post `
    -ContentType "application/json" `
    -Body $deleteHostBody

Write-Host "Host '$HostName' removed successfully from Zabbix." -ForegroundColor Green
