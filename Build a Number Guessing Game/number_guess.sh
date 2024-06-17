#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_INFO=$($PSQL "SELECT user_id, COUNT(game_id) AS games_played, MIN(number_of_guesses) AS best_game FROM users LEFT JOIN games USING(user_id) WHERE username = '$USERNAME' GROUP BY user_id")
if [[ -z $USER_INFO ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  ADD_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
else 
  SPLIT_USER_INFO=( $(IFS="|" ; echo $USER_INFO) )
  USER_ID=${SPLIT_USER_INFO[0]}

  if [[ ${SPLIT_USER_INFO[1]} == 0 ]]
  then
    # meaning 0 games played, show the splash for new users
    echo "Welcome, $USERNAME! It looks like this is your first time here."
  else
    echo "Welcome back, $USERNAME! You have played ${SPLIT_USER_INFO[1]} games, and your best game took ${SPLIT_USER_INFO[2]} guesses."
  fi
fi

NUMBER_TO_GUESS=$(( 1 + $RANDOM % 1000 ))
GUESSED_NUMBER=0
NUMBER_OF_GUESSES=0
echo -e "\nGuess the secret number between 1 and 1000:"

while (( NUMBER_TO_GUESS != GUESSED_NUMBER ))
do
  read GUESSED_NUMBER

  NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))
  if [[ $GUESSED_NUMBER =~ ^[0-9]+$ ]]
  then
  
    if (( NUMBER_TO_GUESS < GUESSED_NUMBER ))
    then
      echo "It's lower than that, guess again:"
    elif (( NUMBER_TO_GUESS > GUESSED_NUMBER ))
    then
      echo "It's higher than that, guess again:"
    fi

  else
    echo "That is not an integer, guess again:"
  fi

done

ADD_GAME=$($PSQL "INSERT INTO games(number_of_guesses, secret_number, user_id) VALUES($NUMBER_OF_GUESSES, $NUMBER_TO_GUESS, $USER_ID)")
echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $NUMBER_TO_GUESS. Nice job!"
