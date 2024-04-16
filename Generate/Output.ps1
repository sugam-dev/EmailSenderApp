# Generates HTML output based on dataset and HTML template path.
function Output-UnlistedVendorProductURL {
    param (
        [System.Data.DataSet]$resultDataSet,
        [string]$templatePath
    )

    # Read HTML template from file
    $htmlTemplate = Get-Content -Path $templatePath -Raw

    # Extracting data from the dataset
    $unlistedclientid = $resultDataSet.Tables[0].Rows[0]["Unlistedclientid"]
    $vendorid = $resultDataSet.Tables[0].Rows[0]["VendorID"]
    $producturl = $resultDataSet.Tables[0].Rows[0]["ProductUrl"]

    # Replace placeholders in the HTML template with actual data
    $htmlOutput = $htmlTemplate -replace "{{unlistedclientid}}", $unlistedclientid `
                                 -replace "{{vendorid}}", $vendorid `
                                 -replace "{{producturl}}", $producturl

    return $htmlOutput
}