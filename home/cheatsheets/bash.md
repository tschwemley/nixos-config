# Bash Cheatsheet

Here's a simple and concise cheatsheet for creating, using, and looping through arrays in Bash:

## Args

```bash
# Pass all args to another script/function/program/...
./script "$@"
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

## Paths

```bash
# Get the absolute path of the current script                                 
SCRIPT_PATH=$(readlink -f "$0")                                               
                                                                              
# Get the directory containing the current script                             
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
```
