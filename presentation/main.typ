#import "@preview/polylux:0.3.1": *
#import "tamburlaine.typ": *

#show: tamburlaine-theme.with(aspect-ratio: "4-3")

#title-slide(
  title: "Developing a package in Python",
  authors: ("Fergus Baker",),
  where: "Astro Dev Group",
  date: datetime(year: 2024, month: 4, day: 12)
)

#slide(title:"Hello")[
  == Talk
  Some static text on this slide.

  ```py
  import module
  ```
]

#slide[
  == This slide changes!

  You can always see this.
  #uncover(2)[But this appears later!]
]
