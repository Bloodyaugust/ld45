extends Node

onready var start_time : float = OS.get_ticks_msec()
onready var tree := get_tree()
onready var root := tree.get_root()
onready var level_base := root.find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

onready var _enemy_meteor : PackedScene = preload("res://actors/EnemyMeteor.tscn")
onready var _enemy_pyro_meteor : PackedScene = preload("res://actors/EnemyPyroMeteor.tscn")
onready var _defender_meteor : PackedScene = preload("res://actors/DefenderMeteor.tscn")
onready var _startup_meteor : PackedScene = preload("res://actors/StartupMeteor.tscn")

var _events : Array = [
  {
    "type": "condition",
    "function": "_do_startup_meteor"
  },
  {
    "type": "condition",
    "function": "_do_enemy_meteor"
  },
  {
    "type": "condition",
    "function": "_do_alien_defender_meteor"
  },
  {
    "type": "condition",
    "function": "_do_enemy_pyro_meteor"
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
  if tree.get_nodes_in_group("Aliens").size() == 0:
    _time_to_startup_meteor -= get_process_delta_time()
    if _time_to_startup_meteor <= 0:
      _time_to_startup_meteor = _startup_meteor_interval
      
      var new_startup_meteor := _startup_meteor.instance()
      new_startup_meteor.position = Vector2(level_rect.position.x + (level_rect.size.x * _rng.randf()), level_rect.position.y + (level_rect.size.y * _rng.randf()))
      root.add_child(new_startup_meteor)

var _enemy_meteor_interval : float = 20
var _time_to_enemy_meteor : float = 20
func _do_enemy_meteor():
  if tree.get_nodes_in_group("Aliens").size() > 0:
    _time_to_enemy_meteor -= get_process_delta_time()
    if _time_to_enemy_meteor <= 0:
      _time_to_enemy_meteor = _enemy_meteor_interval

      var new_enemy_meteor := _enemy_meteor.instance()
      new_enemy_meteor.position = Vector2(level_rect.position.x + (level_rect.size.x * _rng.randf()), level_rect.position.y + (level_rect.size.y * _rng.randf()))
      root.add_child(new_enemy_meteor)

var _alien_defender_interval : float = 5
var _time_to_alien_defender : float = 5
func _do_alien_defender_meteor():
  if tree.get_nodes_in_group("Enemies").size() > 0 && tree.get_nodes_in_group("Defenders").size() <= 1:
    _time_to_alien_defender -= get_process_delta_time()
    if _time_to_alien_defender <= 0:
      _time_to_alien_defender = _alien_defender_interval

      var new_defender_meteor := _defender_meteor.instance()
      new_defender_meteor.position = Vector2(level_rect.position.x + (level_rect.size.x * _rng.randf()), level_rect.position.y + (level_rect.size.y * _rng.randf()))
      root.add_child(new_defender_meteor)

var _enemy_pyro_meteor_interval : float = 20
var _time_to_enemy_pyro_meteor : float = 20
func _do_enemy_pyro_meteor():
  if tree.get_nodes_in_group("Enemies").size() > 0:
    _time_to_enemy_pyro_meteor -= get_process_delta_time()
    if _time_to_enemy_pyro_meteor <= 0:
      _time_to_enemy_pyro_meteor = _enemy_pyro_meteor_interval

      var new_enemy_pyro_meteor := _enemy_pyro_meteor.instance()
      new_enemy_pyro_meteor.position = Vector2(level_rect.position.x + (level_rect.size.x * _rng.randf()), level_rect.position.y + (level_rect.size.y * _rng.randf()))
      root.add_child(new_enemy_pyro_meteor)