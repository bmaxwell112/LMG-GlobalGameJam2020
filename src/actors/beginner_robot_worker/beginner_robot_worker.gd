extends KinematicBody2D

signal launch_puzzle

var paused = false
var speed = 300
var velocity = Vector2()
var initial_position = Vector2()
export var distance = 300
var direction_is_left = true
var repairable = false
var working = false
var attacking = false

func _ready() -> void:
    randomize()
    initial_position = global_position
    print(initial_position)
    $Timer.connect("timeout",self,"_resume_patrol")
    $AnimatedSprite.connect("animation_finished",self,"_end_attack")

func _input(event):
    if repairable && Input.is_action_just_pressed("interact"):
        _repair()

func _end_attack() -> void:
    attacking = false;

func _physics_process(_delta: float) -> void:
    if not working and not attacking:
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

func _repair() -> void:
    emit_signal("launch_puzzle")
    print("This robot is being repaired")

func success() -> void:
    $Area2D.monitoring = false
    working = true
    repairable = false
    $AnimatedSprite.play("Disabled")

func failed() -> void:
    $AnimatedSprite.play("Attack")
    attacking = true
