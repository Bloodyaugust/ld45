extends Node2D

var dragAttach = null

onready var actor : Actor  = $"../"

func _ready():
  actor.register_behavior(self)

func _process(delta):
  if dragAttach != null:
    actor.position = actor.get_global_mouse_position() - dragAttach

func _on_ClickableArea_input_event(viewport, event, shape_idx):
  print("on click")
  if event is InputEventMouseButton:
    if event.is_pressed():
      dragAttach = actor.get_local_mouse_position()
    elif not event.is_pressed():
      dragAttach = null

func execute_behavior():
  pass

func evaluate_priority():
  if dragAttach == null:
    return 0.0
  else:
    return 2.0