#send mailer coder;;;;;
$Username = "username@domainname.net";
$Password = "password";
$path = ".\filename.txt";

function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "user.name@domain.com";
    $message.To.Add($email);
    $message.Subject = "subject textLINE here...";
    $message.Body = "body textLINE here...";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.live.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.Send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "user.name@domain.com" -attachmentpath $path;

<# multiline comment as raw template
$SmtpServer = 'smtp.live.com'
$SmtpUser = ''
$smtpPassword = ''
$MailtTo = ''
$MailFrom = ''
$MailSubject = "Test using $SmtpServer" 
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Subject $MailSubject -SmtpServer $SmtpServer -UseSsl -Credential $Credentials
#>
