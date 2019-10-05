extends Node2D

export var deliveryRate:float

var waterees = []

onready var actor = $".."

func _ready():
	# actor.register_behavior(self)
	pass

func _process(delta):
	var amount = deliveryRate * delta
	
	var consumers = get_waterees()
	for consumer in consumers:
		consumer.deliverWater(amount)

func get_waterees():
	var in_range = $WateringArea.get_overlapping_areas()
	var waterees = []
	for bodies in in_range:
		var parent = bodies.get_node("..")
		if parent.is_in_group("WaterConsumers"):
			waterees.push_back(parent)
	return waterees

func execute_behavior():
	var consumers = get_tree().get_nodes_in_group("WaterConsumers")
	
	actor.move_toward_target()

# TODO: make dynamic based on distance to dry plants?
func evaluate_priority():
	return 0.3
