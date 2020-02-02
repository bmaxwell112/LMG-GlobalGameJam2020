extends Control

var game_scene = preload("res://src/cells/TestCell.tscn")
var message = ""

func _ready() -> void:
  $CenterContainer/VBoxContainer/MessageContainer/MessageLabel.text = message

func _on_PlayButton_pressed() -> void:
  get_tree().change_scene_to(game_scene)
