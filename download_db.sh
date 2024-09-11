#!/bin/bash

# Current Working Directory to ensure proper pathing for install
cwd=$(pwd)

# Extract the filename from the URL
filename="create-bakery-db.sql"

# Create path for file
filepath="$cwd/$filename"

if [ ! -e "$filepath" ]; then
    # URL of the file to be downloaded
    url="https://cdn-prd.analystbuilder.com/7ec64182-73a4-4e4a-865d-82cd2e14783b/create-bakery-db.sql"
    wget "$url" -P .
fi

# Prompt for MySQL credentials
echo "Please enter your MySQL username:"
read mysql_user

echo "Please enter your MySQL password:"
read -s mysql_password # silent so password isn't visibile while typing

# Use a here document to log in to MySQL and run the SQL file
mysql -u "$mysql_user" -p"$mysql_password" <<EOF
SOURCE $filepath;
USE bakery;
SELECT "Showing Tables";
SHOW tables;
EOF

echo "SQL file executed successfully."
