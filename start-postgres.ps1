param(
    [string]$DeployHost = "192.168.0.45",
    [string]$User = $(if ($env:DOCKER_HOST_USER) { $env:DOCKER_HOST_USER } else { "kevin" }),
    [string]$RemoteDir = "C:/docker/dicejobmanager-postgres"
)

$ErrorActionPreference = "Stop"
$remote = "${User}@${DeployHost}"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Deploying Postgres only to ${remote}"

ssh $remote "powershell -NoProfile -Command `"New-Item -ItemType Directory -Force -Path '$RemoteDir' | Out-Null`""
scp (Join-Path $root "docker-compose.yml") "${remote}:${RemoteDir}/docker-compose.yml"
scp -r (Join-Path $root "init") "${remote}:${RemoteDir}/init"
ssh $remote "powershell -NoProfile -Command `"Set-Location '$RemoteDir'; docker compose up -d`""

Write-Host "Postgres: ${DeployHost}:5432 database dicejobmanager"
