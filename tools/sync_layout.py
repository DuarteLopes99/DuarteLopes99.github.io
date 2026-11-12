#!/usr/bin/env python3
"""Copy the shared header and footer from index.html into every other page.

The site has no build step, so the header and footer markup is repeated in each
HTML file. Edit them in index.html only, then run:

    python3 tools/sync_layout.py

The script marks the current page in the main nav with aria-current="page".
It touches nothing outside the <header class="site-header"> and
<footer class="site-footer"> blocks.
"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
HEADER = re.compile(r'  <header class="site-header">.*?</header>', re.S)
FOOTER = re.compile(r'  <footer class="site-footer".*?</footer>', re.S)


def main() -> int:
    home = (ROOT / "index.html").read_text(encoding="utf-8")
    header = HEADER.search(home).group(0)
    footer = FOOTER.search(home).group(0)

    changed = 0
    for page in sorted(ROOT.glob("*.html")):
        if page.name == "index.html":
            continue
        text = page.read_text(encoding="utf-8")
        if not HEADER.search(text) or not FOOTER.search(text):
            print(f"skip {page.name}: header or footer block not found")
            continue
        own_header = header.replace(
            f'<li><a href="{page.name}">', f'<li><a href="{page.name}" aria-current="page">', 1
        )
        new = HEADER.sub(lambda _: own_header, text, count=1)
        new = FOOTER.sub(lambda _: footer, new, count=1)
        if new != text:
            page.write_text(new, encoding="utf-8")
            changed += 1
            print(f"updated {page.name}")
    print(f"{changed} page(s) updated")
    return 0


if __name__ == "__main__":
    sys.exit(main())
