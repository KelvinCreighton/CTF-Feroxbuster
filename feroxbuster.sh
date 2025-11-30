DEFAULT_WORDLIST="./wordlists/common.txt"     # From: SecLists-master/Discovery/Web-Content/common.txt"

read -p "URL: " url
read -p "Wordlist: <default=common.txt> " wordlist
read -p "Flag format: " flagformat

if [[ -z "$flagformat" ]]; then
    echo "Flag format is required."
    exit 1
fi

wordlist="${wordlist:-$DEFAULT_WORDLIST}"

if [[ ! -f "$wordlist" ]]; then
    echo "Wordlist not found: $wordlist"
    exit 1
fi

feroxbuster -u "$url" -w "$wordlist" | tee >(grep "http" | awk '{print $NF}' > urls.txt)

echo "======================="
echo "Subdirectories located"
echo "URLs saved to 'urls.txt'"
echo "Searching for FLAG"
echo "======================="

while read -r url; do
    curl -i -s -f --max-time 10 "$url" 2>/dev/null | grep -i "$flagformat"
done < urls.txt
