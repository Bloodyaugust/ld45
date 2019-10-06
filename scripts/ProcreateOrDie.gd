extends Node
class_name ProcreateOrDie

export var sexinessRate : float = 0.025
export var fuck_threshold : float

onready var actor : Actor = $"../"
onready var tree := get_tree()
onready var root := tree.get_root()
onready var _klassAlienWaterer : PackedScene = load("res://actors/AlienWaterer.tscn")
onready var _klassAlienFighter : PackedScene = load("res://actors/AlienFighter.tscn")

var desireToProcreate = 0.0
var humpDistance = 150.0
var chaseSpeed = 300.0

func _process(delta):
  _increaseSexDrive(delta * sexinessRate)

func _increaseSexDrive(amount):
  desireToProcreate += amount
  
func evaluate_priority():
  #print("should_fuck?", desireToProcreate)
  if desireToProcreate >= fuck_threshold:
    return desireToProcreate
  else:
    return 0

func execute_behavior():
  for actorToHump in tree.get_nodes_in_group("Aliens"):
    if actor != actorToHump:
      actor.move_speed = chaseSpeed
      actor.move_toward_target(actorToHump.position)
      if actor.position.distance_to(actorToHump.position) < humpDistance:
          desireToProcreate = 0.0
          actorToHump.find_node("ProcreateOrDie").desireToProcreate = 0.0
          if randf() > 0.8 && tree.get_nodes_in_group("Defenders").size() >= 1:
            var newAlienFighter := _klassAlienFighter.instance()
            newAlienFighter.position = actor.position + Vector2(0.0, 250.0)
            root.add_child(newAlienFighter)
          else:
            var newAlienWaterer := _klassAlienWaterer.instance()
            newAlienWaterer.position = actor.position + Vector2(0.0, 250.0)
            root.add_child(newAlienWaterer)               

          break
          
      break
    
func _ready():
  actor.register_behavior(self)
