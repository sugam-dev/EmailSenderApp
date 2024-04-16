function Item-SaveHtml {
    param (
        [string]$HtmlOutput,
        [string]$OutputPath
    )

    # Save the HTML output to a file
    $HtmlOutput | Set-Content -Path $OutputPath -Encoding UTF8
}
