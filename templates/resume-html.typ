// Resume HTML Template - Semantic HTML with Tailwind CSS
// Usage: typst compile --features html --format html --input lang=en resume-html.typ

#import "design.typ": *
#import "data-loader.typ": load-resume-data
#import "i18n.typ": t
#import "filters.typ": filter-k8s-certs, filter-other-certs, get-k8s-certs-text

#let lang = sys.inputs.at("lang", default: "en")
#let data = load-resume-data(lang)

// Clean phone number for tel: links (remove spaces and parentheses)
#let clean-phone = data.basics.phone.replace(" ", "").replace("(", "").replace(")", "")

// ═══════════════════════════════════════════════════════════════════════════════
// TAILWIND CSS CLASSES (Design Tokens - Terminal-Premium Theme)
// ═══════════════════════════════════════════════════════════════════════════════

#let tw = (
  // Accent - Indigo, used sparingly (links, active icon, one border, badges)
  primary-text: "text-indigo-600 dark:text-indigo-400",
  primary-border: "border-indigo-600 dark:border-indigo-400",
  secondary-text: "text-zinc-500 dark:text-zinc-400",
  accent-text: "text-indigo-600 dark:text-indigo-400",
  accent-hover: "hover:text-indigo-800 dark:hover:text-indigo-300",
  muted-text: "text-zinc-500 dark:text-zinc-400",
  bg-card: "bg-zinc-50 dark:bg-zinc-800/60 card-panel rounded-lg",
  // K8s specific (blue only for Kubernetes - kept as the single themed exception)
  k8s-text: "text-blue-600 dark:text-blue-400",
  k8s-border: "border-blue-500",
  k8s-bg: "bg-blue-50 dark:bg-blue-900/20",
  // Section header - quiet, one hairline, no gradient border
  section-header: "flex items-center gap-3 text-base font-semibold tracking-tight text-zinc-900 dark:text-zinc-100 pb-2.5 border-b border-zinc-200 dark:border-zinc-700",
)

// Nerd Font icons for HTML (same as design.typ)
#let nf-icon-html(name) = {
  let icons = (
    // Social (nf-fa brand icons)
    "github": "\u{f09b}",      // nf-fa-github
    "linkedin": "\u{f0e1}",    // nf-fa-linkedin
    "twitter": "\u{f099}",     // nf-fa-twitter
    "telegram": "\u{f2c6}",    // nf-fa-telegram
    "blog": "\u{f02d}",        // nf-fa-book
    // Contact (nf-md icons)
    "email": "󰇮",              // nf-md-email
    "phone": "\u{f095}",       // nf-fa-phone
    "location": "\u{f041}",    // nf-fa-map_marker
    "website": "󰖟",            // nf-md-web
    // Sections (nf-fa icons)
    "summary": "\u{f15c}",     // nf-fa-file_text
    "experience": "\u{f0b1}",  // nf-fa-briefcase
    "education": "\u{f19d}",   // nf-fa-graduation_cap
    "certifications": "\u{f0a3}", // nf-fa-certificate
    "skills": "\u{f121}",      // nf-fa-code
    "languages": "\u{f1ab}",   // nf-fa-language
    "projects": "\u{f07b}",    // nf-fa-folder_open
    "speaking": "\u{f130}",    // nf-fa-microphone
    "k8s": "󱃾",                // nf-md-kubernetes
    // Navigation bar icons
    "pdf": "󰈙",                // nf-md-file_pdf_box
    "download": "󰇚",           // nf-md-download
  )
  let icon-char = icons.at(lower(name), default: "")
  html.elem("span", attrs: (class: "nf mr-1"))[#icon-char]
}

#let format-date-range-html(start, end, lang: "en") = {
  let end-text = if end == "" or end == none { t("present", lang) } else { end }
  start + " — " + end-text
}

// Section title: a quiet mono "command" (e.g. `~/experience`) sits above the
// real, legible heading — terminal as identity accent, not a literal command.
#let section-title(id, icon-name, label, slug) = {
  html.div(class: "mb-3")[
    #html.p(class: "section-command mb-1", aria-hidden: true)[
      #html.span(class: "chevron")[❯] #html.span[#"~/"#slug]
    ]
    #html.h2(id: id, class: tw.section-header)[#nf-icon-html(icon-name) #label]
  ]
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN DOCUMENT
// ═══════════════════════════════════════════════════════════════════════════════

