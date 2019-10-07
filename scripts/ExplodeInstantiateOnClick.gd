extends Node

export var instantiated_actors : Array = [
  {
    "actor_path": "actors/Slime.tscn",
    "number": 10,
    "spread": 100
  }
]

onready var root := get_tree().get_root()
onready var actor = $"../"
onready var level_base := root.find_node("LevelBase", true, false)
onready var level_rect : Rect2 = level_base.get_rect()

func execute_explode(viewport, event, shape_idx):
  if event is InputEventMouseButton:
    for actor_config in instantiated_actors:
      var actor_packed_scene = load("res://" + actor_config["actor_path"])

      var actor_clamped_pos = Vector2(
        clamp(actor.position.x, level_rect.position.x + actor_config["spread"], level_rect.end.x - actor_config["spread"]),
        clamp(actor.position.y, level_rect.position.y + actor_config["spread"], level_rect.end.y - actor_config["spread"])
      )

      for i in actor_config["number"]:
        var new_actor = actor_packed_scene.instance()

        new_actor.position = actor_clamped_pos
        new_actor.translate(Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * (actor_config["spread"] * randf()))

        root.add_child(new_actor)

    actor.emit_signal("dies")