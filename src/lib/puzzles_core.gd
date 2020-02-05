const puzzle_button_textures = {
  "base": preload("res://src/assets_compiled/textures/puzzle_block_base.tres"),
  "horizontal": preload("res://src/assets_compiled/textures/puzzle_block_horizontal.tres"),
  "vertical": preload("res://src/assets_compiled/textures/puzzle_block_vertical.tres"),
  "top_left": preload("res://src/assets_compiled/textures/puzzle_block_top_left.tres"),
  "top_right": preload("res://src/assets_compiled/textures/puzzle_block_top_right.tres"),
  "bottom_left": preload("res://src/assets_compiled/textures/puzzle_block_bottom_left.tres"),
  "bottom_right": preload("res://src/assets_compiled/textures/puzzle_block_bottom_right.tres"),
  "endpoint": preload("res://src/assets_compiled/textures/puzzle_block_endpoint.tres")
}

const puzzle_block_directions = {
  "base": [],
  "endpoint": ["up", "down", "left", "right"],
  "horizontal": ["left", "right"],
  "vertical": ["up", "down"],
  "top_left": ["down", "right"],
  "top_right": ["down", "left"],
  "bottom_left": ["up", "right"],
  "bottom_right": ["up", "left"]
}

const puzzle_block_opposites = {
  "up": "down",
  "down": "up",
  "left": "right",
  "right": "left"
}

static func generate(grid_size, obstacle_base, obstacle_additional):
  var matrix = []

  for x in range(grid_size):
    var matrix_row = []

    for y in range(grid_size):
      var new_button = {
        "visited": false,
        "disabled": false
      }
      matrix_row.append(new_button)
    matrix.append(matrix_row)

  for d in range((randi() % obstacle_base) + obstacle_additional):
    matrix[randi() % 8][randi() % 8]["disabled"] = true

  return matrix
