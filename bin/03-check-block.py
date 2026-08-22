#!/usr/bin/env python3
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