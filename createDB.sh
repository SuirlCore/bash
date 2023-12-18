 #!/bin/bash

echo This BASH script helps to create SQL scripts that generate databases.

#ask what the database should be named
echo What is your database name?
read dbName

#generate the SQL text to create the database
dbLine = "DROP DATABASE "$dbName" IF EXISTS;"
dbFileName = "create"$dbName".sql"
echo $dbLine > $dbFileName
dbLine = "CREATE DATABASE "$dbName";"
echo $dbLine >> $dbFileName
dbLine = "USE "$dbName";"
echo $dbline >> $dbFileName

#start a loop to generate as many tables as requested
echo Lets create some tables now.
i = 0
while [i -le 1]
do
    echo What is the tables name?
    read tblName
    #generate code for creating table
    dbLine = "CREATE TABLE IF NOT EXISTS "$tblName" ("
    echo $dbLine >> $dbFileName

    #start loop to generate attributes
    j = 0
    while [j -le 1]
    do
        #gather information about an attribute
        echo What is an attribute to add to table $tblName ?
        read atName
        echo What is the datatype?
        read dataType
        echo can it be null? y/n
        read nullVal
        echo does it auto increment? y/n
        read autoVal

        #use gathed information to generate code to create attribute
        dbLine = $atName" "$dataType
        if [$nullVal = "y"]
        then
            dbLine = $dbline" NOT NULL"
        fi
        if [$autoVal = "y"]
        then
            dbLine = $dbLine" AUTO INCREMENT"
        fi
        dbLine = $dbLine","


        #find out if attributes are complete and quit the loop
        echo Are there any more attributes? y/n
        read lastAt
        if [$lastAt = "n"]
        then
            j = $j + 5
    done

    #ask which attribute is the primary key

    #find out if the table is complete and quit the loop
    dbLine = ");"
    echo $dbLine ?? $dbFileName
    i = $i + 5
done

#find out if there are any foreign keys that need added