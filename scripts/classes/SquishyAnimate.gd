extends Node
class_name SquishyAnimate

export var animate_speed_scalar : float

onready var sprite := $"../"
onready var sprite_scale : Vector2 = sprite.scale

func _process(delta):
  var x : float = float(OS.get_ticks_msec()) / 1000
  sprite.scale = sprite_scale + (Vector2(1, 1) * ((sin(x * animate_speed_scalar) + 1) / 2)) * 0.2