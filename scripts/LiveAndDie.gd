extends Node
class_name LiveAndDie

export var ageRate:float

onready var actor = $"../"

var health = 1.0
var age = 0.0
var maxAge = 1.0

func _ready():
  pass

func _process(delta):
  _growOlder(delta * ageRate)

  if _isTooOld() || _isTooSick():
    _curlUpAndDie()

func _curlUpAndDie():
  actor.emit_signal("dies")

func _growOlder(amount):
  age += amount
  #health = _setHealthClamped(health - amount)

func _isTooOld():
  return age >= maxAge

func _isTooSick():
  return health <= 0.0

func _setHealthClamped(unclampedHealth):
  return clamp(unclampedHealth, 0, 1)

func takeDamage(amount):
  health = _setHealthClamped(health - amount)