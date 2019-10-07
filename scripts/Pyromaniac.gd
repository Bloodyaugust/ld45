extends Node

class_name Pyromaniac

export var attack_damage_per_second : float
export var attack_distance : float
export var hunt_desire_per_second : float = 0.2
export var target_group : String = "Burnables"

onready var actor : Actor = $"../"
onready var tree := get_tree()

var hunt_desire : float = 0

func _get_possible_targets():
  var targets = []
  for node in tree.get_nodes_in_group(target_group):
    if not node.aflame:
      var actor = node.get_node("..")
      targets.push_back(actor)
  return targets

func evaluate_priority():
  if _get_possible_targets().size() > 0:
    return hunt_desire
  else:
    return 0

func execute_behavior():
  var possible_targets = _get_possible_targets()

  possible_targets.sort_custom(self, "_sort_possible_targets")
  var current_target = possible_targets[0]

  actor.move_toward_target(current_target.position)

func _ready():
  actor.register_behavior(self)

func _process(delta):
  hunt_desire += hunt_desire_per_second * delta
  hunt_desire = clamp(hunt_desire, 0, 1)

func _sort_possible_targets(a, b):
  return actor.position.distance_squared_to(a.position) < actor.position.distance_squared_to(b.position)