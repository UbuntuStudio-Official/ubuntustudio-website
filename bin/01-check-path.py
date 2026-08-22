#!/usr/bin/env python3
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