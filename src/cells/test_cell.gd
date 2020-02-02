extends Node2D

var tilemap_extents = Vector2()
var camera_moving = false

func _ready() -> void:
  tilemap_extents = $TileMap.get_used_rect().size * $TileMap.cell_size
  $Camera2D.limit_right = tilemap_extents.x
  $Camera2D.limit_bottom = tilemap_extents.y
  $Camera2D/UI.update_health(0)
  $Camera2D/UI.update_robots($Robots.get_children().size())

func _physics_process(delta: float) -> void:
    _repair_ready_check()

func _process(delta: float) -> void:
  if not camera_moving:
    var camera_center = $Camera2D.get_camera_screen_center()
    var viewport_size = get_viewport_rect().size
    var extents = [
      $Camera2D.position,
      ($Camera2D.position + viewport_size)
    ]

    if $BeginnerPlayer.position.y > extents[1].y:
      var y_increase = viewport_size.y if ((extents[1].y + viewport_size.y) <= tilemap_extents.y) else (tilemap_extents.y - extents[1].y)
      var new_position = Vector2($Camera2D.position.x, $Camera2D.position.y + y_increase)
      _move_camera(new_position)
    elif $BeginnerPlayer.position.y < extents[0].y:
      var y_decrease = viewport_size.y if ((extents[0].y - viewport_size.y) >= 0) else (extents[0].y)
      var new_position = Vector2($Camera2D.position.x, $Camera2D.position.y - y_decrease)
      _move_camera(new_position)
    elif $BeginnerPlayer.position.x > extents[1].x:
      var x_increase = viewport_size.x if ((extents[1].x + viewport_size.x) <= tilemap_extents.x) else (tilemap_extents.x - extents[1].x)
      var new_position = Vector2($Camera2D.position.x + x_increase, $Camera2D.position.y)
      _move_camera(new_position)
    elif $BeginnerPlayer.position.x < extents[0].x:
      var x_decrease = viewport_size.x if ((extents[0].x - viewport_size.x) >= 0) else (extents[0].x)
      var new_position = Vector2($Camera2D.position.x - x_decrease, $Camera2D.position.y)
      _move_camera(new_position)

func _move_camera(new_position) -> void:
  $Tween.interpolate_property(
    $Camera2D,
    "position",
    $Camera2D.position,
    new_position,
    0.4,
    Tween.TRANS_LINEAR,
    Tween.EASE_IN
  )
  $Tween.start()


func _on_Tween_tween_started(object: Object, key: NodePath) -> void:
  camera_moving = true

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
  camera_moving = false

func _repair_ready_check() -> void: 
    for robot in $Robots.get_children():
        if robot.get_node("Area2D").overlaps_body($BeginnerPlayer):
            robot.repairable = true
    
        
