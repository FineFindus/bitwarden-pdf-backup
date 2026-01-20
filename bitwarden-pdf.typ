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

= General

#textbox[Vault URL:]
#textbox[Email Address:]
#textbox[Master Password:]
#textbox[2FA Backup code(s):]

#textbox[Email Password:]
#textbox[Email 2FA Backup code(s):]
#textbox[Computer Password:]
#textbox[Phone PIN:]

= Items

#let card(fields) = {
  box(radius: 2mm, fill: rgb("#F3F7FA"), inset: 0.9em, width: 100%)[
    #stack(
      ..for (title, value) in fields {
        if value == none {
          continue
        }

        (text(size: 0.8em, title), v(2mm), value, v(4mm))
      },
      v(-4mm),
    )
  ]
}

#for item in json("bitwarden_export.json").items {
  [== #item.name ]
  //HACK: typst doesn't natively word-wrap long text sequences inside the back,
  // so we force line breaks, by adding zero-width joiners
  // https://forum.typst.app/t/how-to-text-wrap-inside-a-table-cell/3389/11
  show regex("\w+"): it => it.text.clusters().intersperse(sym.zws).join()

  if "login" in item {
    card((
      "Username": item.login.username,
      "Password": item.login.password,
      "Notes": item.notes,
    ))
  }
}
