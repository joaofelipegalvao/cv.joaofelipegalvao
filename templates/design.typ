// Design System - Colors, Typography, and Styling
// This file centralizes all design tokens for consistent styling across templates
// Components are in the components/ directory

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE - Terminal-Premium Theme (neutral zinc + restrained indigo accent)
// ═══════════════════════════════════════════════════════════════════════════════

// Accent - Indigo, used sparingly (links, active icon, badges, dividers)
#let color-primary = rgb("#4f46e5")       // Indigo 600 - main accent
#let color-secondary = rgb("#3730a3")     // Indigo 800 - accent hover/emphasis
#let color-accent = rgb("#4f46e5")        // Indigo 600 - alias kept for compatibility
#let color-accent-soft = rgb("#eef2ff")   // Indigo 50 - soft badge/pill background
#let color-k8s = rgb("#326ce5")           // Kubernetes blue - ONLY for K8s certifications

// Text colors - Neutral zinc scale
#let color-text = rgb("#27272a")          // Zinc 800 - body text
#let color-text-bold = rgb("#18181b")     // Zinc 900 - headings
#let color-muted = rgb("#52525b")         // Zinc 600 - secondary text
#let color-subtle = rgb("#a1a1aa")        // Zinc 400 - tertiary/hints

// Background colors - Neutral, print-safe (white stays dominant)
#let color-bg-light = rgb("#fafafa")      // Zinc 50 - panel/card background
#let color-bg-card = rgb("#fafafa")       // Zinc 50 - subtle card background
#let color-bg-column = rgb("#fafafa")     // Column background - onepage
#let color-bg-white = white
#let color-k8s-bg = rgb("#eff6ff")        // Blue 50 - K8s highlight (keep blue here)

// Header colors (onepage) - Solid indigo, no gradient
#let color-header-bg = rgb("#4338ca")     // Indigo 700 - header background
#let color-header-text = white            // Pure white - header text
#let color-header-accent = rgb("#c7d2fe") // Indigo 200 - header accent (contrast)

// Border colors - Neutral zinc
#let color-divider = rgb("#e4e4e7")       // Zinc 200 - light border
#let color-divider-strong = rgb("#d4d4d8") // Zinc 300 - stronger border

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY - Font Families
// ═══════════════════════════════════════════════════════════════════════════════

// Sans is used for all body copy, headings and labels — legibility first.
#let font-primary = ("Liberation Sans", "DejaVu Sans", "Noto Sans")
#let font-sans = ("Liberation Sans", "DejaVu Sans", "Noto Sans")
// Mono is identity-only: prompts, date badges, small terminal-flavored tags.
#let font-mono = ("Liberation Mono", "DejaVu Sans Mono", "Noto Sans Mono")
#let font-icons = ("Symbols Nerd Font",)

// Helper to render mono "chrome" text (prompts, tiny labels, date badges)
#let mono-text(content, size: 8.5pt, color: none, weight: "regular") = {
  text(font: font-mono, size: size, fill: if color != none { color } else { color-muted }, weight: weight)[#content]
}

// Terminal prompt line, e.g. `joao@backend:~` — a single identity cue, not a window.
#let prompt-line(user: "joao", host: "backend", path: "~", size: 9pt) = {
  mono-text(size: size, color: color-subtle)[#user#text(fill: color-primary)[@]#host#text(fill: color-subtle)[:]#path#text(fill: color-primary, weight: "bold")[_]]
}

// Helper function to render Nerd Font icons
#let nf-icon(icon, size: 1em, color: none) = {
  let icon-color = if color != none { color } else { color-primary }
  text(font: font-icons, size: size, fill: icon-color)[#icon]
}

// ═══════════════════════════════════════════════════════════════════════════════
// TYPOGRAPHY - Font Sizes
// ═══════════════════════════════════════════════════════════════════════════════

// Full template sizes
#let size-name-full = 28pt
#let size-label-full = 12pt
#let size-section-full = 11pt
#let size-section-icon-full = 14pt
#let size-body-full = 10pt
#let size-job-title-full = 11pt
#let size-company-full = 10.5pt
#let size-date-full = 8.5pt
#let size-small-full = 9pt
#let size-highlight-full = 9.5pt

// Onepage template sizes (compact but readable)
#let size-name-onepage = 14pt
#let size-label-onepage = 8pt
#let size-section-onepage = 8pt
#let size-section-icon-onepage = 8pt
#let size-body-onepage = 7pt
#let size-job-title-onepage = 7pt
#let size-company-onepage = 5pt
#let size-date-onepage = 4.5pt
#let size-small-onepage = 5pt
#let size-highlight-onepage = 5pt

// ═══════════════════════════════════════════════════════════════════════════════
// SPACING
// ═══════════════════════════════════════════════════════════════════════════════

// Full template spacing (more air between elements — premium, less cramped)
#let spacing-section-full = 2em
#let spacing-block-full = 1.5em
#let spacing-line-full = 0.9em

// Onepage template spacing (compact but readable)
#let spacing-section-onepage = 0.4em
#let spacing-section-below-onepage = 0.6em
#let spacing-block-onepage = 0.4em
#let spacing-line-onepage = 0.4em

// ═══════════════════════════════════════════════════════════════════════════════
// BORDERS & RADIUS
// ═══════════════════════════════════════════════════════════════════════════════

#let radius-small = 4pt
#let radius-medium = 6pt
#let radius-large = 9pt

#let stroke-thin = 0.3pt
#let stroke-normal = 0.5pt
#let stroke-medium = 1pt
#let stroke-thick = 1.5pt

// ═══════════════════════════════════════════════════════════════════════════════
// PAGE MARGINS
// ═══════════════════════════════════════════════════════════════════════════════

