#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c "
echo -e "Welcome to the Chupacabra Salon !\n"
echo -e "Please select a service\n"

MAIN_MENU() {
  if [[ $1 ]]
    then
      echo -e "\n$1\n"
  fi

  # display list of services = 1) cut
  LIST_OF_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$LIST_OF_SERVICES" | while read ID BAR SERVICE
  do
    echo "$ID) $SERVICE"
  done

  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
      MAIN_MENU "Please input a number"
    else
      # test selected ID
      TESTED_SERVICE_ID=$($PSQL "SELECT * FROM services WHERE service_id = $SERVICE_ID_SELECTED")
      if [[ -z $TESTED_SERVICE_ID ]]
        then
          MAIN_MENU "This service does not exist"
      fi

      SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

      echo -e "\nPlease type your phone number :"
      read CUSTOMER_PHONE
  
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      if [[ -z $CUSTOMER_ID ]]
        then
          echo -e "\nWe could not find you in the database, please input your name:"
          read CUSTOMER_NAME
          CUSTOMER_INSERT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        else
          CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
      fi
  
      echo -e "\nAt what time would you like your$SERVICE_NAME ?"
      read SERVICE_TIME
      APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  
      echo -e "\nI have put you down for a$SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
    
}

MAIN_MENU
