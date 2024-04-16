# Load DisplayFunctions.ps1 file
. "./Functions/Display.ps1"

# Load SpecialCharacters.ps1 file
. "./Utilities/SpecialCharacters.ps1"

# Define the application title
$Title = @"
    _____              __     __        
   /  _  \ _____      |__|   |__| ____  
  /  /_\  \\__  \     |  |   |  |/  _ \ 
 /    |    \/ __ \_   |  |   |  (  <_> )
 \____|__  (____  /\__|  /\__|  |\____/ 
         \/     \/\______\______|       
                                                                             
"@

# Load appsettings.json file
$appSettings = Get-Content "appsettings.Development.json" | ConvertFrom-Json

# Retrieve connection string
$connectionString = $appSettings.ConnectionStrings.DefaultConnection

# Attempt to establish database connection
try {
    $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    $connection.Open()
    $connectionStatus = "Connected"
} catch {
    $connectionStatus = "Connection Failed: $_"
} finally {
    $connection.Close()
}

# Retrieve email settings
$emailSettings = $appSettings.EmailSettings

# Display cool UI
Write-Host $Title -ForegroundColor Green

# Call Display-Separator function to display the separator line
Display-Separator

# Call Display-ConnectionStatus function with connectionStatus as parameters
Display-ConnectionStatus $connectionStatus
    
# Display email settings only in debug mode
if ($DebugPreference -eq "Continue") {
    # Call Display-EmailSettings function with email settings as parameters
    Display-EmailSettings -SmtpServer $emailSettings.SmtpServer `
                        -SmtpPort $emailSettings.SmtpPort `
                        -Username $emailSettings.Username `
                        -Password $emailSettings.Password `
                        -EnableSsl $emailSettings.EnableSsl
}

# Call Display-Separator function to display the separator line
Display-Separator

# Prompt user to press a key before closing
Write-Host "Press any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
