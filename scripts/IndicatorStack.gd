extends Node2D

onready var love := $"LoveIndicator"
onready var fear := $"FearIndicator"
onready var hunt := $"HuntIndicator"
onready var farm := $"FarmIndicator"
onready var water := $"WaterIndicator"

func _resetAll():
  love.emitting = false
  fear.emitting = false
  hunt.emitting = false
  farm.emitting = false
  water.emitting = false

func indicateNothing():
  _resetAll()

func indicateForBehaviour(name):
  _resetAll()
  match name:
    "ProcreateOrDie":
      love.emitting = true
    "Fear":
      fear.emitting = true
    "Hunt":
      hunt.emitting = true
    "Farming":
      farm.emitting = true
    "WaterProducer":
      water.emitting = true
    _:
      # arnt we all afraid a little bit sometimes
      if rand_range(0.0, 1.0) > 0.999:
        fear.emitting = true