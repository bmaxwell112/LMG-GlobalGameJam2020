extends Control


# Declare member variables here. Examples:

var health = 100 

func update_health(damage) -> void:
    health = clamp(health - damage, 0, 100)
    $Label2.text = "Health Remaining " + String(health) + "%"

func update_robots(r_count) -> void:
    $Label.text = "Robots Remaining " + String(r_count)
