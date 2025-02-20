// Constants for layout
#let DIMENSIONS = (
  image_box: (
    max_width: 180pt,
    max_height: 75pt
  ),
  text: (
    default_size: 12pt,
    title_size: 20pt,
    subtitle_size: 14pt,
    bibliography_size: 0.85em
  ),
  spacing: (
    vertical_gap: 50pt,
    grid_row_gap: 15pt,
    paragraph_leading: 0.65em
  )
)

// Page styling configurations
#let PAGE_STYLES = (
  footer: (
    chapter_size: 0.68em,
    gap: 1.75em
  )
)

// Index configurations
#let DEFAULT_INDICES = (
  figures: (
    enabled: true,
    title: "Index of Figures"
  ),
  tables: (
    enabled: true,
    title: "Index of Tables"
  ),
  listings: (
    enabled: true,
    title: "Index of Listings"
  )
)

// Function to load language dictionary
#let load_language(french) = {
  let path = if french { "assets/languages/fr.json" } else { "assets/languages/en.json" }
  (
    dict: json(path),
    lang: if french { "fr" } else { "en" }
  )
}

// Header component with logo and department info
#let create_header(school-logo, department, sector, orientation) = {
  block(width: 100%)[
    #box(
      height: DIMENSIONS.image_box.max_height,
      width: DIMENSIONS.image_box.max_width
    )[
      #align(left)[
        #if school-logo == none {
          image("assets/logos/heig-vd.svg")
        } else {
          school-logo
        }
      ]
    ]
    #box(height: DIMENSIONS.image_box.max_height, width: 59%)[
      #set par(spacing: DIMENSIONS.spacing.paragraph_leading)
      #align(right)[
        #for info in (department, sector, orientation).filter(x => x != none) {
          text(size: DIMENSIONS.text.default_size)[
            #info
          
          ]
        }
      ]
    ]
  ]
}

// Title section component
#let create_title_section(title, subtitle, separator: true) = {
  align(center + horizon)[
    #if subtitle != none {
      text(size: DIMENSIONS.text.subtitle_size, tracking: 2pt)[
        #smallcaps[#subtitle]
      ]
    }
    
    #if separator { line(length: 100%, stroke: 0.5pt) }
    
    #text(size: DIMENSIONS.text.title_size, weight: "bold")[#title]
    
    #if separator { line(length: 100%, stroke: 0.5pt) }
  ]
}


