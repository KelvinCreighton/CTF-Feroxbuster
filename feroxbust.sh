DIR="./wordlists"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Directory $DIR does not exist"
    exit 1
fi

# Check if the directory is empty
if [ -z "$(ls -A "$DIR")" ]; then
    echo "No wordlists in directory $DIR"
    exit 1
fi

read -p "URL: " URL
read -p "Flag format: " FLAGFORMAT

# Verify input for $URL
if [[ -z "$URL" ]]; then
    echo "URL is required."
    exit 1
fi

# Verify input for $FLAGFORMAT
if [[ -z "$FLAGFORMAT" ]]; then
    echo "Flag format is required."
    exit 1
fi

# Enable safe globbing
shopt -s nullglob

WORDLISTS=("$DIR"/*)

set -o pipefail

feroxbuster -u "$URL" -w <(sort -u "${WORDLISTS[@]}") | tee >(grep "http" | awk '{print $NF}' > urls.txt) || exit 1

echo "======================="
echo "Subdirectories located"
echo "URLs saved to 'urls.txt'"
echo "Searching for FLAG"
echo "======================="

while read -r url; do
    curl -i -s -f --max-time 10 "$url" 2>/dev/null | grep -i "$FLAGFORMAT"
done < urls.txt
