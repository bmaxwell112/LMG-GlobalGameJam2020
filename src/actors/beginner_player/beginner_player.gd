extends KinematicBody2D

var walk_speed: int = 300
var run_speed: int = 500
var velocity: Vector2 = Vector2()

func _physics_process(delta: float) -> void:
  velocity = _get_movement_velocity()
  move_and_slide(velocity)

func _get_movement_velocity() -> Vector2:
  var movement_velocity := Vector2(
    (float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))),
    (float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))
  ).normalized()
  if Input.is_action_pressed("run"):
    return movement_velocity * run_speed
  else:
    return movement_velocity * walk_speed
