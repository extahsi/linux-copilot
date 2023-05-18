#!/usr/bin/env bash

function print_executable() {
  read -p $'Press enter to run or \'q\' to exit: \n\e[1;35m>'"$1 "$'\e[0m ' input
  if [[ "$input" == "q" ]]; then
    echo $'\e[1;35mExiting...\e[0m'
    exit 0
  fi

  if [[ -z "$input" ]]; then
    $1
  else
  echo $'\e[1;35mInvalid input. Exiting...\e[0m'
fi
}


function dummy_chat() {
  x=$(curl -s -X POST -H "Content-Type: application/json" -d '{"data":"'"$1"'"}' http://localhost:8000/)
  result=$(echo "$x" | jq -r '.result')
  if [[ -n "$result" ]]; then
    print_executable "$result"
  else
    echo '\e[1;35mSorry, I dont know how to respond your question\e[0m'
  fi
}


function eval_loop() {
  echo "Hey, what can I help you with today?"
  while true; do
    read -r -p $'Write your question or press \'q\' to exit\n\e[1;35m>\e[0m ' -e input
    echo Your input is: $input
    if [[ $input == "q" ]]; then
      echo $'\e[1;35mExiting...\e[0m'
      break
    fi
    dummy_chat "$input"
  done
}

eval_loop

