extends KinematicBody2D

export var patrol_axis := "x"
export var initial_direction := "left"

var paused = false
var speed = 300
var velocity = Vector2()

func _physics_process(delta: float) -> void:
  pass
