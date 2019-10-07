extends Node2D
class_name Actor

export var move_speed : float

onready var actor_poof := preload("res://doodads/ActorPoof.tscn")
onready var indicatorStack := $"IndicatorStack"
onready var tree := get_tree()
onready var root := tree.get_root()
onready var level_base := root.find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

onready var level_min_x = level_rect.position.x
onready var level_max_x = level_min_x + level_rect.size.x
onready var level_min_y = level_rect.position.y
onready var level_max_y = level_min_y + level_rect.size.y - 300

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
  var new_actor_poof := actor_poof.instance()
  new_actor_poof.position = position
  root.add_child(new_actor_poof)

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

  position = Vector2(clamp(position.x, level_min_x, level_max_x), clamp(position.y, level_min_y, level_max_y))  

func _sort_behavior_priorities(a, b):
  return a["priority"] > b["priority"]
