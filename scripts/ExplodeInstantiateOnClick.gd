extends Node

export var instantiated_actors : Array = [
  {
    "actor_path": "actors/Slime.tscn",
    "number": 10,
    "spread": 100
  }
]

onready var root = get_tree().get_root()
onready var actor = $"../"

func execute_explode(viewport, event, shape_idx):
  if event is InputEventMouseButton:
    for actor_config in instantiated_actors:
      var actor_packed_scene = load("res://" + actor_config["actor_path"])

      for i in actor_config["number"]:
        var new_actor = actor_packed_scene.instance()

        new_actor.position = actor.position
        new_actor.translate(Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * (actor_config["spread"] * randf()))

        root.add_child(new_actor)

    actor.emit_signal("dies")