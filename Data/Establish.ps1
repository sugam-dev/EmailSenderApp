# Load appsettings file
$appSettings = Get-Content "appsettings.Development.json" | ConvertFrom-Json

# Retrieve connection string
$connectionString = $appSettings.ConnectionStrings.DefaultConnection

# Function to establish database connection status
function Establish-CheckConnection {
    # Initialize connection status variable
    $connectionStatus = ""

    # Get database connection object
    $connection = Establish-DatabaseConnection -connectionString $connectionString

    # Check if connection object is null
    if ($connection -eq $null) {
        $connectionStatus = "Connection Failed: Unable to create database connection."
        return $connectionStatus, $null
    }

    try {
        # Open the database connection
        $connection.Open()
        $connectionStatus = "Connected"
    } 
    catch {
        # Handle connection error
        $errorMessage = $_.Exception.Message
        $connectionStatus = "Connection Failed: $errorMessage"
    } 
    finally {
        # Close the connection if it's open
        if ($connection.State -eq 'Open') {
            $connection.Close()
        }
    }

    # Return connection status and connection object
    return $connectionStatus
}

# Function to create database connection object
function Establish-DatabaseConnection {
    param (
        [string]$connectionString
    )

    try {
        # Create new SQL connection object
        $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
        return $connection
    }
    catch {
        # Handle connection creation error
        Write-Error "Error creating database connection: $_"
        return $null
    }
}