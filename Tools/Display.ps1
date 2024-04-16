# Function to display separator line
function Display-Separator {
    Write-Host @"
    
========================================

"@ -ForegroundColor Cyan
}

# Function to display title
function Display-Title {
    # Define the application title
    $Title = @"
        _____              __     __        
       /  _  \ _____      |__|   |__| ____  
      /  /_\  \\__  \     |  |   |  |/  _ \ 
     /    |    \/ __ \_   |  |   |  (  <_> )
     \____|__  (____  /\__|  /\__|  |\____/ 
             \/     \/\______\______|       
"@

    # Display cool UI
    Write-Host $Title -ForegroundColor Green
}

# Function to display connection status
function Display-ConnectionStatus {
    # Call the Establish-DatabaseConnection function to establish the database connection
    $connectionStatus = Establish-CheckConnection

    Write-Host "Database Connection:" -ForegroundColor Magenta
    Write-Host "${TabChar}Status: " -ForegroundColor Blue -NoNewline
    Write-Host "$connectionStatus"
}

# Function to display result with color
function Display-Result {
    param (
        [System.Data.DataTable]$dataTable,
        [System.Data.DataSet]$dataSet
    )

    if ($dataTable -ne $null) {
        $dataTable | Format-Table -AutoSize
    }
    elseif ($dataSet -ne $null) {
        foreach ($table in $dataSet.Tables) {
            $table | Format-Table -AutoSize
        }
    }
    else {
        Write-Host "No data returned." -ForegroundColor Yellow
    }
}

# Function to display email settings
function Display-EmailSettings {
    param(
        [string]$SmtpServer,
        [int]$SmtpPort,
        [string]$Username,
        [SecureString]$Password,
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