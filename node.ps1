$server = New-Object System.Net.HttpListener
$server.Prefixes.Add("http://localhost:8675/")
$server.Start()

do
{
    $context = $server.GetContext()
    $request = $context.Request

    $controllerName = $request.Url.PathAndQuery.Replace("/", "")
    $controller = "C:\Dev\nodePS\" + $controllerName + ".ps1"

    $output = & $controller
    $outputBytes = [System.Text.Encoding]::UTF8.GetBytes($output)

    $response = $context.Response

    $response.ContentLength64 = $outputBytes.Length
    $outputStream = $response.OutputStream
    $outputStream.Write($outputBytes, 0, $outputBytes.Length)

    $outputStream.Close()

} while($true)


$server.Stop()
