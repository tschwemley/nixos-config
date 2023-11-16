db_file="/nix/var/nix/db/db.sqlite"
backup_db_file="/nix/var/nix/db/db_backup_$(date +%Y%m%d%H%M%S).sqlite"
max_retries=10000
retry_count=0

# Create a backup of the SQLite database file
cp "$db_file" "$backup_db_file"
echo "Created a backup of the SQLite database at $backup_db_file"

while true; do
  # Run nix-collect-garbage with the -d option to delete old generations
  # and capture any error messages related to SQLite statements.
  #out=$(nix-collect-garbage -d 2>&1 >/dev/null | sed -n "s/.*error: executing SQLite statement '\(delete.*\)\';'/\1/p")
  out=$(nix-collect-garbage -d 2>&1 >/dev/null | sed -n "s/.*error: executing SQLite statement '\(delete.*';\).*/\1/p")

  # If there are no more errors, break the loop
  if [ -z "$out" ]; then
    break
  fi

  # If the maximum number of retries has been reached, exit the loop
  if [ $retry_count -ge $max_retries ]; then
    echo "Maximum number of retries ($max_retries) reached. Exiting."
    exit 1
  fi

  # Increment the retry count
  retry_count=$((retry_count + 1))

  # Extract the path from the error message
  path_to_delete=$(echo "$out" | sed -n "s/.*path = '\(.*\)'.*/\1/p")
  echo "deleting $path_to_delete..."

  # Get the id of the record to delete from ValidPaths
  path_id=$(sqlite3 "$db_file" "SELECT id FROM ValidPaths WHERE path = '$path_to_delete';")

  # Delete dependent records in the related table(s)
  sqlite3 "$db_file" "DELETE FROM Refs WHERE reference = $path_id;"

  # Delete the record from the ValidPaths table
  sqlite3 "$db_file" "DELETE FROM ValidPaths WHERE id = $path_id;"
done

echo "All errors resolved"

