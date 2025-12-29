# Convert SHA1 fingerprint to Facebook Hash Key
$sha1 = "A7:4C:32:9B:3F:30:85:73:B0:2F:6F:03:58:34:A1:9B:85:50:56:FC"

# Remove colons and convert to byte array
$sha1Clean = $sha1.Replace(":", "")
$bytes = [byte[]]::new($sha1Clean.Length / 2)

for ($i = 0; $i -lt $sha1Clean.Length; $i += 2) {
    $bytes[$i / 2] = [Convert]::ToByte($sha1Clean.Substring($i, 2), 16)
}

# Convert to Base64 (Facebook Hash)
$facebookHash = [Convert]::ToBase64String($bytes)

Write-Host ""
Write-Host "===========================================" -ForegroundColor Green
Write-Host "Facebook Hash Key for Debug Keystore:" -ForegroundColor Cyan
Write-Host $facebookHash -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Add this key to your Facebook App Dashboard:" -ForegroundColor White
Write-Host "1. Go to https://developers.facebook.com/apps" -ForegroundColor White
Write-Host "2. Select your app" -ForegroundColor White
Write-Host "3. Go to Settings > Basic" -ForegroundColor White
Write-Host "4. Scroll down to 'Key Hashes'" -ForegroundColor White
Write-Host "5. Add the hash key above" -ForegroundColor White
Write-Host ""
