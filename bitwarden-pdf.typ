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

#let box-color = rgb("#F3F7FA")

#let textbox(content) = box(radius: 2mm, fill: box-color, inset: 0.9em, width: 100%)[
  #text(size: 0.8em, content)
  #v(0.7cm)
]

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
  box(radius: 2mm, fill: box-color, inset: 0.9em, width: 100%)[
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

#pdf.attach(
  "bitwarden_export.json",
  relationship: "supplement",
  mime-type: "application/json",
  description: "Raw Bitwarden export",
)

#grid(
  columns: 2, gutter: 0.5cm,
  ..for item in json("bitwarden_export.json").items {
    if "login" not in item {
      continue
    }

    (
      [
        //HACK: typst doesn't natively word-wrap long text sequences inside the back,
        // so we force line breaks, by adding zero-width joiners
        // https://forum.typst.app/t/how-to-text-wrap-inside-a-table-cell/3389/11
        #show regex("\w+"): it => it.text.clusters().intersperse(sym.zws).join()

        == #item.name
        #card((:
          ..if "username" in item.login {
            ("Username": item.login.username)
          },
          ..if "password" in item.login {
            ("Password": item.login.password)
          },
          ..if "notes" in item {
            ("": item.notes)
          },
          ..if "fields" in item {
            item.fields.map(v => (v.name, v.value)).to-dict()
          },
        ))],
    )
  }
)
