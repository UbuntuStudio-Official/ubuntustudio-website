# Ubuntu Studio Website Content Repository

This repository is the GitHub-managed content source for Ubuntu Studio website/help/wiki pages.

## What Contributors Should Do

1. Find the right content bucket:
   - `help/content/` for help hub pages.
   - `wiki/content/` for wiki hub pages.
2. Edit existing Markdown files in place when possible.
3. Keep links and image references repository-relative.
4. Open a pull request with a clear summary of:
   - What changed.
   - Why it changed.
   - Any pages moved/renamed.

> wordpress markdown reference
> https://wordpress.com/support/markdown-quick-reference/

## Repository Layout

- `help/index.md`: landing page for the help content hub.
- `help/content/`: help pages grouped by bucket.
- `wiki/index.md`: landing page for the wiki content hub.
- `wiki/content/`: wiki pages grouped by bucket.
- `wiki/content/_assets/`: localized assets used by wiki pages.

## Pitfalls We Already Hit (And How To Avoid Them)

### 1) File/Folder Name Collisions Break Publish Pipelines

Problem:
- A directory cannot safely contain both `Name.md` and `Name/` once extensionless slug mapping is applied.
- This can crash Git it Write during publish.

Avoid it:
- Use directory index pages instead of sibling file+folder names.
- If you see both forms, convert:
  - `Name.md` -> `Name/index.md`

Quick check:

```bash
python3 - <<'PY'
from pathlib import Path
roots=[Path('help/content'),Path('wiki/content')]
collisions=[]
for root in roots:
    if not root.exists():
        continue
    for p in root.rglob('*.md'):
        if p.name.lower()=='index.md':
            continue
        d=p.with_suffix('')
        if d.is_dir():
            collisions.append((p.as_posix(), d.as_posix()))
print(f'collisions={len(collisions)}')
for a,b in collisions[:30]:
    print(a,'<->',b)
PY
```

Expected: `collisions=0`

### 2) Internal Links Must Not End In `.md` or `index.md`

Problem:
- Git it Write maps pages to extensionless URL slugs.
- If an internal link includes the `.md` extension (e.g., `[Page](Foo.md)`) or ends in `index.md` (e.g., `[Page](Bar/index.md)`), the link will resolve to the raw file on GitHub rather than the published page on the site.

Avoid it:
- Write internal links without the file extension and without the `index.md` filename:
  - `[Page](content/support/UbuntuStudio--FAQ)` ✓
  - `[Page](content/handbook/UbuntuStudio--AudioHandbook--GettingStarted)` ✓
  - `[Page](content/support/UbuntuStudio--FAQ.md)` ✗
  - `[Page](content/handbook/)` ✓  (directory links resolve to the index page)
  - `[Page](content/handbook/index.md)` ✗

Quick check:

```bash
grep -rn '\.md)' help/content/ wiki/content/ help/index.md wiki/index.md
```

Expected: no output.

### 3) Standalone `---` Can Be Misread As YAML Front Matter

Problem:
- Some pages with standalone Markdown separators `---` were interpreted as YAML blocks.
- This caused Symfony YAML parse errors during publish.

Avoid it:
- Use `***` for visual separators in page bodies.
- Reserve front matter style delimiters only when real YAML front matter is intended.

Quick check (current high-risk area):

```bash
python3 - <<'PY'
from pathlib import Path
root=Path('wiki/content/ubuntu-studio')
remain=[]
for p in root.rglob('*.md'):
    txt=p.read_text(encoding='utf-8',errors='ignore').splitlines()
    cnt=sum(1 for l in txt if l.strip()=='---')
    if cnt>=2:
        remain.append((p.as_posix(),cnt))
print(f'remaining_files_with_2plus_triple_dash={len(remain)}')
for p,c in remain[:20]:
    print(f'{c} {p}')
PY
```

Expected: `remaining_files_with_2plus_triple_dash=0`

## Content Conventions

- Keep historical/source attribution links when present.
- Prefer minimal, scoped edits instead of large rewrites.
- Do not reintroduce obsolete workflow guidance (for example, old Backports PPA guidance).
- Keep category cleanup intact (do not add old imported category artifacts back).

## Pre-PR Checklist

- [ ] Edited in the correct bucket under `help/content/` or `wiki/content/`.
- [ ] Links and assets are relative and valid.
- [ ] Internal links do not end in `.md` or `index.md`.
- [ ] No file/folder slug collisions introduced.
- [ ] No accidental standalone `---` separators introduced in body text.
- [ ] Obsolete guidance was not reintroduced.

## Notes For Large Imports/Mirroring

If you run a migration/scrape/update script:

1. Run the two quick checks above.
2. Spot-check bucket index pages still resolve correctly.
3. Confirm moved pages use `index.md` when transitioning from file to directory.
4. Include a short import summary in your PR description (written/failed counts and scope).
