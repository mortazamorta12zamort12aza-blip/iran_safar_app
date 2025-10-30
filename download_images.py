#!/usr/bin/env python3
"""Download images for places from Wikimedia (fa / en) into assets/images/places/
Run: python3 scripts/download_images.py
"""
import os, json, requests, time
ROOT = os.path.dirname(os.path.dirname(__file__))
PLACES = os.path.join(ROOT, 'assets', 'data', 'places_full.json')
IMG_DIR = os.path.join(ROOT, 'assets', 'images', 'places')
os.makedirs(IMG_DIR, exist_ok=True)
with open(PLACES, 'r', encoding='utf-8') as f:
    data = json.load(f)
session = requests.Session()
session.headers.update({'User-Agent':'IranSafarImageDownloader/1.0'})
def find_image_fa(query):
    res = session.get('https://fa.wikipedia.org/w/api.php', params={
        'action':'query','list':'search','srsearch':query,'format':'json','srlimit':1
    }).json()
    if res.get('query',{}).get('search'):
        title = res['query']['search'][0]['title']
        r = session.get('https://fa.wikipedia.org/w/api.php', params={
            'action':'query','prop':'images','titles':title,'format':'json'
        }).json()
        pages = r.get('query',{}).get('pages',{})
        for p in pages.values():
            for im in p.get('images',[]):
                name = im.get('title')
                if name.lower().endswith(('.jpg','.jpeg','.png')):
                    ii = session.get('https://fa.wikipedia.org/w/api.php', params={
                        'action':'query','titles':name,'prop':'imageinfo','iiprop':'url','format':'json'
                    }).json()
                    for page in ii.get('query',{}).get('pages',{}).values():
                        if 'imageinfo' in page:
                            return page['imageinfo'][0].get('url')
    return None

count = 0
for place in data.get('places',[]):
    name = place.get('name')
    target = os.path.join(ROOT, place.get('image').lstrip('/'))
    if os.path.exists(target) and os.path.getsize(target) > 2000:
        print('exists', target); continue
    query = f"{name} {place.get('city')} {place.get('province')}"
    print('searching', query)
    url = find_image_fa(query)
    if not url:
        # try en.wikipedia
        res = session.get('https://en.wikipedia.org/w/api.php', params={
            'action':'query','list':'search','srsearch':query,'format':'json','srlimit':1
        }).json()
        if res.get('query',{}).get('search'):
            title = res['query']['search'][0]['title']
            r = session.get('https://en.wikipedia.org/w/api.php', params={
                'action':'query','prop':'images','titles':title,'format':'json'
            }).json()
            pages = r.get('query',{}).get('pages',{})
            for p in pages.values():
                for im in p.get('images',[]):
                    name2 = im.get('title')
                    if name2.lower().endswith(('.jpg','.jpeg','.png')):
                        ii = session.get('https://en.wikipedia.org/w/api.php', params={
                            'action':'query','titles':name2,'prop':'imageinfo','iiprop':'url','format':'json'
                        }).json()
                        for page in ii.get('query',{}).get('pages',{}).values():
                            if 'imageinfo' in page:
                                url = page['imageinfo'][0].get('url'); break
                    if url: break
    if url:
        print('downloading', url)
        r = session.get(url, stream=True)
        if r.status_code == 200:
            with open(target, 'wb') as f:
                for chunk in r.iter_content(1024):
                    f.write(chunk)
            count += 1
            time.sleep(0.5)
        else:
            print('failed', r.status_code)
    else:
        print('not found', name)
print('done, downloaded', count)
