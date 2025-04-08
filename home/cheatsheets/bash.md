# Bash Cheatsheet

Here's a simple and concise cheatsheet for creating, using, and looping through arrays in Bash:

## Args

```bash
# Pass all args to another script/function/program/...
./script "$@"

# Check for num of args
if [ $# -eq 0 ] ;

# Check if specific arg empty
if [ -z "$1" ] ;

# Handle command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) 
            usage
            exit 0
            ;;
        -f|--file)
            filename="$2"
            shift 
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done

# Usage function example
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  -f, --file FILE Specify input file"
}
```

## Arrays

```bash
# Creating an array
array=("apple" "banana" "cherry")

# Accessing an element in the array (0-indexed)
echo ${array[0]}  # prints "apple"

# Checking if a string is in the array
[[ " ${array[@]} " =~ " banana " ]] && echo "Found!" || echo "Not found."

# Iterating over each element in the array
for item in "${array[@]}"; do
  echo $item
done
```

## Files

```bash
# Loop through files (reads all file names into memory && w/ globbing)
for file in /var/*
do
    #whatever you need with "$file"
done

# Loop through files (does not load all file names into memory && no globbing)
ls -f /var | while read -r file; do cmd $file; done
```

## Paths

```bash
# Get the absolute path of the current script
SCRIPT_PATH=$(readlink -f "$0")

# Get the directory containing the current script
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
```
