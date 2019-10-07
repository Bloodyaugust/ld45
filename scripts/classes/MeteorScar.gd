extends Node
class_name MeteorScar

onready var root := get_tree().get_root()
onready var actor := $"../../"
onready var meteor_impact : PackedScene = preload("res://doodads/MeteorImpact.tscn")

func _ready():
  call_deferred("_place_meteor_impact")
  
func _place_meteor_impact():
  var new_meteor_impact := meteor_impact.instance()
  new_meteor_impact.position = actor.position
  root.add_child(new_meteor_impact)
