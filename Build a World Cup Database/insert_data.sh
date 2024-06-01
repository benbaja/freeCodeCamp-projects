#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams RESTART IDENTITY CASCADE")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
      if [[ $INSERT_WINNER = 'INSERT 0 1' ]]
      then
        echo "Inserted team $WINNER (winner)"
      else
        echo "ERROR when inserting $WINNER (winner)"
      fi
      WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    fi

    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
      if [[ $INSERT_OPPONENT = 'INSERT 0 1' ]]
      then
        echo "Inserted team $OPPONENT (winner)"
      else
        echo "ERROR when inserting $OPPONENT (winner)"
      fi
      OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
    fi

    INSERT_GAME="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
    if [[ $INSERT_GAME = 'INSERT 0 1' ]]
    then
      echo "Inserted game $ROUND of $YEAR"
    else
      echo "ERROR when inserting game $ROUND of $YEAR"
    fi
  fi
done