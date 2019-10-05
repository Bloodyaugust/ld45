extends Node

onready var types = get_node('/root/action_types')

signal game_started
signal player_tile_changed

func game_set_start_time(time):
  emit_signal("game_started")
  return {
    'type': types.GAME_SET_START_TIME,
    'time': time
  }

