#!/usr/bin/env bash

teardown(){
  echo "Salida: "
  echo "${lines[0]}"
  echo "${lines[1]}"
  echo "${lines[2]}"
}

@test "show help" {
  #skip
  run bash branch_detect.sh -h;
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"Usage: branch_detect.sh -d <default_branch>"* ]]
  [[ "$output" == *"-d  Default branch when is [empty] is set to develop"* ]]
}

@test "set develop branch as default" {
  run bash branch_detect.sh -d develop
  [ "$status" -eq 0 ]
  [[ "$output" == *"dev"* ]]
}

@test "set master branch as default" {
  run bash branch_detect.sh -d master
  [ "$status" -eq 0 ]
  [[ "$output" == *"dev"* ]]
}

@test "set wrong branch as default" {
  run bash branch_detect.sh -d another
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"Usage: branch_detect.sh -d <default_branch>"* ]]
  [[ "$output" == *"-d  Default branch when is [empty] is set to develop"* ]]
}
