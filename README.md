# duartelopes99.github.io

Personal website of Duarte Lopes, data scientist working on machine learning and sports analytics.
Live at <https://duartelopes99.github.io> (GitHub Pages).

## The idea

**The page is a football pitch, cut by the touchline.**

The home page opens on mowing-striped grass. The first half of the headline, *"Right-back on the pitch,"*,
sits on the grass. A white touchline runs across the full width of the page, and the second half,
*"data scientist everywhere else."*, sits below it, off the pitch. The football photo straddles the line.

Everything else in the design follows from that line:

- Every inner page (Experience, Education, Projects, CV) opens with a shorter strip of the same pitch,
  with the page title on the grass and the touchline underneath.
- The timelines on Experience and Education are the touchline turned sideways: a vertical pitch-green
  line, with a kit-yellow marker for each role or degree.
- The palette comes from a match day: pitch green, white line paint, the pale grey-green of everything
  off the pitch, and the yellow of a kit, used only for highlights.

## Design rules

These keep the site looking like itself and not like a portfolio template. Please keep to them.

### Colour

| Token | Hex | Use |
|---|---|---|
| `--pitch` | `#215c3a` | Grass, footer, timeline line |
| `--pitch-alt` | `#1c5033` | Mowing stripes, mobile menu |
| `--line` | `#ffffff` | The touchline, text on grass |
| `--ground` | `#e4ebe2` | Everything off the pitch: hero lower half, tinted sections |
| `--paper` | `#f5f8f3` | Main content background |
| `--ink` | `#12301f` | Text (a dark green, not black) |
| `--ink-soft` | `#3d5646` | Secondary text |
| `--kit` | `#f2c230` | Hover highlight, focus ring on green, timeline markers |

Kit yellow is never used for text on a light background: it fails contrast.

### Type

- One family: **Public Sans** (400, 600, 700), self-hosted in `assets/fonts/`.
- Headlines 700 with tight tracking (about -0.035em). Body 400 at 19px, line height 1.6.
- Paragraphs are capped at about 38rem (`--measure`) so lines stay readable.

### Structure and decoration

- No cards, no shadows, no gradients other than the mowing stripes.
- No numbered markers (01, 02...) unless the content really is a sequence.
- No all-caps labels, no monospaced labels, no arrows appended to links.
- Lines and rules only where they carry meaning: the touchline, the timeline line, the rule between list entries.
- Links are underlined text. On hover they get a kit-yellow background, like a highlighter.
- Profile links (GitHub, LinkedIn, Strava, zerozero) are icons with hidden text labels and tooltips.
  The email address is always shown as text.

### Motion

- One moment only: on the home page the touchline draws across, then the second half of the headline
  and the intro fade in.
- Everything is visible without the animation, and it is switched off for `prefers-reduced-motion`.
- No scroll-triggered fade-ins on sections.

### Photos

- Exported as AVIF, WebP and JPEG at two or three widths, with all metadata (EXIF, location) removed.
- The hero photo loads eagerly, every other photo lazily.
- Captions state only facts that are certain.

### Accessibility and behaviour

- Semantic HTML, a skip link, visible keyboard focus, 44px touch targets for icon links.
- The nav works with JavaScript off. JavaScript only opens and closes the mobile menu.
- Checked at 375, 768, 1024 and 1440px with no horizontal overflow.

## Structure

```
index.html          Home: hero, contact, sports analytics, running
experience.html     Work and research timeline, publication
education.html      Education timeline, certificates
projects.html       Technical projects
cv.html             Web CV, also the source of the PDF
assets/css/styles.css
assets/js/main.js   Mobile menu only
assets/icons.svg    Icon sprite (Font Awesome Free, CC BY 4.0)
assets/fonts/       Public Sans (OFL) and CREDITS.md
assets/img/         Optimised photos
assets/cv/          Generated PDF of cv.html
tools/              Maintenance scripts
```

All paths are relative and the pages are flat files at the root, so the site works on GitHub Pages,
in a local server and in previews without changes.

## Editing

- **Content:** edit the page's HTML directly.
- **Header or footer:** edit them in `index.html`, then run `python3 tools/sync_layout.py` to copy them
  into every other page.
- **CV:** edit `cv.html`, then run `./tools/build_cv.sh`. It regenerates `assets/cv/Duarte_Lopes_CV.pdf`
  with headless Chrome and warns if the PDF is not two pages.
- **Preview locally:** `python3 -m http.server` in the repo root, then open <http://localhost:8000>.
  Opening the files directly (`file://`) blocks the fonts.

## Credits

Public Sans (SIL Open Font License). Icons from Font Awesome Free 5 (CC BY 4.0).
Photos are Duarte's own or used with the photographers' permission.
