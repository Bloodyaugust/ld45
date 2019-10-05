extends Node2D

export var deliveryRate:float

func _ready():
	pass

func _process(delta):
	var amount = deliveryRate * delta 
	
	var consumers = []
	
	# # for debug:
	# consumers.push_back(get_node("../WaterConsumer"))
	
	for node in consumers:
		node.deliverWater(amount)
