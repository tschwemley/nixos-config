### Basic Selectors

1. **Basic Key Access**
   - Retrieve value of a key:
     ```
     jq '.key'
     ```
   - Example: 
     ```json
     {
       "name": "John",
       "age": 30,
       "city": "New York"
     }
     ```
     To get the name:
     ```sh
     jq '.name' input.json
     ```

2. **Array Indexing**
   - Access an element in an array by 
index:
     ```
     jq '.array[index]'
     ```
   - Example: 
     ```json
     {
       "fruits": ["apple", "banana", 
"cherry"]
     }
     ```
     To get the first fruit:
     ```sh
     jq '.fruits[0]' input.json
     ```

### Array Operations

1. **Array Length**
   - Get the length of an array:
     ```
     jq '.array | length'
     ```
   - Example: 
     ```json
     {
       "numbers": [1, 2, 3, 4, 5]
     }
     ```
     To get the length of numbers:
     ```sh
     jq '.numbers | length' input.json
     ```

2. **Filtering and Mapping**
   - Filter elements in an array:
     ```
     jq '.array[] | select(condition)'
     ```
   - Example: 
     ```json
     {
       "numbers": [1, 2, 3, 4, 5]
     }
     ```
     To filter out even numbers:
     ```sh
     jq '.numbers[] | select(. % 2 == 0)' 
input.json
     ```

   - Map over elements in an array:
     ```
     jq '.array[] | expression'
     ```
   - Example: 
     ```json
     {
       "names": ["John", "Jane", "Doe"]
     }
     ```
     To convert all names to uppercase:
     ```sh
     jq '.names[] | ascii_uppercase' 
input.json
     ```

### Object Operations

1. **Keys and Values**
   - Get the keys of an object:
     ```
     jq 'keys'
     ```
   - Get the values of an object:
     ```
     jq '.values()'
     ```
   - Example: 
     ```json
     {
       "name": "John",
       "age": 30,
       "city": "New York"
     }
     ```
     To get all keys:
     ```sh
     jq 'keys' input.json
     ```

2. **Adding/Removing Keys**
   - Add a new key-value pair to an 
object:
     ```
     jq '.key = value'
     ```
   - Example: 
     ```json
     {
       "name": "John",
       "age": 30,
       "city": "New York"
     }
     ```
     To add an email field:
     ```sh
     jq '.email = "john@example.com"' 
input.json
     ```

   - Remove a key from an object:
     ```
     jq 'del(.key)'
     ```
   - Example: 
     ```json
     {
       "name": "John",
       "age": 30,
       "city": "New York"
     }
     ```
     To remove the age field:
     ```sh
     jq 'del(.age)' input.json
     ```

### Advanced Selectors

1. **Nested Key Access**
   - Access nested keys:
     ```
     jq '.key1.key2'
     ```
   - Example: 
     ```json
     {
       "user": {
         "name": "John",
         "details": {
           "age": 30,
           "city": "New York"
         }
       }
     }
     ```
     To get the age:
     ```sh
     jq '.user.details.age' input.json
     ```

2. **Conditional Statements**
   - Use `select` to filter based on 
conditions:
     ```
     jq 'map(select(condition))'
     ```
   - Example: 
     ```json
     [
       {"name": "John", "age": 30},
       {"name": "Jane", "age": 25}
     ]
     ```
     To get users older than 28:
     ```sh
     jq 'map(select(.age > 28))' 
input.json
     ```

3. **Sorting**
   - Sort an array by a key:
     ```
     jq '.array | sort_by(key)'
     ```
   - Example: 
     ```json
     [
       {"name": "John", "age": 30},
       {"name": "Jane", "age": 25}
     ]
     ```
     To sort users by age:
     ```sh
     jq '. | sort_by(.age)' input.json
     ```

### Miscellaneous

1. **Pretty Print**
   - Pretty print JSON:
     ```
     jq .
     ```
   - Example: 
     ```json
     {
       "name": "John",
       "age": 30,
       "city": "New York"
     }
     ```
     To pretty print:
     ```sh
     jq . input.json
     ```

2. **Stream Processing**
   - Process each element in a stream:
     ```
     jq '.[] | expression'
     ```
   - Example: 
     ```json
     [
       {"name": "John", "age": 30},
       {"name": "Jane", "age": 25}
     ]
     ```
     To print the names:
     ```sh
     jq '.[].name' input.json
     ```