#let margin-full = (x: 2cm, y: 1cm)
#let margin-onepage = (x: 0.8cm, y: 0.6cm)

// ═══════════════════════════════════════════════════════════════════════════════
// INSETS & PADDINGS
// ═══════════════════════════════════════════════════════════════════════════════

#let inset-header-full = (x: 18pt, y: 10pt)
#let inset-header-onepage = (x: 10pt, y: 6pt)
#let inset-block-full = 16pt
#let inset-block-onepage = 4pt
#let inset-card = 14pt
#let inset-small = 8pt
#let inset-badge = (x: 9pt, y: 5pt)
#let inset-badge-small = (x: 4pt, y: 2pt)

// ═══════════════════════════════════════════════════════════════════════════════
// GRID GUTTERS
// ═══════════════════════════════════════════════════════════════════════════════

#let gutter-large = 1.2em
#let gutter-medium = 1em
#let gutter-small = 0.8em
#let gutter-xs = 0.6em
#let gutter-xxs = 0.5em
#let gutter-tiny = 4pt

// ═══════════════════════════════════════════════════════════════════════════════
// TRACKING (Letter spacing)
// ═══════════════════════════════════════════════════════════════════════════════

#let tracking-wide = 1pt
#let tracking-normal = 0.5pt
#let tracking-tight = 0.3pt

// ═══════════════════════════════════════════════════════════════════════════════
// ICONS - Nerd Font Unicode characters
// ═══════════════════════════════════════════════════════════════════════════════

#let icon-summary = "\u{f15c}"       // nf-fa-file_text
#let icon-experience = "\u{f0b1}"    // nf-fa-briefcase
#let icon-education = "\u{f19d}"     // nf-fa-graduation_cap
#let icon-certifications = "\u{f0a3}" // nf-fa-certificate
#let icon-skills = "\u{f121}"        // nf-fa-code
#let icon-languages = "\u{f1ab}"     // nf-fa-language
#let icon-projects = "\u{f07b}"      // nf-fa-folder_open
#let icon-speaking = "\u{f130}"      // nf-fa-microphone
#let icon-k8s = "󱃾"                  // nf-md-kubernetes
#let icon-email = "󰇮"                // nf-md-email
#let icon-phone = "\u{f095}"         // nf-fa-phone
#let icon-location = "\u{f041}"      // nf-fa-map_marker
#let icon-website = "󰖟"              // nf-md-web

// Social media icons
#let icon-github = "\u{f09b}"        // nf-fa-github
#let icon-linkedin = "\u{f0e1}"      // nf-fa-linkedin
#let icon-twitter = "\u{f099}"       // nf-fa-twitter
#let icon-telegram = "\u{f2c6}"      // nf-fa-telegram
#let icon-blog = "\u{f02d}"          // nf-fa-book

// Get social media icon by network name
#let get-social-icon(network) = {
  let network-lower = lower(network)
  if network-lower == "github" { icon-github }
  else if network-lower == "linkedin" { icon-linkedin }
  else if network-lower == "twitter" { icon-twitter }
  else if network-lower == "telegram" { icon-telegram }
  else if network-lower == "blog" { icon-blog }
  else { "" }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════════════════════════════

// Format date range (full format)
#let format-date(start, end, lang: "en") = {
  let end-text = if end == "" or end == none {
    if lang == "en" { "Present" } else { "Atual" }
  } else { end }
  [#start — #end-text]
}

// Format date range (year only)
#let format-date-year(start, end, lang: "en") = {
  let start-year = if type(start) == str and start.len() >= 4 { start.slice(0, 4) } else { str(start) }
  let end-text = if end == "" or end == none {
    if lang == "en" { "Now" } else { "Atual" }
  } else {
    if type(end) == str and end.len() >= 4 { end.slice(0, 4) } else { str(end) }
  }
  [#start-year → #end-text]
}

// Date badge (full size) — mono, since dates/badges are the identity accent
#let date-badge(content, size: size-date-full) = {
  box(
    fill: color-bg-light,
    stroke: stroke-thin + color-divider,
    radius: radius-medium,
    inset: inset-badge,
  )[
    #mono-text(size: size, color: color-muted)[#content]
  ]
}

// Date badge (small/onepage size)
#let date-badge-small(content, size: size-date-onepage) = {
  box(
    fill: color-bg-light,
    radius: radius-small,
    inset: inset-badge-small,
  )[
    #mono-text(size: size, color: color-muted)[#content]
  ]
}

// Summary block
#let summary-block(content) = {
  block(
    fill: color-bg-light,
    stroke: stroke-thin + color-divider,
    radius: radius-large,
    inset: inset-block-full,
    width: 100%,
  )[
    #text(size: size-body-full, fill: color-text)[#content]
  ]
}

// Contact box (full)
#let contact-box-full(content) = {
  box(
    fill: color-bg-light,
    radius: radius-large,
    inset: inset-header-full,
  )[
    #text(size: size-date-full, fill: color-muted)[#content]
  ]
}

// Profile photo (circular crop)
// For best results, use a square image cropped to show the face
#let profile-photo(path, size: 80pt) = {
  box(
    width: size,
    height: size,
    radius: 50%,
    clip: true,
    stroke: stroke-normal + color-divider-strong,
  )[
    #image(path, width: size, height: size, fit: "cover")
  ]
}

// Profile photo small (for onepage) - zoomed into face
#let profile-photo-small(path, size: 45pt) = {
  box(
    width: size,
    height: size,
    radius: 50%,
    clip: true,
    stroke: 1.5pt + white,
    inset: 0pt,
  )[
    #align(center + top)[
      #image(path, width: size, fit: "cover")
    ]
  ]
}
