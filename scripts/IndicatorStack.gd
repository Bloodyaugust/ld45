extends Node2D

onready var love := $"LoveIndicator"
onready var fear := $"FearIndicator"
  
func _resetAll():
  love.emitting = false
  fear.emitting = false

func indicateNothing():
  _resetAll()

func indicateForBehaviour(name):
  _resetAll()
  match name:
    "ProcreateOrDie":
      love.emitting = true
    _:
      # arnt we all afraid a little bit sometimes
      if rand_range(0.0, 1.0) > 0.9:
        fear.emitting = true