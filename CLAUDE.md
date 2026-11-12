# Notes for AI assistants working on this repo

Read README.md first. Its "Design rules" section is binding: palette, single type family,
no cards, no all-caps or monospaced labels, one animation only, kit yellow never as text on light backgrounds.

Working rules:

- Plain static site: HTML, CSS, a little vanilla JS. No framework or build step without the owner's approval.
- Hosted on GitHub Pages. Keep every path relative and keep pages as flat files at the root.
- Header and footer are edited in index.html, then copied with `python3 tools/sync_layout.py`.
- After editing cv.html, run `./tools/build_cv.sh` and keep the PDF at two pages.
- Never publish a phone number, home address or date of birth. The email address is public on purpose.
- Strip metadata from every photo and export AVIF, WebP and JPEG.
- Check 375, 768, 1024 and 1440px widths for overflow, console errors and broken links before committing.
- Work on a branch. Do not push to main or change Pages settings without the owner's approval.
- Do not use em dashes in site copy; the owner prefers commas or other punctuation.
