#import "@preview/polylux:0.3.1": *

#let SECONDARY_COLOR = rgb("#f6f0e0").lighten(30%)
#let PRIMARY_COLOR = rgb("#bf2f38")
#let TEXT_COLOR = black.lighten(13%)

#let tamburlaine-theme(aspect-ratio: "4-3", body) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: SECONDARY_COLOR,
    margin: 1em
  )
  set text(fill: TEXT_COLOR, size: 25pt, font: "Montserrat")
  body
}


#let title-slide(
  title: none,
  authors: (),
  where: none,
  date: none
) = {
  set page(
    fill: SECONDARY_COLOR,
    margin: 1em,
  )
  set text(fill: TEXT_COLOR, weight: "bold")

  let pretty-title = par(leading: 23pt)[
      #text(weight: "black", size:113pt, fill: SECONDARY_COLOR)[#title]
    ]

  let author = authors.join(h(1em))

  logic.polylux-slide[
    #rect(inset:(top: 1em), width:100%, height: 74%, stroke:none, fill: PRIMARY_COLOR)[
      #align(right)[
          #pretty-title
      ]
    ]
    #v(-0.6em)
    #line(length: 100%, stroke: 5mm + TEXT_COLOR)
    #v(-0.5em)
    #grid(
      columns: (70%, 30%),
      row-gutter: 15pt,
      author,
      where,
      align(left, text(size: 20pt, weight: "regular")[University of Bristol]),
      align(right, text(size: 20pt, weight: "regular",
      date.display("[day] [month repr:long] [year]")
      )),
    )
    #v(-0.1em)
    #line(length: 100%, stroke: 8mm + TEXT_COLOR)
  ]
}


#let slide(title: none, body) = {
  set page(
    fill: SECONDARY_COLOR,
    margin: (top: 1em, bottom: 1.5em, left: 1em, right: 1em)
  )
  let header = align(top, locate( loc => {
    set text(size: 20pt)
    grid(
    columns: (1fr, 1fr),
      align(horizon + right, grid(
        columns: 1, rows: 1em,
        title,
        utils.current-section,
      ))
    )
  }))

  let footer = locate( loc => {
    block(
      stroke: ( top: 1mm + TEXT_COLOR ), width: 100%, inset: ( y: .3em ),
      text(.5em, {
        "Fergus Baker"
        h(2em)
        "/"
        h(2em)
        "Astro Dev Group"
        h(1fr)
        logic.logical-slide.display()
      })
    )
  })

  set page(
    footer: footer,
    footer-descent: 0em,
    header-ascent: 1.5em,
  )

  let content = {
    block(spacing: 0.0em, text(fill: PRIMARY_COLOR, size: 50pt, weight: "black", title))
    v(-0.5em)
    body
  }

  logic.polylux-slide(content)
}

