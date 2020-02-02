extends TextureButton

signal assigned(button)

var state = "base"
var valid = false
var pos_index = Vector2()

func _on_pressed() -> void:
  emit_signal("assigned", self)
