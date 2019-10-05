extends Node2D

export var dessicateRate:float

var water = 1

func _ready():
	pass

func _process(delta):
	dessicate(delta * dessicateRate)
	
func dessicate(amount):
	water -= amount
	if water < 0:
		water = 0

func deliverWater(amount):
	water += amount
	if water > 1:
		water = 1

func isDessicated():
	return water <= 0.0