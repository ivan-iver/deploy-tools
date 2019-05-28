#!/usr/bin/env bash

teardown() {
  echo "Salida: ${output}"
}

@test "No log type was given" {
  #skip
  run bash log.sh -x "Nothing";
  [ "$status" -eq 1 ]
  # [ "$output" =~ "Usage: log.sh" ]
  [[ "${lines[0]}" == *"./log.sh: illegal option -- x"* ]]
  [[ "${lines[1]}" == *"Usage: log.sh [-i|-w|-e|-d] message"* ]]
}

@test "Check info log" {
  run bash log.sh -i "show text as info log" -t true
  [ "$status" -eq 0 ]
  [[ "$output" == *"\033[0;32m[INFO]  \033[0m show text as info log"* ]]
}
@test "Check warning log" {
  run bash log.sh -w "show text as warning log" -t true
  [ "$status" -eq 0 ]
  [[ "$output" == *"\033[0;33m[WARNING]  \033[0m show text as warning log"* ]]
}
@test "Check error log" {
  run bash log.sh -e "show text as error log" -t true
  [ "$status" -eq 0 ]
  [[ "$output" == *"\033[0;31m[ERROR]  \033[0m show text as error log"* ]]
}
@test "Check debug log" {
  run bash log.sh -d "show text as debug log" -t true
  [ "$status" -eq 0 ]
  [[ "$output" == *"\033[0;35m[DEBUG]  \033[0m show text as debug log"* ]]
}
@test "Check text log" {
  run bash log.sh -d "show text as debug log" -t true
  [ "$status" -eq 0 ]
  [[ "$output" == *"\033[0;35m[DEBUG]  \033[0m show text as debug log"* ]]
}
