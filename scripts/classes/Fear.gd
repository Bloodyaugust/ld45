extends Node
class_name Fear

export var max_fear_distance : float

onready var actor : Actor = $"../"
onready var tree := get_tree()
onready var root := tree.get_root()

func evaluate_priority():
  var enemies := tree.get_nodes_in_group("Enemies")
  if enemies.size() > 0:
    enemies.sort_custom(self, "_sort_enemies_by_distance")
    var distance : float = actor.position.distance_to(enemies[0].position)

    if distance >= max_fear_distance * 3:
      return 0
    if distance < max_fear_distance * 3 && distance >= max_fear_distance * 2:
      return 0.5
    if distance < max_fear_distance * 2 && distance > max_fear_distance:
      return 0.75
    return 1
  else:
    return 0

func execute_behavior():
  var enemies := tree.get_nodes_in_group("Enemies")
  enemies.sort_custom(self, "_sort_enemies_by_distance")

  var run_from_enemy : Actor = enemies[0]
  var run_direction : Vector2 = (actor.position - run_from_enemy.position).normalized()

  actor.move_toward_target(actor.position + (run_direction * actor.move_speed))

func _ready():
  actor.register_behavior(self)

func _sort_enemies_by_distance(a, b):
  return actor.position.distance_squared_to(a.position) < actor.position.distance_squared_to(b.position)