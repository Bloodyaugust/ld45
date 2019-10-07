extends Node2D

class_name Burnable

export var aflame := false
export var avgSecondsPerIgnite := 40
export var areaOfEffect = 500
export var damagesParent := true
export var damagePerSec := 0.2

const avgSecPerFlameScatter = 20

onready var actor : Actor = $".."

func _ready():
  _scramble_flame_sprites()

func _process(delta):
  if aflame:
    $Flame1.visible = true
    $Flame2.visible = true
    $Flame3.visible = true
    _roll_for_ignite(delta)
    _roll_for_flame_scramble(delta)
    if damagesParent:
      actor.get_node("LiveAndDie").takeDamage(delta * damagePerSec)

func _roll_for_ignite(delta):
  var roll = (randf() / 10)
  var chance = delta * (1.0 / avgSecondsPerIgnite)
  if roll < chance:
    try_ignite()

func _roll_for_flame_scramble(delta):
  var roll = (randf() / 10)
  var chance = delta * (1.0 / avgSecPerFlameScatter)
  if roll < chance:
    _scramble_flame_sprites()

func try_ignite():
  var target = get_burn_target()
  if not target == null:
    target.ignite()

func ignite():
  aflame = true

func get_burn_target():
  var target = null
  for node in get_tree().get_nodes_in_group("Burnables"):
    if node.aflame:
      continue
    var distance = node.get_global_position().distance_to(actor.position)
    if distance > areaOfEffect:
      continue
    if target == null or distance < target.get_global_position().distance_to(actor.position):
      target = node
  return target

func _scramble_flame_sprites():
  _scramble_flame($Flame1)
  _scramble_flame($Flame3)
  _scramble_flame($Flame2)

func _scramble_flame(sprite):
  sprite.position = Vector2(self.position.x + rand_range(-100, 100), self.position.y + rand_range(-100, 100))