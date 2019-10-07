extends Node
class_name IdleBehavior

onready var actor : Actor = $"../"
onready var root := get_tree().get_root()
onready var level_base := root.find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

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
  var min_x = level_rect.position.x
  var max_x = min_x + level_rect.size.x
  var min_y = level_rect.position.x
  var max_y = min_y + level_rect.size.y
  randomTarget = Vector2(rand_range(min_x, max_x), rand_range(min_y, max_y))

func _ready():
  _pickRandomTarget()
  actor.register_behavior(self)
