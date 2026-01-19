#set document(title: [Bitwarden Backup])

#show title: set align(center)
#show title: set text(size: 1.75em)

#title()
#align(right)[Created on *#datetime.today().display()*]

#let textbox(content)  = rect(width: 100%, radius: 2mm, inset: 10pt, content)

#textbox[Web-Address:]
#textbox[Email Address:]
#textbox[Master Password:]
#textbox[2FA Backup code(s):]

#textbox[Email Password:]
#textbox[Email 2FA Backup code(s):]
#textbox[Computer Password:]
#textbox[Phone PIN:]
