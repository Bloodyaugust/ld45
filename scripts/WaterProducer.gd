extends Node2D

export var deliveryRate:float

# what priority to return
export var water_priority:float

var waterees = []

func _ready():
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

# TODO: make dynamic based on distance to dry plants
func evaluate_priority():
	return water_priority
