sudo pacman -S jq
yt-dlp --cookies cookies.txt --flat-playlist --dump-single-json "https://www.youtube.com/playlist?list=LL" > playlist.json
jq -r '.entries[].id' playlist.json | sed 's_^_https://www.youtube.com/watch?v=_' > urls.txt
yt-dlp --cookies cookies.txt --dump-json --no-warnings --newline -a urls.txt > full_meta.ndjson
jq -c 'select(.is_music==true or (.categories|join(" ")|contains("Music")) or (.track!=null))' full_meta.ndjson > music_meta.ndjson
jq -r '.webpage_url' music_meta.ndjson > music_urls.txt
yt-dlp --cookies cookies.txt -a music_urls.txt -t mp3 -o '%(artist)s - %(title)s.%(ext)s'
