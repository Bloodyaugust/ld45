extends Node
class_name Hunt

export var attack_damage_per_second : float
export var attack_distance : float
export var hunt_desire_per_second : float
export var target_group : String

onready var actor : Actor = $"../"
onready var tree := get_tree()

var hunt_desire : float = 0

func evaluate_priority():
  if tree.get_nodes_in_group(target_group).size() > 0:
    return hunt_desire
  else:
    return 0

func execute_behavior():
  var possible_targets := tree.get_nodes_in_group(target_group)
  
  possible_targets.sort_custom(self, "_sort_possible_targets")
  var current_target = possible_targets[0]

  actor.move_toward_target(current_target.position)

  if actor.position.distance_to(current_target.position) <= attack_distance:
    var target_health_behavior = current_target.find_node("LiveAndDie")
    target_health_behavior.takeDamage(attack_damage_per_second * get_process_delta_time())
    
    if target_health_behavior.health <= 0:
      hunt_desire = 0

func _ready():
  actor.register_behavior(self)

func _process(delta):
  hunt_desire += hunt_desire_per_second * delta
  hunt_desire = clamp(hunt_desire, 0, 1)

func _sort_possible_targets(a, b):
  return actor.position.distance_squared_to(a.position) < actor.position.distance_squared_to(b.position)