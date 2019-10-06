extends Node2D

var dragAttach = null

onready var actor : Actor  = $"../"

func _on_ClickableArea_input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.is_pressed():
            dragAttach = actor.get_local_mouse_position()
        elif not event.is_pressed():
            dragAttach = null

func _process(delta):
    if dragAttach != null:
        actor.position = actor.get_global_mouse_position() - dragAttach
