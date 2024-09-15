# Bash Cheatsheet: Arrays

Here's a simple and concise cheatsheet for creating, using, and looping through arrays in Bash:

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
