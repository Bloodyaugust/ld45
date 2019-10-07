extends Node2D
class_name Actor

export var move_speed : float
onready var indicatorStack := $"IndicatorStack"

signal dies

var system_behaviors : Dictionary = {}

func move_toward_target(target):
#  print("moving toward: " + str(target) + " at speed " + str(move_speed))
  var direction_vector : Vector2 = target - position
  translate(direction_vector.normalized() * move_speed * get_process_delta_time())

func register_behavior(behavior):
  system_behaviors[behavior.name] = behavior

func _ready():
  connect("dies", self, "_on_dies")

func _on_dies():
  queue_free()

func _process(delta):
  var behavior_priorities : Array = []
  for behavior_name in system_behaviors:
    behavior_priorities.push_back({
      "name": behavior_name,
      "priority": system_behaviors[behavior_name].evaluate_priority()
    })
  behavior_priorities.sort_custom(self, "_sort_behavior_priorities")
  

  if behavior_priorities.size() > 0:
    if indicatorStack:
      indicatorStack.indicateForBehaviour(behavior_priorities[0]["name"])

    system_behaviors[behavior_priorities[0]["name"]].execute_behavior()

func _sort_behavior_priorities(a, b):
  return a["priority"] > b["priority"]
