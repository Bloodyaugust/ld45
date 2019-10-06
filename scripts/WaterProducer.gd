extends Node2D

export var deliveryRate:float = 0.1

var waterees = []

onready var actor : Actor = $".."

func _ready():
	actor.register_behavior(self)

func _process(delta):
	var amount = deliveryRate * delta
	
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

func execute_behavior():
	var consumers = get_waterees($DetectionArea)
	
	var target = null
	for consumer in consumers:
		if consumer.water > 0.5:
			continue
		if target == null or consumer.water < target.water:
			target = consumer
	if target != null:
		var node = target.get_node("..")
		actor.move_toward_target(node.position)

# TODO: make dynamic based on distance to dry plants?
func evaluate_priority():
	return 0.3
