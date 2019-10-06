extends Node

onready var start_time : float = OS.get_ticks_msec()
onready var tree := get_tree()
onready var root := tree.get_root()
onready var level_base := root.find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

onready var _startup_meteor : PackedScene = preload("res://actors/StartupMeteor.tscn")

var _events : Array = [
  {
    "type": "condition",
    "function": "_do_startup_meteor"
  }
]
var _rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta):
  var current_time : float = OS.get_ticks_msec() - start_time

  for event in _events:
    match event["type"]:
      "condition":
        call(event["function"])
      "timer":
        if current_time > event["time"]:
          call(event["function"])
      _:
        print("invalid event type")

var _startup_meteor_interval : float = 5
var _time_to_startup_meteor : float = 5
func _do_startup_meteor():
  if tree.get_nodes_in_group("Actors").size() == 0:
    _time_to_startup_meteor -= get_process_delta_time()
    if _time_to_startup_meteor <= 0:
      _time_to_startup_meteor = _startup_meteor_interval
      
      var new_startup_meteor := _startup_meteor.instance()
      new_startup_meteor.position = Vector2(level_rect.position.x + (level_rect.size.x * _rng.randf()), level_rect.position.y + (level_rect.size.y * _rng.randf()))
      root.add_child(new_startup_meteor)