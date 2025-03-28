#! /bin/bash


PSQL="psql --username=freecodecamp --dbname=periodic_table -t  -c"
PSQL2="psql --username=freecodecamp --dbname=periodic_table -t --no-align  -c"

ARGUMENT=$1

RESPONSE() {

#Here the function will determine what the user input was, and then give a response. If what the user gave is not present, it will call on another function
if [[ -n $ATOMIC_NUMBER_RESULT  ]]
then
    read ATOMIC_NUMBER_DATABASE BAR SYMBOL_DATABASE BAR NAME_DATABASE < <(echo $ATOMIC_NUMBER_RESULT)
    
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    
    MASS=$($PSQL2 "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
   
    MELT_POINT=$($PSQL2 "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    BOIL_POINT=$($PSQL2 "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")

    echo -e "The element with atomic number $ATOMIC_NUMBER_DATABASE is $NAME_DATABASE ($SYMBOL_DATABASE). It's a$TYPE, with a mass of $MASS amu. $NAME_DATABASE has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."


elif [[ -n $SYMBOL_RESULT ]]
then
    read ATOMIC_NUMBER_DATABASE BAR SYMBOL_DATABASE BAR NAME_DATABASE < <(echo $SYMBOL_RESULT)
    
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    
    MASS=$($PSQL2 "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
   
    MELT_POINT=$($PSQL2 "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    BOIL_POINT=$($PSQL2 "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")

    echo -e "The element with atomic number $ATOMIC_NUMBER_DATABASE is $NAME_DATABASE ($SYMBOL_DATABASE). It's a$TYPE, with a mass of $MASS amu. $NAME_DATABASE has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."

elif [[ -n $NAME_RESULT ]]
then
    read ATOMIC_NUMBER_DATABASE BAR SYMBOL_DATABASE BAR NAME_DATABASE < <(echo $NAME_RESULT)
    
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    
    MASS=$($PSQL2 "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
   
    MELT_POINT=$($PSQL2 "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")
    BOIL_POINT=$($PSQL2 "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER_DATABASE")

    echo -e "The element with atomic number $ATOMIC_NUMBER_DATABASE is $NAME_DATABASE ($SYMBOL_DATABASE). It's a$TYPE, with a mass of $MASS amu. $NAME_DATABASE has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."

else
    echo -e "I could not find that element in the database."
fi

}

ELEMENT_SEARCH() {

#Search the elements table to see if the input to the script matches any of the values

#First test if the user argument is a number, as this will affect the psql search
if [[ $ARGUMENT =~ ^[0-9]+$ ]]
then
    ATOMIC_NUMBER_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $ARGUMENT")
else
    SYMBOL_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol = '$ARGUMENT'")
    NAME_RESULT=$($PSQL "SELECT * FROM elements WHERE name = '$ARGUMENT'")
fi


RESPONSE

}


INITIAL_RESPONSE() {
if [[ -z "$ARGUMENT" ]]

then
    echo Please provide an element as an argument.
else
    ELEMENT_SEARCH
fi
}



INITIAL_RESPONSE


