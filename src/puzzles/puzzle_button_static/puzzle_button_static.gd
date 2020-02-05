extends TextureButton

signal chosen(texture)

const PuzzlesCore = preload("res://src/lib/puzzles_core.gd")

export var texture_key: String = "base"

func _ready() -> void:
  texture_normal = PuzzlesCore.puzzle_button_textures[texture_key]

func _on_pressed() -> void:
  modulate = Color(1, 0, 1, 1)
  emit_signal("chosen", texture_key)