// Authors grid component
#let create_authors_grid(authors, assistants, professors, dict) = {
  let format_names(items) = {
    if items.len() == 0 { return [] }
    if items.len() == 1 { return [#items.first()] }
    if items.len() == 2 {
      return [#items.first() #dict.author_separator #items.last()]
    }
    
    [
      #items.slice(0, -1).join(dict.author_separator)
      #dict.author_separator
      #items.last()
    ]
  }

  let create_row(items, label_singular, label_plural) = {
    if items.len() > 0 {
      (
        text(
          DIMENSIONS.text.subtitle_size,
          weight: "bold"
        )[#if items.len() > 1 { label_plural } else { label_singular }],
        format_names(items)
      )
    }
  }

  grid(
    columns: (150pt, auto),
    row-gutter: DIMENSIONS.spacing.grid_row_gap,
    ..create_row(authors, dict.author, dict.author_plural),
    ..create_row(assistants, dict.assistant, dict.assistant_plural),
    ..create_row(professors, dict.professor, dict.professor_plural)
  )
}

// Create page footer
#let create_page_footer() = {
  context {
    let page_number = counter(page).at(here()).first()
    let is_odd = calc.odd(page_number)
    let align_side = if is_odd { right } else { left }
    
    let chapter_heading = heading.where(level: 1)
    if query(chapter_heading).any(it => it.location().page() == page_number) {
      return align(align_side)[#page_number]
    }

    let before_chapters = query(chapter_heading.before(here()))
    if before_chapters.len() > 0 {
      let current = before_chapters.last()
      if current.numbering != none {
        let chapter_text = upper(text(
          size: PAGE_STYLES.footer.chapter_size,
          current.body
        ))
        if is_odd {
          align(align_side)[
            #chapter_text #h(PAGE_STYLES.footer.gap) #page_number
          ]
        } else {
          align(align_side)[
            #page_number #h(PAGE_STYLES.footer.gap) #chapter_text
          ]
        }
      }
    }
  }
}


// Create index sections
#let create_indices(figure-index, table-index, listing-index) = {
  let fig-type(kind) = figure.where(kind: kind)
  let has-figures(kind) = counter(fig-type(kind)).get().at(0) > 0

  show outline: set heading(outlined: true)
  
  context {
    let indices = (
      (figure-index.enabled, has-figures(image), "figures"),
      (table-index.enabled, has-figures(table), "tables"),
      (listing-index.enabled, has-figures(raw), "listings")
    )

    let active_indices = indices.filter(i => i.at(0) and i.at(1))
    
    if active_indices.len() > 0 { pagebreak() }

    for (enabled, has_content, kind) in active_indices {
      let index_config = if kind == "figures" { figure-index }
        else if kind == "tables" { table-index }
        else { listing-index }
      
      outline(
        title: index_config.at("title", default: DEFAULT_INDICES.at(kind).title),
        target: fig-type(if kind == "figures" { image } 
                else if kind == "tables" { table }
                else { raw })
      )
    }
  }
}

// Main project template function
#let project(
  title: "",
  subtitle: "",
  school-logo: none,
  authors: (),
  assistants: (),
  professors: (),
  department: none,
  sector: none,
  orientation: none,
  branch: none,
  academic-year: none,
  chapter-pagebreak: true,
  french: false,
  title-separator: true,
  table-of-contents: outline(),
  bibliography: none,
  appendix: (
    enabled: false,
    title: "",
    heading-numbering-format: "",
    body: none,
  ),
  external-link-circle: true,
  figure-index: DEFAULT_INDICES.figures,
  table-index: DEFAULT_INDICES.tables,
  listing-index: DEFAULT_INDICES.listings,
  body,
) = {
  // Document setup
  set document(author: authors, title: title)
  set text(size: DIMENSIONS.text.default_size)
  set heading(numbering: "1.1")

  let (dict, lang) = load_language(french)

  // Create header and title sections
  create_header(school-logo, department, sector, orientation)
  create_title_section(title, subtitle, separator: title-separator)
  
  v(DIMENSIONS.spacing.vertical_gap)

  // Authors section
  create_authors_grid(authors, assistants, professors, dict)

  // Branch and academic year
  align(center + bottom)[
    #if branch != none { 
      [#branch #linebreak()] 
    }
    #if academic-year != none { 
      [#academic-year] 
    }
  ]

  // Page styling
  set page(footer: create_page_footer())

  pagebreak()
  table-of-contents
  pagebreak()

  // Main content with chapter settings
  {
    set heading(numbering: "1.")
    show heading.where(level: 1): it => {
      if chapter-pagebreak { pagebreak(weak: true) }
      it
    }
    body
  }

  // Appendix section
  if appendix.enabled {
    pagebreak()
    heading(level: 1)[
      #appendix.at("title", default: "Appendix")
    ]

    let num_format = appendix.at(
      "heading-numbering-format",
      default: "A.1.1."
    )

    counter(heading).update(0)
    set heading(
      outlined: false,
      numbering: (..nums) => {
        let vals = nums.pos()
        if vals.len() > 0 {
          numbering(num_format, ..vals.slice(0))
        }
      }
    )

    appendix.body
  }

  // Bibliography
  if bibliography != none {
    pagebreak()
    show std-bibliography: it => {
      set text(DIMENSIONS.text.bibliography_size)
      set par(
        leading: DIMENSIONS.spacing.paragraph_leading,
        justify: false,
        linebreaks: auto
      )
      it
    }
    bibliography
  }

  // Create indices
  create_indices(figure-index, table-index, listing-index)
}