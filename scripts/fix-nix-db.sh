# Run nix-collect-garbage with the -d option to delete old generations
# and capture any error messages related to SQLite statements.
out=$(nix-collect-garbage -d 2>&1 >/dev/null | sed -n "s/error: executing SQLite statement '\(delete.*\)\';'/\1/p")

# Check if there were any errors during garbage collection
if [ $? -ne 0 ]; then
    echo "Error: nix-collect-garbage failed"
    echo "$out"
    exit 1
fi

# Check if there were any SQLite errors during garbage collection
if [ -n "$out" ]; then
    echo "SQLite errors found during garbage collection:"
    echo "$out"
    exit 1
fi

echo "No errors found during garbage collection"

