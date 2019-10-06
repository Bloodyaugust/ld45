extends Node
class_name Hunt

export var attack_damage : float
export var attack_distance : float
export var target_group : String

onready var actor : Actor = $"../"
onready var tree := get_tree()

func evaluate_priority():
  if tree.get_nodes_in_group(target_group).size() > 0:
    return 0.5
  else:
    return 0

func execute_behavior():
  var possible_targets := tree.get_nodes_in_group(target_group)
  
  possible_targets.sort_custom(self, "_sort_possible_targets")
  var current_target = possible_targets[0]

  actor.move_toward_target(current_target.position)

  if actor.position.distance_to(current_target.position) <= attack_distance:
    current_target.find_node("LiveAndDie").takeDamage(attack_damage)

func _ready():
  actor.register_behavior(self)

func _sort_possible_targets(a, b):
  return actor.position.distance_squared_to(a.position) > actor.position.distance_squared_to(b.position)