#set document(
  title: data.basics.name + " - " + data.basics.label,
  author: data.basics.name,
)

// ═══════════════════════════════════════════════════════════════════════════════
// NAVIGATION BAR
// ═══════════════════════════════════════════════════════════════════════════════

#html.nav(class: "fixed top-0 left-0 right-0 z-50 bg-white/90 dark:bg-zinc-900/90 backdrop-blur-sm border-b border-zinc-200 dark:border-zinc-700 print:hidden", aria-label: "Document options")[
  #html.div(class: "max-w-4xl mx-auto px-4 py-3 flex items-center justify-between gap-4")[
    // Language Switch
    #html.div(class: "flex items-center gap-2")[
      #html.span(class: "text-xs text-zinc-500 dark:text-zinc-400 hidden sm:inline")[#nf-icon-html("languages") #if lang == "en" { "Language:" } else { "Idioma:" }]
      #if lang == "en" [
        #html.span(class: "text-sm font-semibold text-indigo-600 dark:text-indigo-400 px-2 py-1 rounded-md border border-indigo-200 dark:border-indigo-800 bg-indigo-50/60 dark:bg-indigo-900/20")[EN]
        #html.a(href: "../ptbr/index.html", class: "text-sm text-zinc-500 dark:text-zinc-400 hover:text-indigo-600 dark:hover:text-indigo-400 px-2 py-1 rounded-md hover:bg-zinc-100 dark:hover:bg-zinc-800 transition-colors")[PT]
      ] else [
        #html.a(href: "../en/index.html", class: "text-sm text-zinc-500 dark:text-zinc-400 hover:text-indigo-600 dark:hover:text-indigo-400 px-2 py-1 rounded-md hover:bg-zinc-100 dark:hover:bg-zinc-800 transition-colors")[EN]
        #html.span(class: "text-sm font-semibold text-indigo-600 dark:text-indigo-400 px-2 py-1 rounded-md border border-indigo-200 dark:border-indigo-800 bg-indigo-50/60 dark:bg-indigo-900/20")[PT]
      ]
    ]

    // PDF Downloads
    #html.div(class: "flex items-center gap-2")[
      #html.span(class: "text-xs text-zinc-500 dark:text-zinc-400 hidden sm:inline")[#nf-icon-html("pdf") PDF:]
      #html.a(href: "resume.pdf", class: "inline-flex items-center gap-1 text-xs font-medium text-indigo-600 dark:text-indigo-400 hover:text-indigo-800 dark:hover:text-indigo-300 px-2 py-1 rounded border border-indigo-400 dark:border-indigo-700 hover:bg-indigo-50 dark:hover:bg-indigo-900/20 transition-colors", download: "")[#nf-icon-html("download") Full]
      #html.a(href: "resume-onepage.pdf", class: "inline-flex items-center gap-1 text-xs font-medium text-indigo-600 dark:text-indigo-400 hover:text-indigo-800 dark:hover:text-indigo-300 px-2 py-1 rounded border border-indigo-400 dark:border-indigo-700 hover:bg-indigo-50 dark:hover:bg-indigo-900/20 transition-colors", download: "")[#nf-icon-html("download") 1-Page]
    ]

    // Theme Toggle
    #html.elem("button",
      attrs: (
        id: "theme-toggle",
        type: "button",
        class: "p-2 rounded-full bg-zinc-200 dark:bg-zinc-700 hover:bg-zinc-300 dark:hover:bg-zinc-600 shadow transition-all duration-300 cursor-pointer",
        "aria-label": "Toggle dark mode",
        onclick: "toggleTheme()"
      )
    )[
      #html.span(id: "icon-sun", class: "hidden dark:block text-lg")[☀️]
      #html.span(id: "icon-moon", class: "block dark:hidden text-lg")[🌙]
    ]
  ]
]

#html.div(class: "h-14 print:hidden")[]

// ═══════════════════════════════════════════════════════════════════════════════
// TABLE OF CONTENTS (Floating sidebar)
// ═══════════════════════════════════════════════════════════════════════════════

