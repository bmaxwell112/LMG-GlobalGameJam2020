extends KinematicBody2D

var walk_speed: int = 300
var run_speed: int = 500
var velocity: Vector2 = Vector2()
var stamina: float = 100.0

func _physics_process(delta: float) -> void:
  velocity = _get_movement_velocity()
  move_and_slide(velocity)


func _get_movement_velocity() -> Vector2:
  var movement_velocity := Vector2(
    (float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))),
    (float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))
  ).normalized()

  if movement_velocity == Vector2():
    $AnimatedSprite.stop()
    $AnimatedSprite.frame = 0
  else:
    if Input.is_action_pressed("move_left"):
      $AnimatedSprite.flip_h = true
      $AnimatedSprite.play("WalkRight")
    elif Input.is_action_pressed("move_right"):
      $AnimatedSprite.flip_h = false
      $AnimatedSprite.play("WalkRight")
    elif Input.is_action_pressed("move_up"):
      $AnimatedSprite.play("WalkUp")
    elif Input.is_action_pressed("move_down"):
      $AnimatedSprite.play("WalkDown")

  if Input.is_action_pressed("run"):
    if stamina > 0.0:
      $AnimatedSprite.speed_scale = 1.8
      stamina -= 0.25
      return movement_velocity * run_speed
    else:
      $AnimatedSprite.speed_scale = 1.0
      return movement_velocity * walk_speed
  else:
    $AnimatedSprite.speed_scale = 1.0
    if stamina < 100.0:
      stamina += 0.25
    return movement_velocity * walk_speed
