extends GridContainer

var puzzle_button_dynamic = preload("res://src/puzzles/puzzle_button_dynamic/PuzzleButtonDynamic.tscn")
var puzzle_matrix = []

func _ready() -> void:
  randomize()
  puzzle_matrix = _generate_puzzle_board()

func _generate_puzzle_board() -> Array:
  var matrix = []

  for x in range(8):
    var matrix_row = []

    for y in range(8):
      var new_button = puzzle_button_dynamic.instance()
      $".".add_child(new_button)
      matrix_row.append(new_button)
    matrix.append(matrix_row)
  for d in range((randi() % 10) + 5):
    matrix[randi() % 8][randi() % 8].disabled = true
  return matrix
