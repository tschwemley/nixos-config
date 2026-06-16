  # SQLite for MySQL Users Cheatsheet                            
                                                                   
  ## Base CLI Differences                                        
                                                                   
  • Enter CLI:  sqlite3 database_name.db                           
  • Exit CLI:  .exit  or  .quit                                    
  • Command Prefix: Administrative commands start with a dot ( . ). SQL
  statements end with  ; .                                         
                                                                   
  ## Equivalent Commands                                         
                                                                   
   MySQL              │ SQLite            │ Description            
  ────────────────────┼───────────────────┼─────────────────────────────────
    SHOW TABLES;      │  .tables          │ List all tables.       
    DESCRIBE table;   │  .schema table    │ Show  CREATE  statement
                      │                   │ (detailed schema).     
    DESCRIBE table;   │  PRAGMA table_inf │ Tabular column metadata.
                      │ o(table);         │                        
                      │                   │                        
    SHOW DATABASES;   │  .databases       │ List attached database files.
    SOURCE file.sql;  │  .read file.sql   │ Execute SQL script from file.
    \G  (Vertical)    │  .mode box  or    │ Sets output to         
                      │  .mode line       │ vertical/expanded view.
    EXIT;             │  .exit            │ Close the session.     
                                                                   
  ## Output Formatting (Emulating MySQL)                         
                                                                   
  SQLite defaults to plain text with pipe delimiters. Use these to make it
  look like MySQL:                                                 
                                                                   
    .mode column   -- Align columns                                
    .headers on    -- Show column names                            
    .nullvalue NULL -- Display NULL explicitly                     
                                                                   
  Note: To make these permanent, add them to a  ~/.sqliterc  file. 
                                                                   
  ## Data Type & Syntax Gotchas                                  
                                                                   
  • AUTO_INCREMENT: Use  INTEGER PRIMARY KEY AUTOINCREMENT . (Note:  INTEGER
  must be used, not  INT ).                                        
  • Engine: No  ENGINE=InnoDB ; SQLite is a single-file serverless engine.
  • Users/Permissions: None. Access is controlled via OS file permissions on
  the  .db  file.                                                  
  • Date/Time: No specific  DATETIME  type; use  TEXT  (ISO8601),  REAL
  (Julian), or  INTEGER  (Unix Epoch). Use  strftime()  for manipulation.
  • Rename Column:  ALTER TABLE table RENAME COLUMN old TO new;  (Supported in
  SQLite 3.25.0+).                                                 
                                                                   
  ## Quick Metadata Queries                                      
                                                                   
  • List Indexes:  .indices table_name                             
  • Table Sanity Check:  PRAGMA integrity_check;                   
  • Export to CSV:                                                 
    .headers on                                                    
    .mode csv                                                      
    .output data.csv                                               
    SELECT * FROM table;                                           
    .output stdout    
