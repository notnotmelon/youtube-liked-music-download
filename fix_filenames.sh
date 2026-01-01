for file in ./*.mp3;
do
    mv -- "$file" "$(echo "$file" | sed -e 's/NA - //')";
done
