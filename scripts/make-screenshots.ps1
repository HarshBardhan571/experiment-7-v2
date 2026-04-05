Add-Type -AssemblyName System.Drawing

$folder = Join-Path $PSScriptRoot "..\screenshots" | Resolve-Path -Relative
Set-Location (Join-Path $PSScriptRoot "..")

Get-ChildItem -Path $folder -Filter "*.txt" | ForEach-Object {
    $txtPath = $_.FullName
    $text = Get-Content -Raw -Path $txtPath

    $fontName = 'Consolas'
    $fontSize = 12
    $font = New-Object System.Drawing.Font($fontName, $fontSize)

    $bmp = New-Object System.Drawing.Bitmap 1,1
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $size = $g.MeasureString($text, $font)
    $g.Dispose()
    $bmp.Dispose()

    $width = [math]::Ceiling($size.Width) + 20
    $height = [math]::Ceiling($size.Height) + 20

    $bmp = New-Object System.Drawing.Bitmap $width, $height
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::White)
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
    $rect = New-Object System.Drawing.RectangleF(10,10,$width-20,$height-20)
    $g.DrawString($text, $font, $brush, $rect)

    $pngPath = [System.IO.Path]::ChangeExtension($txtPath, '.png')
    $bmp.Save($pngPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $g.Dispose()
    $bmp.Dispose()
    Write-Output "Wrote $pngPath"
}
