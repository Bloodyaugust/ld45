extends Node2D

export var deliveryRate:float

# what priority to return
export var water_priority:float

func _ready():
	pass

func _process(delta):
	var amount = deliveryRate * delta 
	
	var consumers = get_tree().get_nodes_in_group("WaterConsumers")
	for consumer in []:
		#var dist = consumer.get_global_pos().distance_to(self.get_global_pos())
		#if dist < 10:
		#	node.deliverWater(amount)
		pass

# TODO: make dynamic based on distance to dry plants
func evaluate_priority():
	return water_priority