#html.nav(id: "toc", class: "fixed right-12 top-1/2 -translate-y-1/2 hidden xl:block w-56 print:hidden", aria-label: "Table of contents")[
  #html.div(class: "bg-white/70 dark:bg-zinc-800/70 backdrop-blur-sm rounded-lg shadow-sm border border-zinc-200/70 dark:border-zinc-700/70 p-4")[
    #html.p(class: "section-command mb-3")[#if lang == "en" { "Navigation" } else { "Navegação" }]
    #html.ul(class: "space-y-2 text-sm")[
      #html.li[#html.a(href: "#summary-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("summary") #t("summary", lang)]]
      #html.li[#html.a(href: "#experience-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("experience") #t("experience", lang)]]
      #html.li[#html.a(href: "#education-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("education") #t("education", lang)]]
      #html.li[#html.a(href: "#certs-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("certifications") #t("certifications", lang)]]
      #html.li[#html.a(href: "#skills-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("skills") #t("skills", lang)]]
      #html.li[#html.a(href: "#languages-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("languages") #t("languages", lang)]]
      #html.li[#html.a(href: "#projects-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("projects") #t("projects", lang)]]
      // #html.li[#html.a(href: "#publications-title", class: "flex items-center gap-2 text-zinc-600 dark:text-zinc-300 hover:text-indigo-600 dark:hover:text-indigo-400 transition-colors")[#nf-icon-html("speaking") #t("publications", lang)]]
    ]
  ]
]

// ═══════════════════════════════════════════════════════════════════════════════
// HEADER
// ═══════════════════════════════════════════════════════════════════════════════

#html.header(class: "pb-8 mb-8 border-b border-zinc-200 dark:border-zinc-700", role: "banner")[
  // Name and label (centered) — single minimal prompt line as the only terminal cue,
  // no simulated window, no gradient text.
  #html.div(class: "text-center mb-6")[
    #html.p(class: "prompt mb-2", aria-hidden: true)[
      #html.span(class: "prompt-user")[joao]#html.span(class: "prompt-accent")[#"@"]#html.span(class: "prompt-user")[backend]#html.span[#":~"]
    ]
    #html.h1(class: "text-4xl sm:text-5xl font-bold tracking-tight text-zinc-900 dark:text-zinc-100 mb-2")[
      #data.basics.name #html.span(class: "cursor-blink", aria-hidden: true)[▌]
    ]
    #html.p(class: "text-lg font-medium text-zinc-500 dark:text-zinc-400")[#data.basics.label]
  ]

  // Photo + Contact + Social (3 equal columns)
  #html.div(class: tw.bg-card + " p-8")[
    #html.div(class: "grid grid-cols-1 md:grid-cols-3 gap-8 md:divide-x divide-zinc-200 dark:divide-zinc-700")[
      // Photo (left) — discreet ring, no glow
      #html.div(class: "flex justify-center items-center")[
        #if data.basics.at("image", default: none) != none [
          #html.img(
            src: "../" + data.basics.image,
            alt: data.basics.name,
            class: "photo-ring w-36 h-36 rounded-full object-cover object-top"
          )
        ]
      ]

      // Contact info (center)
      #html.div(class: "md:pl-8")[
        #html.h3(class: "section-command mb-4")[#t("contact", lang)]
        #html.address(class: "not-italic space-y-3")[
          #html.a(href: "mailto:" + data.basics.email, class: "flex items-start gap-2 text-sm text-zinc-700 dark:text-zinc-300 " + tw.accent-hover + " hover:underline")[#html.span(class: "mt-0.5")[#nf-icon-html("email")] #data.basics.email]
          #html.a(href: "tel:" + clean-phone, class: "flex items-start gap-2 text-sm text-zinc-700 dark:text-zinc-300 " + tw.accent-hover + " hover:underline")[#html.span(class: "mt-0.5")[#nf-icon-html("phone")] #data.basics.phone]
          #html.span(class: "flex items-start gap-2 text-sm text-zinc-500")[#html.span(class: "mt-0.5")[#nf-icon-html("location")] #data.basics.location.city, #data.basics.location.region]
          #html.a(href: data.basics.url, class: "flex items-start gap-2 text-sm text-zinc-700 dark:text-zinc-300 " + tw.accent-hover + " hover:underline", target: "_blank")[#html.span(class: "mt-0.5")[#nf-icon-html("website")] Website]
        ]
      ]

      // Social links (right)
      #html.div(class: "md:pl-8")[
        #html.h3(class: "section-command mb-4")[#t("social", lang)]
        #html.nav(class: "space-y-3", aria-label: "Social profiles")[
          #for profile in data.basics.profiles [
            #html.a(href: profile.url, class: "flex items-start gap-2 text-sm font-medium text-zinc-700 dark:text-zinc-300 " + tw.accent-hover + " transition-colors", target: "_blank", rel: "noopener")[#html.span(class: "mt-0.5")[#nf-icon-html(profile.network)] #profile.network]
          ]
        ]
      ]
    ]
  ]
]

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN CONTENT
// ═══════════════════════════════════════════════════════════════════════════════

