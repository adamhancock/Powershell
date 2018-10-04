# to Connect
Set-ExecutionPolicy Unrestricted
$LiveCred = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
Import-PSSession $Session
Enable-OrganizationCustomization
New-ManagementRoleAssignment –Role "ApplicationImpersonation" –User admin@domain.com


# Public folders
Get-PublicFolderClientPermission -Identity "\Public Folder Name" 
Remove-PublicFolderClientPermission -Identity "\Fax" -User Default 
Add-PublicFolderClientPermission -Identity "\Fax" -User Default  -AccessRights PublishingEditor

Add-PublicFolderClientPermission -Identity "\Fax" -User anonymous  -AccessRights Createitem


#Grant all mailboxes
Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -User user@domain.com
# Send as for all users
Get-Mailbox -ResultSize Unlimited | Add-RecipientPermission -AccessRights SendAs -Trustee smtp@domain.com


# New shared mailbox
New-Mailbox -Name "Mailbox Name" -Alias mailboxname -Shared
Set-Mailbox mailbox -ProhibitSendReceiveQuota 5GB -ProhibitSendQuota 4.75GB -IssueWarningQuota 4.5GB



#Add Permissions 

Add-MailboxPermission "office" -User daniela.carl -AccessRights FullAccess -Automapping $false -InheritanceType All
Remove-MailboxPermission -Identity email@domain.com -User user -AccessRights FullAccess -InheritanceType All
Add-RecipientPermission user1@domain.com -AccessRights Sendas -Trustee user2

# Set SMTP alias
Set-mailbox –Identity “Mailbox” -EmailAddress “SMTP: email@domain.co.uk”

#Get list of mailboxes
get-mailbox 

# Get permissions 
get-mailboxpermissions sam 

# Set Calendar Permissions
Set-MailboxFolderPermission -id mailbox:\Calendar -User default -AccessRights reviewer
get-MailboxFolderPermission -id mailbox:\Calendar -User default -AccessRights reviewer

# Turn Mailbox Forwarding On
Set-Mailbox -Identity "John Smith" -ForwardingAddress "sara@contoso.com" -DeliverToMailboxAndForward $true

#Azure 
$msolcred = get-credential
connect-msolservice -credential $msolcred
Set-MsolUserPassword -userPrincipalName email@domain.com -NewPassword "YourPassword" -ForceChangePassword $false
Get-MsolUser -All | ft displayname , Licenses | Out-File c:\users.csv
Get-MSOLUser | Set-MsolUser -PasswordNeverExpires $true



Get-Mailbox -ResultSize Unlimited |Select-Object DisplayName,PrimarySmtpAddress, @{Name=“EmailAddresses”;Expression={$_.EmailAddresses |Where-Object {$_.PrefixString -ceq “smtp”} | ForEach-Object {$_.SmtpAddress}}} | Export-CSV c:\exchange.csv -NoTypeInformation

# Last logon time
Get-mailbox -resultsize unlimited| Get-MailboxStatistics | select displayname, lastlogontime | sort lastlogontime

#Convert to shared mailbox
Set-Mailbox -Identity email@domain.co.uk -Type “Shared” -ProhibitSendReceiveQuota 5GB -ProhibitSendQuota 4.75GB -IssueWarningQuota 4.5GB
# Set to regular mailbox
Set-Mailbox -Identity <alias> -Type "Regular" -ProhibitSendReceiveQuota 5GB -ProhibitSendQuota 4.75G
B -IssueWarningQuota 4.5GB

# 2fa enable 
