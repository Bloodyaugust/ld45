extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var love = get_tree().find_node("LoveIndicator")
var fear = get_tree().find_node("FearIndicator")

# Called when the node enters the scene tree for the first time.
func _ready():
  _resetAll()
  
  pass # Replace with function body.

func _resetAll():
  love.emitting = false
  fear.emitting = false
  
func indicateLove():
  _resetAll()
  love.emitting = true

func indicateFear():
  _resetAll()
  fear.emitting = true