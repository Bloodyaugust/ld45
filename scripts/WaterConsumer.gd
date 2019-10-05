extends Node2D

export var dessicateRate:float

signal driedOut

var water = 1

func _ready():
	pass

func _process(delta):
	dessicate(delta * dessicateRate)

	if isDessicated():
		emit_signal('driedOut')
	
func dessicate(amount):
	water = setWaterClamped(water - amount)

func deliverWater(amount):
	water = setWaterClamped(water + amount)

func isDessicated():
	return water <= 0.0

func setWaterClamped(water):
	return clamp(water, 0, 1)