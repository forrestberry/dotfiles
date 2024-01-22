title = input('Title: ')
author = input('Author(s) (separate authors by comma): ')
tags = input('Tags (separate by a space): ')

# Title Formatting

if title != title.upper():
    title = title.title()
shortTitle = ''

if title[0:3] == 'The':
    shortTitle = title[4:] + '.md'
elif title[0:1] == 'A ':
    shortTilte = title[2:] + '.md'
else:
    shortTitle = title + '.md'

shortTitle = shortTitle.lower()

# Author Formatting
authorList = author.split(', ')
authors = []
for author in authorList:
    author = '\n\t- '+ author
    authors.append(author)
authors = ''.join(authors)

# Tag Formatting
tags = tags.title()
tagList = tags.split(' ')
tags = []
tags.append('\n\t- ReadingNotes')
for tag in tagList:
    tag = '\n\t- '+ tag
    tags.append(tag)
tags = ''.join(tags)

# YAML Matter
yaml = {
    'title: ' : title,
    '\nauthor: ' : authors,
    '\ntags: ' : tags,
}

# Write to File 
with open(shortTitle, 'a', encoding='utf-8') as doc:
    doc.write('---\n')
    for k,v in yaml.items():
        doc.write(k)
        doc.write(v)
    doc.write('\n---\n# '+ title)

import copy_paste

copy_paste.copy(f'vim "{shortTitle}"')
