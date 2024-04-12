#import "@preview/polylux:0.3.1": *
#import "tamburlaine.typ": *

#show: tamburlaine-theme.with(aspect-ratio: "4-3")
#show link: item => underline(text(blue)[#item])

#enable-handout-mode(true)

#title-slide(
  title: "Developing a Python package",
  authors: ("Fergus Baker",),
  where: "Astro Dev Group",
  date: datetime(year: 2024, month: 4, day: 12)
)


#slide(title:"What is a package?")[
  #v(1em)
  #one-by-one(start: 2)[
    - Something that is `pip` installable
  #v(-0.7em)
    ```bash
    $ pip install numpy
    ```
  ][
    - A directory on the filesystem
  ][
    - A collection of reusable *modules*
    - An *abstraction* of some behaviour or methods
  ][
    #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[A package is a way to share code])
  ][
    Use a package:
    ```python
    import numpy as np     # importing a module in the package

    values = np.linspace(  # a function in the module
      0, 1, 10
    )
    ```
  ]

]

#slide(title:"Why would you want to make a package?")[
  #v(1em)
  #one-by-one(start: 2)[
  - Let other people easily use your code
  ][
  - Separate out functions and routines you share between projects
  - Reduce the complexity of a codebase
  ][
  #v(-0.3em)
    #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Guide your thinking])
  #v(0.3em)
  ][
    - A package encourages you to think in *modules*
    - Starts to *break down the problem* for you
    - Makes your codebase navigable
    - Separation of concerns
  ]
]

#slide(title:"The basics")[
  #v(1em)
  #one-by-one(start:2)[
  - Create an `__init__.py` to turn a *directory* into a *module*
    - `__init__.py` is executed on `import`
    - Used to define your public *API*
  ][
  #align(center, text(fill: PRIMARY_COLOR, size: 25pt, weight: "black")[
    An example package for statistical distributions:
  ])
  #align(center)[
  ```
  distributions/
  ├── continuous.py
  └── __init__.py
  ```
  ]
  ][
  Here we have
  - a `distributions` *module* (from the `__init__.py`)
  - a `distributions.continuous` *module* (from `continuous.py`)
  ]
]

#slide[
  #v(-0em)
  #rect(fill: PRIMARY_COLOR, width: 100%, height:44%, inset: (top: 1em))[
  #text(fill:SECONDARY_COLOR, size: 80pt, weight: "black")[Modules are namespaces]
]
  #v(-1em)
  #one-by-one(start:2)[
    #align(right, text(fill:PRIMARY_COLOR, size: 50pt, weight: "black")[Use modules to group logical parts of your code])
  ][
    #align(left, text(fill:TEXT_COLOR, size: 40pt, weight: "regular")[Combine *modules* into *packages*])
  ]
]


#slide(title: "Distinguish with modules")[
  #v(0.5em)
  In the example:
  - *Continuous* and *discrete* distributions are *logically* separate.
  - *Plotting* is separate from the *definitions* of the distributions.
  #align(center)[
  #v(-0.5em)
  ```
  distributions/
  ├── continuous.py
  ├── discrete.py
  ├── plots.py
  └── __init__.py
  ```
  ]
  #v(-0.5em)
  Then use as
  ```py
  import distributions.continuous as continuous
  import distributions.discrete as discrete

  ```
]

#slide(title: "Thinking in modules")[
  #v(0.5em)
  For example, use a *module* for:
    - functions specific to filesystem IO
    - an implementation of a numerical method
    - your plotting routines
    - a wrapper for another library that you depend on
    - defining constants
    - utility functions that don't fit into other places
  #one-by-one(start: 2)[
    #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Modules contain the building blocks out of which you build your program.])
  ][
    The "do one thing" idiom, and compose to do many things
  ]
]

#slide(title: "Import machinery")[
    #quote[The import statement combines two operations; it searches for the *named module*, then it *binds the results* of that search to a name in the local scope.]
    #v(-0.3em)
  #one-by-one(start: 2)[
    #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Where are modules imported from?])
    #v(-0.3em)
  ][
    ```python
    >>> import sys
    >>> sys.path
    ['', '/usr/lib/python311.zip', '/usr/lib/python3.11', '/usr/lib/python3.11/lib-dynload', '/home/lilith/.local/lib/python3.11/site-packages', '/usr/lib/python3.11/site-packages']
    ```
  ][
    Loading (#link("https://docs.python.org/3/reference/import.html#loading")[docs]) binds the package into
    #v(-0.3em)
    ```py
    >>> sys.modules
    ```
  ]
]

#slide()[
  #v(-0em)
  #rect(inset:(top: 1.5em, right: 0.6em), fill: PRIMARY_COLOR, width: 100%, height: 66%, par(leading:15pt, align(right, text(fill:SECONDARY_COLOR, size:190pt, weight:"black")[Try it #linebreak() out])))

  Make a directoy with an `__init__.py`, define a small function, try *importing* it and using the function in a script.
]


#slide(title:"Using our package")[
  #v(1em)
  Using the `distributions` example:

  ```py
  import numpy as np
  import distributions

  x = np.linspace(-1, 1, 10)
  y = distributions.gauss(x)
  ```

  #one-by-one(start:2)[
  The *intent* behind this code is clear
  - The details are *abstracted* and we instead see the *concepts*
  - Easy and simple to use and understand
  ][
  #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Scripts build behaviours from packages])
  ]
]

#slide(title:"Good habits")[
  #v(1em)
  #one-by-one[
  - Break problems into small chunks, categorize the work
    - These become your *modules*
  ][
  - Implement your solution as with simple building blocks
    - These become your *functions*
  ][
  - Separate what is *internal* to the package and what is *public* to the user
    - *Public*: would require updating a code that depends on this package
    - *Private*: things you can change that do not affect the user (e.g. specific sorting algorithm to sort a vector)
  ][
  #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Interface versus implementation])
  ]
]

#slide(title:"Sharing your package")[
  See #link("https://packaging.python.org/en/latest/tutorials/packaging-projects/")[Python documentation] for detailed step by step.

  #one-by-one(start:2)[
  *Do not* use `distutils`:
  - Python 3.10 deprecated `distutils`
  - Python 3.12 has *removed it*
  ][
    #align(center, text(fill: PRIMARY_COLOR, size: 30pt, weight: "black")[Always use `setuptools` with a `pyproject.toml`])
  ][
  ```toml
  [build-system]
  requires = ["setuptools"]
  build-backend = "setuptools.build_meta"

  [project]
  name = "distributions"
  version = "0.0.1"
  dependencies = ["numpy"]
  ```
  ]
]

#slide(title:"Installing your package")[
  #v(1em)
  Locally
  - `pip install .`
  From a repository
  - ```
    pip install \
      git+https://github.com/astro-group-bristol/py-package
    ```

  Or register your package in #link("https://setuptools.pypa.io/en/latest/userguide/quickstart.html#uploading-your-package-to-pypi")[PyPi] and install like any other.
]

#slide(title:"Summary & questions")[
  #v(1em)
  - *Packages* are for sharing / reusing code
  - Packages are composed of *modules*
  - *Modules* are namespaces / logical scopes
  - Let *modules* help guide your thinking
  - Turn a directory into a *module* with `__init__.py`
  - Use `setuptools` to make your package `pip` friendly (*do not* use `distutils`)
  - Implement your solution as many small *functions* in a *package*
  - Use a script (or Jupyter notebook) to compose those functions into an executable
]

