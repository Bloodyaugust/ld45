extends Node
class_name SquishyAnimate

export var animate_speed_scalar : float

onready var sprite := $"../"

func _process(delta):
  var x : float = float(OS.get_ticks_msec()) / 1000
  sprite.scale = Vector2(1, 1) + (Vector2(1, 1) * ((sin(x * animate_speed_scalar) + 1) / 2)) * 0.2