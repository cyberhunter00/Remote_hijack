function smtp {
param (
		[String] $server,
		[String] $port,
		[String] $user,
		[String] $pass,
		[String] $Subject,
		[String] $Body=' ',
		[String] $Attachments,
		[String] $from,
		[String] $to
	)


$emailSmtpServer = $server
$emailSmtpServerPort = $port
$emailSmtpUser = $user
$emailSmtpPass = $pass

$emailMessage = New-Object System.Net.Mail.MailMessage
$emailMessage.From = $from
$emailMessage.Subject = $subject
$emailMessage.IsBodyHtml = $true
    #Set $emailMessage.IsBodyHtml to $false if you are not using HTML tags in $emailMessage.Body
$emailMessage.Body = $body
$emailMessage.To.Add( $to )
    #Repeat this line for multiple recipients in the "To" field
    #You can also use $emailMessage.Cc.Add or $emailMessage.Bcc.Add to add recipients to those fields
$emailMessage.Attachments.Add( $Attachments )
    #Repeat the two previous lines for multiple attachments

$SMTPClient = New-Object System.Net.Mail.SmtpClient( $emailSmtpServer , $emailSmtpServerPort )
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential( $emailSmtpUser , $emailSmtpPass );
$SMTPClient.Send( $emailMessage )
}
