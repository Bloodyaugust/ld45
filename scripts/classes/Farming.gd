extends Node
class_name Farming

export var planting_desire_per_second : float
export var planting_distance : float
export var planting_randomize_distance : float
export var time_to_plant : float

onready var actor : Actor = $"../"
onready var tree := get_tree()
onready var root := tree.get_root()
onready var tree_actor := preload("res://actors/Tree.tscn")

var _planting_target
var _planting_time : float = 0
var _planting_desire : float = 0

func evaluate_priority():
  if tree.get_nodes_in_group("Slimes").size() > 0:
    return _planting_desire * 0.5
  else:
    return 0

func execute_behavior():
  if _planting_target == null:
    _planting_target = _identify_slime_target()

  actor.move_toward_target(_planting_target)

  if actor.position.distance_to(_planting_target) <= planting_distance:
    _planting_time += get_process_delta_time()

    if _planting_time >= time_to_plant:
      var new_plant := tree_actor.instance()
      new_plant.position = _planting_target
      root.add_child(new_plant)

      _planting_time = 0
      _planting_desire = 0
      _planting_target = null

func _ready():
  actor.register_behavior(self)

func _process(delta):
  _planting_desire += planting_desire_per_second * delta
  _planting_desire = clamp(_planting_desire, 0, 1)

func _identify_slime_target() -> Vector2:
  var slimes := tree.get_nodes_in_group("Slimes")

  var slime_target : Vector2 = slimes[randi() % slimes.size()].position
  return Vector2(slime_target.x + rand_range(-1, 1) * planting_randomize_distance, slime_target.y + rand_range(-1, 1) * planting_randomize_distance)