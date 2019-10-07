extends Node
class_name IdleBehavior

onready var actor : Actor = $"../"

var idleSpeed = 100.0
var randomTarget = Vector2(0, 0)

func evaluate_priority():
  return 0.1

func execute_behavior():
  actor.move_speed = idleSpeed

  if rand_range(0.0, 1.0) > 0.99:
    _pickRandomTarget()
      
  actor.move_toward_target(randomTarget)

func _pickRandomTarget():
  var min_x = -1200
  var max_x = 1200
  var min_y = -1200
  var max_y = 1200
  randomTarget = Vector2(rand_range(min_x, max_x), rand_range(min_y, max_y))

func _ready():
  _pickRandomTarget()
  actor.register_behavior(self)
