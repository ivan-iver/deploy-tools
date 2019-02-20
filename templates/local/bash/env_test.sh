#!/usr/bin/env bash

load env.sh

@test "Check INFO log" {
  pcolor "INFO" "show text as info log"
  [ "$status" -eq 0 ] 
  [[ "$output" == *"\033[0;32m[INFO]  \033[0m show text as info log"* ]]
}
@test "Check WARNING log" {
  pcolor "WARNING" "show text as warning log"
  [ "$status" -eq 0 ] 
  [[ "$output" == *"\033[0;32m[WARNING]  \033[0m show text as warning log"* ]]
}
@test "Check ERROR log" {
  pcolor "ERROR" "show text as error log"
  [ "$status" -eq 0 ] 
  [[ "$output" == *"\033[0;32m[ERROR]  \033[0m show text as error log"* ]]
}
@test "Check DEBUG log" {
  pcolor "DEBUG" "show text as debug log"
  [ "$status" -eq 0 ] 
  [[ "${ISDEBUG}" == "true" ]]
  [[ "$output" == *"\033[0;32m[DEBUG]  \033[0m show text as debug log"* ]]
}
