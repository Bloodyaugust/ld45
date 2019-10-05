extends Node2D

func _ready():
	$WaterConsumer.connect("driedOut", self, "_on_driedOut")
	$Husk.visible = false
	$NotHusk.visible = true

func _process(delta):
	pass

func _on_driedOut():
	$Husk.visible = true
	$NotHusk.visible = false
