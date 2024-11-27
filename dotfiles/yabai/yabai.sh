#!/bin/sh

function setup_space {
  local idx="$1"
  local name="$2"
  local space=
  # echo "setup space $idx : $name"

  space=$(yabai -m query --spaces --space "$idx")
  if [ -z "$space" ]; then
    yabai -m space --create
    yabai -m config --space "$idx" layout bsp
  fi

  yabai -m space "$idx" --label "$name"
}


setup_space 1 code
setup_space 2 browser
setup_space 3 messaging
setup_space 4 media

sketchybar --trigger space_change --trigger windows_on_spaces
