extends Node2D

export var dessicateRate:float
export var huskPath:String = "res://actors/SlimeHusk.tscn"

signal watered

onready var huskScene = load(huskPath)
onready var actor = $"../"

var water = 1

func _ready():
	pass

func _process(delta):
	dessicate(delta * dessicateRate)

	if isDessicated():
		huskify()

func huskify():
	var husk = huskScene.instance()
	$"../../".add_child(husk)
	husk.position = actor.position # must be after add_child?
	actor.queue_free()

func dessicate(amount):
	water = setWaterClamped(water - amount)

func deliverWater(amount):
	water = setWaterClamped(water + amount)
	emit_signal("watered")

func isDessicated():
	return water <= 0.0

func setWaterClamped(water):
	return clamp(water, 0, 1)