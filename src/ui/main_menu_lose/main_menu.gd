extends Control

var game_scene = preload("res://src/cells/TestCell.tscn")
var message = "The robots cut you to ribbons. That surgery's going to cost a fortune..."

func _ready() -> void:
  $CenterContainer/VBoxContainer/MessageContainer/MessageLabel.text = message

func _on_PlayButton_pressed() -> void:
  get_tree().change_scene_to(game_scene)