#html.main(class: "space-y-10")[
  // SUMMARY
  #html.section(class: "space-y-4", aria-labelledby: "summary-title")[
    #section-title("summary-title", "summary", t("summary", lang), "summary")
    #html.p(class: tw.bg-card + " p-5 leading-relaxed text-zinc-700 dark:text-zinc-300")[#data.basics.summary]
  ]

  // WORK EXPERIENCE
  #html.section(class: "space-y-4", aria-labelledby: "experience-title")[
    #section-title("experience-title", "experience", t("experience", lang), "experience")

    #for job in data.work [
      #html.article(class: "pb-5 mb-5 border-b border-zinc-200 dark:border-zinc-700 last:border-b-0 last:mb-0 last:pb-0")[
        #html.header(class: "flex flex-col sm:flex-row sm:justify-between sm:items-start gap-2 mb-3")[
          #html.div(class: "flex-1")[
            #html.h3(class: "text-xl font-bold text-zinc-900 dark:text-zinc-100 mb-1")[#job.position]
            #html.p(class: "text-base text-zinc-700 dark:text-zinc-300")[
              #html.span(class: "text-zinc-500")[ #t("at", lang) ]
              #html.a(href: job.url, class: "font-medium " + tw.accent-text + " hover:underline", target: "_blank", rel: "noopener")[#job.name]
            ]
            #if job.at("summary", default: none) != none [
              #html.p(class: "text-sm italic " + tw.muted-text + " mt-1")[#job.summary]
            ]
          ]
          #html.span(class: "badge-mono shrink-0 px-3 py-1.5 rounded-md whitespace-nowrap")[
            #format-date-range-html(job.startDate, job.at("endDate", default: none), lang: lang)
          ]
        ]

        #if job.at("highlights", default: none) != none and job.highlights.len() > 0 [
          #html.ul(class: "mt-3 pl-4 space-y-2")[
            #for highlight in job.highlights [
              #html.li(class: "relative pl-4 text-sm text-zinc-700 dark:text-zinc-300 leading-relaxed before:content-['•'] before:absolute before:left-0 before:text-indigo-500 before:font-bold")[#highlight]
            ]
          ]
        ]
      ]
    ]
  ]

  // EDUCATION
  #html.section(class: "space-y-4", aria-labelledby: "education-title")[
    #section-title("education-title", "education", t("education", lang), "education")

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
      #for edu in data.education [
        #html.article(class: tw.bg-card + " p-4")[
          #html.h3(class: "text-base font-semibold text-zinc-900 dark:text-zinc-100 mb-1")[#edu.studyType]
          #html.p(class: "text-sm text-zinc-700 dark:text-zinc-300 mb-2")[#edu.area]
          #html.p(class: "text-xs " + tw.muted-text)[#edu.institution #html.span(class: "mx-2")[•] #html.span(class: "font-mono-ui")[#edu.startDate]]
        ]
      ]
    ]
  ]

  // CERTIFICATIONS
  #html.section(class: "space-y-4", aria-labelledby: "certs-title")[
    #section-title("certs-title", "certifications", t("certifications", lang), "certifications")

    #{
      let k8s-certs = filter-k8s-certs(data.certificates)

      if k8s-certs.len() > 0 [
        #html.div(class: "flex items-center gap-4 " + tw.k8s-bg + " border " + tw.k8s-border + " p-4 rounded-lg mb-5")[
          #html.span(class: "text-4xl nf " + tw.k8s-text)[󱃾]
          #html.div[
            #html.h3(class: "text-base font-bold " + tw.k8s-text + " uppercase tracking-wider mb-1")[#t("k8s-title", lang)]
            #html.p(class: "text-sm " + tw.k8s-text)[#get-k8s-certs-text(data.certificates)]
          ]
        ]
      ]
    }

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-3")[
      #{
        for cert in filter-other-certs(data.certificates) [
          #html.article(class: "card-panel rounded-md p-3")[
            #html.h3(class: "text-sm font-semibold text-zinc-900 dark:text-zinc-100 mb-1")[#cert.name]
            #html.p(class: "text-xs " + tw.muted-text)[#cert.issuer #html.span(class: "mx-2")[•] #html.span(class: "font-mono-ui")[#cert.date]]
          ]
        ]
      }
    ]
  ]

  // SKILLS
  #html.section(class: "space-y-4", aria-labelledby: "skills-title")[
    #section-title("skills-title", "skills", t("skills", lang), "skills")

    #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
      #for skill in data.skills [
        #html.article(class: "mb-2")[
          #html.h3(class: "text-sm font-semibold text-zinc-800 dark:text-zinc-200 mb-2")[#skill.name]
          #html.ul(class: "flex flex-wrap gap-2")[
            #for keyword in skill.keywords [
              #html.li(class: "badge-mono px-2.5 py-1 rounded")[#keyword]
            ]
          ]
        ]
      ]
    ]
  ]

  // LANGUAGES
  #html.section(class: "space-y-4", aria-labelledby: "languages-title")[
    #section-title("languages-title", "languages", t("languages", lang), "languages")

    #html.div(class: "grid grid-cols-2 md:grid-cols-3 gap-4")[
      #for language in data.languages [
        #html.article(class: tw.bg-card + " p-3 text-center")[
          #html.h3(class: "text-base font-semibold text-zinc-900 dark:text-zinc-100 mb-1")[#language.language]
          #html.p(class: "text-xs " + tw.muted-text)[#language.fluency]
        ]
      ]
    ]
  ]

  // PROJECTS
  #if data.at("projects", default: none) != none and data.projects.len() > 0 [
    #html.section(class: "space-y-4", aria-labelledby: "projects-title")[
      #section-title("projects-title", "projects", t("projects", lang), "projects")

      #html.div(class: "grid grid-cols-1 md:grid-cols-2 gap-4")[
        #for project in data.projects [
          #html.article(class: "card-panel rounded-lg p-4")[
            #html.h3(class: "text-base font-semibold mb-2")[
              #html.a(href: project.url, class: tw.accent-text + " hover:underline", target: "_blank", rel: "noopener")[#project.name]
            ]
            #html.p(class: "text-sm " + tw.muted-text + " leading-relaxed")[#project.description]
          ]
        ]
      ]
    ]
  ]

  // PUBLICATIONS/TALKS
  // #if data.at("publications", default: none) != none and data.publications.len() > 0 [
  //   #html.section(class: "space-y-4", aria-labelledby: "publications-title")[
  //     #html.h2(id: "publications-title", class: tw.section-header)[#nf-icon-html("speaking") #t("publications", lang)]
  //
  //     #for pub in data.publications [
  //       #html.article(class: "flex gap-4 mb-4 last:mb-0")[
  //         #html.span(class: "shrink-0 text-xs font-medium " + tw.muted-text + " bg-zinc-100 dark:bg-zinc-700 px-2 py-1 rounded h-fit")[#pub.releaseDate]
  //         #html.div[
  //           #html.h3(class: "text-base font-semibold text-zinc-900 dark:text-zinc-100 mb-1")[#pub.name]
  //           #html.p(class: "text-sm " + tw.muted-text)[#pub.summary]
  //         ]
  //       ]
  //     ]
  //   ]
  // ]
]

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════════════════════════

#html.footer(class: "mt-12 pt-6 border-t border-zinc-200 dark:border-zinc-700 text-center", role: "contentinfo")[
  #html.p(class: "text-sm " + tw.muted-text)[
    #datetime.today().year() #data.basics.name
  ]
]
