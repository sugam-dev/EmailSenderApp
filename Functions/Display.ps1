# Function to display separator line
function Display-Separator {
    Write-Host @"
    
========================================

"@ -ForegroundColor Cyan
}


# Function to display connection status
function Display-ConnectionStatus {
    param(
        [string]$Status
    )

    Write-Host "Database Connection:" -ForegroundColor Magenta
    Write-Host "${TabChar}Status: " -ForegroundColor Blue -NoNewline
    Write-Host "$Status"
}

# Function to display email settings
function Display-EmailSettings {
    param(
        [string]$SmtpServer,
        [int]$SmtpPort,
        [string]$Username,
        [string]$Password,
        [bool]$EnableSsl
    )

    Write-Host "Email Settings:" -ForegroundColor Magenta

    Write-Host "${TabChar}SMTP Server: " -ForegroundColor Blue -NoNewline
    Write-Host "$SmtpServer"

    Write-Host "${TabChar}SMTP Port: " -ForegroundColor Blue -NoNewline
    Write-Host "$SmtpPort"

    Write-Host "${TabChar}Username: " -ForegroundColor Blue -NoNewline
    Write-Host "$Username"

    Write-Host "${TabChar}Password: " -ForegroundColor Blue -NoNewline
    Write-Host "$Password"

    Write-Host "${TabChar}Enable SSL: " -ForegroundColor Blue -NoNewline
    Write-Host "$EnableSsl"
}
