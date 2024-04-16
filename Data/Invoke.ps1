# Load appsettings file
$appSettings = Get-Content "appsettings.Development.json" | ConvertFrom-Json

# Retrieve connection string
$connectionString = $appSettings.ConnectionStrings.DefaultConnection

# Function to invoke stored procedure and return data as DataTable
function Invoke-StoredProcedureAsDataTable {
    param (
        [string]$storedProcedureName,
        [Hashtable]$parameters
    )

    try {
        # Get database connection object
        $connection = Establish-DatabaseConnection -connectionString $connectionString

        # Check if connection object is null
        if ($connection -eq $null) {
            Write-Error "Failed to establish database connection."
            return $null
        }

        # Create a new SqlCommand object for the stored procedure
        $command = $connection.CreateCommand()
        $command.CommandText = $storedProcedureName
        $command.CommandType = [System.Data.CommandType]::StoredProcedure

        # Add parameters to the command if provided
        if ($parameters -ne $null) {
            foreach ($key in $parameters.Keys) {
                $parameter = $command.Parameters.AddWithValue($key, $parameters[$key])
            }
        }

        # Execute the stored procedure and retrieve the data
        $dataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
        $dataTable = New-Object System.Data.DataTable
        [void]$dataAdapter.Fill($dataTable)

        # Close the database connection
        $connection.Close()

        # Return the fetched data as DataTable
        return $dataTable
    }
    catch {
        Write-Error "Error executing stored procedure: $_"
        return $null
    }
}

# Function to invoke stored procedure and return data as DataSet
function Invoke-StoredProcedureAsDataSet {
    param (
        [string]$storedProcedureName,
        [Hashtable]$parameters
    )

    try {
        # Get database connection object
        $connection = Establish-DatabaseConnection -connectionString $connectionString

        # Check if connection object is null
        if ($connection -eq $null) {
            Write-Error "Failed to establish database connection."
            return $null
        }

        # Create a new SqlCommand object for the stored procedure
        $command = $connection.CreateCommand()
        $command.CommandText = $storedProcedureName
        $command.CommandType = [System.Data.CommandType]::StoredProcedure

        # Add parameters to the command if provided
        if ($parameters -ne $null) {
            foreach ($key in $parameters.Keys) {
                $parameter = $command.Parameters.AddWithValue($key, $parameters[$key])
            }
        }

        # Execute the stored procedure and retrieve the data
        $dataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $command
        $dataSet = New-Object System.Data.DataSet
        [void]$dataAdapter.Fill($dataSet)

        # Close the database connection
        $connection.Close()

        # Return the fetched data as DataSet
        return $dataSet
    }
    catch {
        Write-Error "Error executing stored procedure: $_"
        return $null
    }
}

# Function to Opens a file or launches an application associated with the specified file path.
function Invoke-Item {
    param (
        [string]$Path
    )

    # Open the specified file or launch the associated application
    Start-Process $Path
}