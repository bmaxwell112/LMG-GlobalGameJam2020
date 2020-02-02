extends KinematicBody2D

var paused = false
var speed = 300
var velocity = Vector2()
var initial_position = Vector2()
var distance = 300
var direction_is_left = true

func _ready() -> void:
    initial_position = global_position
    print(initial_position)
    $Timer.connect("timeout",self,"_resume_patrol")

func _physics_process(_delta: float) -> void:
  if direction_is_left:
    _patrol(Vector2(-1, 0))
  else:
    _patrol(Vector2(1, 0))
        

func _patrol(direction) -> void:
  if global_position.x < (initial_position.x - distance) and direction_is_left:
    direction_is_left = false
    $Timer.start()    
    $AnimatedSprite.stop()
  if global_position.x > (initial_position.x + distance) and not direction_is_left:
    direction_is_left = true
    $AnimatedSprite.stop()
    $Timer.start()
  if $Timer.get_time_left() == 0:
    $AnimatedSprite.play("MoveRight")
    var velocity = direction * speed
    move_and_slide(velocity)

func _resume_patrol() -> void:
    $AnimatedSprite.flip_h = direction_is_left
