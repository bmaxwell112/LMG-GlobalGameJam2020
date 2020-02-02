extends GridContainer

var puzzle_button_dynamic = preload("res://src/puzzles/puzzle_button_dynamic/PuzzleButtonDynamic.tscn")
var puzzle_matrix = []
var puzzle_points = {
  "start": Vector2(),
  "end": Vector2()
}

func _ready() -> void:
  randomize()
  var puzzle_valid = false

  while not puzzle_valid:
    puzzle_matrix = _generate_puzzle_board()
    puzzle_points = _generate_puzzle_points()
    puzzle_valid = _is_puzzle_valid()

  for x in range(8):
    for y in range(8):
      $".".add_child(puzzle_matrix[x][y])

func _generate_puzzle_board() -> Array:
  var matrix = []

  for x in range(8):
    var matrix_row = []

    for y in range(8):
      var new_button = puzzle_button_dynamic.instance()
      matrix_row.append(new_button)
    matrix.append(matrix_row)
  for d in range((randi() % 10) + 10):
    matrix[randi() % 8][randi() % 8].disabled = true
  return matrix

func _generate_puzzle_points() -> Dictionary:
  var points = {}
  var start_valid = false
  var end_valid = false

  while not start_valid:
    var start_point = Vector2(randi() % 8, 0)

    if not puzzle_matrix[start_point.x][start_point.y].disabled:
      points["start"] = start_point
      start_valid = true

  while not end_valid:
    var end_point = Vector2(randi() % 8, 7)

    if not puzzle_matrix[end_point.x][end_point.y].disabled:
      points["end"] = end_point
      end_valid = true

  return points

func _is_puzzle_valid() -> bool:
  var check_matrix = []
  var visited = []
  var queue = [puzzle_points["start"]]

  for x in range(8):
    var check_matrix_row = []

    for y in range(8):
      check_matrix_row.append({
        "blocked": puzzle_matrix[x][y].disabled,
        "visited": false
      })
    check_matrix.append(check_matrix_row)

  while not queue.empty():
    var current_cell = queue.pop_front()
    #print(current_cell)
    if current_cell == puzzle_points["end"]:
      return true
    var row = current_cell.x
    var col = current_cell.y

    if row < 0 || col < 0 || row > 7 || col > 7 || check_matrix[row][col]["visited"] || check_matrix[row][col]["blocked"]:
      continue

    check_matrix[row][col]["visited"] = true
    queue.push_back(Vector2(row - 1, col))
    queue.push_back(Vector2(row + 1, col))
    queue.push_back(Vector2(row, col - 1))
    queue.push_back(Vector2(row, col + 1))

  return false
