extends GridContainer

signal solved

const PuzzlesCore = preload("res://src/lib/puzzles_core.gd")
const PuzzleButtonDynamic = preload("res://src/puzzles/puzzle_button_dynamic/PuzzleButtonDynamic.tscn")

var current_texture = "base"
var puzzle_matrix = []
var puzzle_points = {
  "start": Vector2(),
  "end": Vector2()
}
var puzzle_path = []

func _ready() -> void:
  randomize()
  var puzzle_valid = false

  while not puzzle_valid:
    puzzle_matrix = PuzzlesCore.generate(8, 10, 10)
    puzzle_points = _generate_puzzle_points()
    puzzle_valid = _is_puzzle_valid()

  var start_point = puzzle_matrix[puzzle_points["start"].x][puzzle_points["start"].y]
  start_point.state = "endpoint"
  start_point.valid = true
  start_point.texture_disabled = PuzzlesCore.puzzle_button_textures["endpoint"]
  start_point.disabled = true
  puzzle_path.push_back(start_point)
  var end_point = puzzle_matrix[puzzle_points["end"].x][puzzle_points["end"].y]
  end_point.state = "endpoint"
  end_point.valid = true
  end_point.texture_disabled = PuzzlesCore.puzzle_button_textures["endpoint"]
  end_point.disabled = true

  for x in range(8):
    for y in range(8):
      var puzzle_button = PuzzleButtonDynamic.instance()
      puzzle_button.disabled = puzzle_matrix[x][y]["disabled"]
      puzzle_matrix[x][y].pos_index = Vector2(x, y)
      $".".add_child(puzzle_button)
      puzzle_button.connect("assigned", self, "_on_PuzzleButtonDynamic_assigned")

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

func _on_PuzzleButtonDynamic_assigned(button):
  var directions = PuzzlesCore.puzzle_block_directions[current_texture]
  var adjacents = []

  for dir in directions:
    var adjacent_cell = null

    match dir:
      "up":
        if button.pos_index.x > 0:
          adjacent_cell = Vector2(button.pos_index.x - 1, button.pos_index.y)
      "down":
        if button.pos_index.x < 7:
          adjacent_cell = Vector2(button.pos_index.x + 1, button.pos_index.y)
      "left":
        if button.pos_index.y > 0:
          adjacent_cell = Vector2(button.pos_index.x, button.pos_index.y - 1)
      "right":
        if button.pos_index.y < 7:
          adjacent_cell = Vector2(button.pos_index.x, button.pos_index.y + 1)

    if not adjacent_cell == null && puzzle_matrix[adjacent_cell.x][adjacent_cell.y].valid:
      button.valid = true
      button.texture_normal = PuzzlesCore.puzzle_button_textures[current_texture]
      if adjacent_cell == puzzle_points["end"]:
        emit_signal("solved")


