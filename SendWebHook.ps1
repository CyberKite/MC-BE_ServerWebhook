param([String]$content="default msg") 
$hookUrl = "hook"

#$content = read-host -prompt "Enter Message" code from stackoverflow lol
#$content = "predefined"
#i'll use a param

$payload = [PSCustomObject]@{content = $content}

Invoke-RestMethod -Uri $hookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json'