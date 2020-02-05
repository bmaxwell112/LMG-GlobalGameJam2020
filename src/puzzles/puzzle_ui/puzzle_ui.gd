extends VBoxContainer

func _ready() -> void:
  $PuzzleTimer.start(25)

func _process(delta: float) -> void:
  $TimerLabel.text = "Time Remaining: %s" % round($PuzzleTimer.time_left)
