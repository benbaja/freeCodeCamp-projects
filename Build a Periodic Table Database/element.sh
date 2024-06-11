#/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then
  USER_INPUT=$1
  if [[ $USER_INPUT =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $USER_INPUT")
  elif [[ $1 =~ ^[a-zA-Z]+$ && ${#USER_INPUT} < 3 ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$USER_INPUT'")
  elif [[ $1 =~ ^[a-zA-Z]+$ && ${#USER_INPUT} > 2 ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$USER_INPUT'")
  fi
  
  if [[ ! -z $ATOMIC_NUMBER ]]
  then
    DATABASE_INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER ORDER BY atomic_number")
    SPLIT_DATABASE_INFO=( $(IFS="|" ; echo $DATABASE_INFO) )
    echo "The element with atomic number ${SPLIT_DATABASE_INFO[1]} is ${SPLIT_DATABASE_INFO[3]} (${SPLIT_DATABASE_INFO[2]}). It's a ${SPLIT_DATABASE_INFO[7]}, with a mass of ${SPLIT_DATABASE_INFO[4]} amu. ${SPLIT_DATABASE_INFO[3]} has a melting point of ${SPLIT_DATABASE_INFO[5]} celsius and a boiling point of ${SPLIT_DATABASE_INFO[6]} celsius."
  else
    echo "I could not find that element in the database."
  fi
else
  echo "Please provide an element as an argument."
fi