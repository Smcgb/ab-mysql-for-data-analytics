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

# download csv from csv import lesson
filename2="product_suggestions.csv"
filepath2="$cwd/$filename2"

if [ ! -e "$filepath2" ]; then
    url="https://cdn-prd.analystbuilder.com/e42182fc-5a02-475b-8cc6-f78a4dd648d8/product_suggestions.csv"
    wget "$url" -P .
fi

# download World life expectancy csv
filename3="WorldLifeExpectancy.csv"
filepath3="$cwd/$filename3"

if [ ! -e "$filepath3" ]; then
    url="https://cdn-prd.analystbuilder.com/7de487e2-b237-4c27-80e3-501cc4cc167d/WorldLifeExpectancy.csv"
    wget "$url" -P .
fi

# download US HouseHold Income csv
filename4="USHouseholdIncome.csv"
filepath4="$cwd/$filename4"

if [ ! -e "$filepath4" ]; then
    url="https://cdn-prd.analystbuilder.com/584be4f6-8568-407e-a277-b573ce362a3f/USHouseholdIncome.csv"
    wget "$url" -P .
fi

# download statistics
filename5="USHouseholdIncome_Statistics.csv"
filepath5="$cwd/$filename5"

if [ ! -e "$filepath5" ]; then
    url="https://cdn-prd.analystbuilder.com/584be4f6-8568-407e-a277-b573ce362a3f/USHouseholdIncome_Statistics.csv"
    wget "$url" -P .
fi

chmod 644 *.csv

# Prompt for MySQL credentials
echo "Please enter your MySQL username:"
read mysql_user

echo "Please enter your MySQL password:"
read -s mysql_password # silent so password isn't visibile while typing

# Use a here document to log in to MySQL and run the initial SQL file

mysql -u "$mysql_user" -p"$mysql_password" --local-infile=1 <<EOF
SOURCE $filepath;

USE bakery;

\! echo "Showing Tables";
\! echo "----------------";
SHOW tables;
\! echo "----------------";
EOF

echo "SQL file executed successfully."

# Blank line to separate sections
echo ""

# Create an array of all .sql files in the current directory except the one we just downloaded

files=($(ls *.sql | grep -v create-bakery-db.sql))

# Blank line for clarity
echo ""

# Loop through the array and execute each file

for file in "${files[@]}"; do
    echo "Executing $file..."
    echo "----------------"

    # Run each SQL file with MySQL
    mysql -u "$mysql_user" -p"$mysql_password" --local-infile=1 <<EOF
source $file;
EOF

    echo "----------------"
    echo ""
done

# Final message to indicate completion of all files
echo "All SQL files executed successfully."