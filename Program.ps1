﻿# Load files
. "./Data/Establish.ps1"
. "./Data/Invoke.ps1"
. "./Generate/Output.ps1"
. "./Tools/Display.ps1"
. "./Utilities/SpecialCharacters.ps1"

# Load appsettings file
$appSettings = Get-Content "appsettings.Development.json" | ConvertFrom-Json

# Call Display-Title function to display the title
Display-Title

# Call Display-Separator function to display the separator line
Display-Separator

# Call Display-ConnectionStatus function
Display-ConnectionStatus
    
# Display email settings only in debug mode
if ($DebugPreference -eq "Continue") {
    # Retrieve email settings
    $emailSettings = $appSettings.EmailSettings

    # Call Display-EmailSettings function with email settings as parameters
    Display-EmailSettings -SmtpServer $emailSettings.SmtpServer `
                        -SmtpPort $emailSettings.SmtpPort `
                        -Username $emailSettings.Username `
                        -Password $emailSettings.Password `
                        -EnableSsl $emailSettings.EnableSsl
}

# Call Display-Separator function to display the separator line
Display-Separator

# Execute stored procedure '[CatalogueSP].[usp_UnlistedVendor_SELECT_ProductURL]'
$resultDataSet = Invoke-StoredProcedureAsDataSet -storedProcedureName '[CatalogueSP].[usp_UnlistedVendor_SELECT_ProductURL]' -parameters $null

# Generate HTML output from stored procedure result for unlisted vendor product URLs.
$htmlOutput = Output-UnlistedVendorProductURL -resultDataSet $resultDataSet `
                                    -templatePath "./Templates/UnlistedVendorProductURL.html"

# Prompt user to press a key before closing
Write-Host "Press any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')