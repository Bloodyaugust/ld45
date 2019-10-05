extends Node
class_name IdleBehavior

onready var actor : Actor = $"../"

func evaluate_priority():
  return 0.1

func execute_behavior():
#  print("executing idle behavior")
  actor.move_toward_target(Vector2(500, 500))

func _ready():
  actor.register_behavior(self)
