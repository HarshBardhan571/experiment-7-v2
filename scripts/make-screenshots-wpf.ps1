Add-Type -AssemblyName PresentationCore,PresentationFramework,WindowsBase

$folder = Join-Path $PSScriptRoot "..\screenshots" | Resolve-Path -Relative
Set-Location (Join-Path $PSScriptRoot "..")

Get-ChildItem -Path $folder -Filter "*.txt" | ForEach-Object {
    $txtPath = $_.FullName
    $text = Get-Content -Raw -Path $txtPath

    $fontFamily = 'Consolas'
    $fontSize = 14.0
    $dpi = 96

    $typeface = New-Object System.Windows.Media.Typeface($fontFamily)
    $formatted = New-Object System.Windows.Media.FormattedText(
        $text,
        [System.Globalization.CultureInfo]::InvariantCulture,
        [System.Windows.FlowDirection]::LeftToRight,
        $typeface,
        $fontSize,
        [System.Windows.Media.Brushes]::Black,
        $dpi
    )

    $width = [int]([math]::Ceiling($formatted.Width) + 20)
    $height = [int]([math]::Ceiling($formatted.Height) + 20)

    $rtb = New-Object System.Windows.Media.Imaging.RenderTargetBitmap($width, $height, $dpi, $dpi, [System.Windows.Media.PixelFormats]::Pbgra32)

    $dv = New-Object System.Windows.Media.DrawingVisual
    $dc = $dv.RenderOpen()
    $dc.DrawRectangle([System.Windows.Media.Brushes]::White, $null, (New-Object System.Windows.Rect(0,0,$width,$height)))
    $dc.DrawText($formatted, (New-Object System.Windows.Point(10,10)))
    $dc.Close()

    $rtb.Render($dv)

    $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
    $encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($rtb))

    $pngPath = [System.IO.Path]::ChangeExtension($txtPath, '.png')
    $fs = [System.IO.File]::Open($pngPath, 'Create')
    $encoder.Save($fs)
    $fs.Close()

    Write-Output "Rendered $pngPath"
}
