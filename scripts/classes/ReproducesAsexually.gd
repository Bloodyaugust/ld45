extends Node2D

class_name ReproducesAsexually

export var avgSecondsPer = 12
export var spawnDist = 150
export var groupName:String = ""
export var spawnWater := 0.60

onready var node : Node = $"../"
onready var level_base := get_tree().get_root().find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

onready var actorWaterConsumer : Actor = $"../WaterConsumer"

func _ready():
  pass

func _process(delta):
  pass

func _roll_for_spawn():
  var delta = get_process_delta_time()
  var roll = (randf() / 10)
  var chance = delta * (1.0 / avgSecondsPer)
  if roll < chance:
    try_spawn()

func spawn_pos_component():
  return rand_range(-spawnDist, spawnDist)

func try_spawn():
  var offset = Vector2(spawn_pos_component(), spawn_pos_component())
  var pos = node.position + offset
  if is_valid_spawn(pos):
    do_spawn(pos)

func do_spawn(pos):
  var new_node = node.duplicate()
  new_node.position = pos
  node.get_parent().add_child(new_node)

func is_valid_spawn(pos):
  if not level_rect.has_point(pos):
    return false
  for node in get_tree().get_nodes_in_group(groupName):
    if node.position.distance_to(pos) < spawnDist:
      return false
  return true

func has_enough_water():
  return actorWaterConsumer.water > spawnWater

func _on_WaterConsumer_watered():
  _roll_for_spawn()
