#set document(title: [Bitwarden Backup])

#show title: set align(center)
#show title: set text(size: 1.75em)

#set page(
  header: context {
    if counter(page).get().first() == 1 {
      align(
        right + horizon,
        [Created on *#datetime.today().display()*],
      )
    }
  },
)

#title()

#let textbox(content) = rect(width: 100%, radius: 2mm, inset: 12pt, content)

#textbox[Vault URL:]
#textbox[Email Address:]
#textbox[Master Password:]
#textbox[2FA Backup code(s):]

#textbox[Email Password:]
#textbox[Email 2FA Backup code(s):]
#textbox[Computer Password:]
#textbox[Phone PIN:]
