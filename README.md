# MySQL for Data Analytics

[Analyst Builder MySQL Fot Data Analytics](https://www.analystbuilder.com/courses/mysql-for-data-analytics)

This repository contains my practice exercises and projects from the *MySQL for Data Analytics* course on Analyst Builder. Instead of running all commands in MySQL Workbench, I am utilizing BASH, MySQL Shell, and Bash scripting to execute all practices and projects.

Each exercise will be accompanied by a generated `.sql` script and corresponding Bash scripts to run the solution queries and project tasks.

## Table of Contents

- [Installation](#installation)
- [Exercises and Projects](#exercises-and-projects)

## Installation

To get started, ensure that MySQL is installed on your machine. You can download it from the [official MySQL website](https://dev.mysql.com/downloads/) or follow these steps for Ubuntu:

```bash
# Install MySQL Server
sudo apt install mysql-server

# Run the secure installation script to configure security settings
sudo mysql_secure_installation
```

After installing MySQL, make sure the `mysqlda.sh` script is executable:

```bash
# Make the script executable
chmod +x download_db.sh

# Run the script to set up the database
./download_db.sh
```

### Loading in CSV

In order to load in CSVs properly via the script, you will need to ensure local-infile is set to 1.

Add the following line under the [mysqld] section:
```ini
[mysqld]
local-infile=1


```
Restart MySQL Server:
```bash
sudo systemctl restart mysql
```
Or
```
net stop mysql
net start mysql
```

There is an included
```sql
SET GLOBAL local_infile=ON;
``` 
included in the script but this may not function properly.


## Exercises and Projects

All exercises and projects are organized in folders by chapter or topic. Each folder contains:

*   `.sql` scripts with the solution queries.
*   the `mysqlda.sh` file prints outputs of each question when the script runs. Each question is continuosly included as I update.
