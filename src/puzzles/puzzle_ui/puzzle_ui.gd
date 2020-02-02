extends VBoxContainer

var current_texture = "base"

func _on_PuzzleButtonStaticHorizontal_pressed() -> void:
  $PuzzleGridContainer.current_texture = "horizontal"

func _on_PuzzleButtonStaticVertical_pressed() -> void:
  $PuzzleGridContainer.current_texture = "vertical"

func _on_PuzzleButtonStaticTopLeft_pressed() -> void:
  $PuzzleGridContainer.current_texture = "top_left"

func _on_PuzzleButtonStaticTopRight_pressed() -> void:
  $PuzzleGridContainer.current_texture = "top_right"

func _on_PuzzleButtonStaticBottomLeft_pressed() -> void:
  $PuzzleGridContainer.current_texture = "bottom_left"

func _on_PuzzleButtonStaticBottomRight_pressed() -> void:
  $PuzzleGridContainer.current_texture = "bottom_right"
