extends Node2D

export var deliveryRate:float = 0.1

onready var actor : Actor = $".."

var target = null

func _ready():
  actor.register_behavior(self)

# func _process(delta):
#   pass

func dispense_water():
  var amount = deliveryRate * get_process_delta_time()

  var consumers = get_waterees($WateringArea)
  for consumer in consumers:
    consumer.deliverWater(amount)

func get_waterees(area):
  var in_range = area.get_overlapping_areas()
  var waterees = []
  for bodies in in_range:
    var parent = bodies.get_node("..")
    if parent.is_in_group("WaterConsumers"):
      waterees.push_back(parent)
  return waterees

func pick_watering_target():
  var consumers = get_waterees($DetectionArea)

  var target = null
  for consumer in consumers:
    if consumer.water > 0.5:
      continue
    if target == null or consumer.water < target.water:
      target = consumer
  if target != null:
    var node = target.get_node("..")
    return node.position
  return null

func execute_behavior():
  dispense_water()
  actor.move_toward_target(target)

# TODO: make dynamic based on distance to dry plants?
func evaluate_priority():
  target = pick_watering_target()
  if target == null:
    return 0
  else:
    return 0.4
