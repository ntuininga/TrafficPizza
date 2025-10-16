extends TileMapLayer

var screen_size : Vector2
var origninal_tile_size : float
@export var number_of_lanes = 7
@export var edge_tiles_left = 2
@export var edge_tiles_right = 2
#Grid size X should always be odd
var grid_size = Vector2i(17, 0)

#Setting atlas coords for different tiles
var empty_grass_tile = Vector2i(1, 2)
var edge_grass_tile = Vector2i(2, 0)
var empty_road_tile = Vector2i(3, 0)
var yellow_line_tile = Vector2i(3, 2)
var dotted_line_tile = Vector2i(3, 1)
var edge_tile = Vector2i(4,0)
var source_id = 0

var last_tile_placed : Vector2i

func _ready():
	screen_size = get_viewport_rect().size
	origninal_tile_size = tile_set.tile_size.y
	print("Original tile size %s" % [origninal_tile_size])
	_generate_grid()
	#_get_number_of_tiles()
	print("Grid size should be %s,%s" % [grid_size.x, grid_size.y])
	_generate_basic_background()
	#_build_basic_background()
	
#Each lane contains ~2 tiles worth or ~32 pixels
#Divide screen width by number of lanes + min 2 for side pieces
#Determine scale up to reach the appropriate sizing for the screen
func _get_number_of_tiles():
	var tile_width = screen_size.x / (number_of_lanes + 2)
	#var tile_width = ceil(target_tile_width / origninal_tile_size) * origninal_tile_size
	#var tile_width = target_tile_width / origninal_tile_size
	print("Tile width should be %s" % [tile_width])
	
	#Tile grid size should be rounded to whole number above its value
	grid_size = Vector2(ceil(screen_size.x / tile_width), ceil(screen_size.y / tile_width))
	if grid_size.x % 2 == 0:
		grid_size.x += 1
		grid_size.y += 1
	var total_width = tile_width * grid_size.x
	print("Total width %s, Screen width %s", [total_width, screen_size.x])
	var should_be_moved = (screen_size.x - total_width)
	#If Tile grid size is an even number shift over to be centred
	if int(grid_size.x) % 2 == 0:
		position.x += should_be_moved
	
	#amount to scale up
	var scale_amount = int(tile_width / origninal_tile_size)
	print(scale_amount)
	scale = Vector2(scale_amount, scale_amount)

#Generate grid based on left/right edge tiles and number of lanes
func _generate_grid():
	grid_size.x = edge_tiles_left + edge_tiles_right + ((number_of_lanes - 1) * 2) + 1
	var tile_width = screen_size.x / grid_size.x
	var y_tile_count = ceil(screen_size.y / tile_width)
	grid_size = Vector2i(grid_size.x, y_tile_count)
	var scale_amount = tile_width / origninal_tile_size
	scale = Vector2(scale_amount, scale_amount)

func _generate_basic_background():
	var alt_tile = 0
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			alt_tile = 0
			var tile = empty_road_tile
			if x < edge_tiles_left - 1:
				tile = empty_grass_tile
			elif x > grid_size.x - edge_tiles_right:
				tile = empty_grass_tile
			elif x == edge_tiles_left - 1:
				tile = edge_grass_tile
			elif x == grid_size.x - edge_tiles_right:
				tile = edge_grass_tile
				alt_tile = 1
			else:
				if last_tile_placed == empty_road_tile:
					tile = dotted_line_tile
			
			last_tile_placed = tile
			set_cell(Vector2i(x,y),source_id, tile, alt_tile)

#Builds basic background with simple edge tiles 
#Adds basic yellow centre line
func _build_basic_background():
	var alt_tile = 0
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			alt_tile = 0
			var tile = empty_road_tile
			if x == 0:
				tile = empty_grass_tile
			elif x == grid_size.x - 1:
				tile = empty_grass_tile
			elif x == ceil(grid_size.x / 2) && last_tile_placed == empty_road_tile:
				tile = yellow_line_tile
			elif x == grid_size.x - 2 :
				tile = edge_grass_tile
				alt_tile = 1
			else:
				if (last_tile_placed == empty_road_tile):
					tile = dotted_line_tile
				elif (last_tile_placed == empty_grass_tile):
					tile = edge_grass_tile
			last_tile_placed = tile
			set_cell(Vector2i(x,y),source_id, tile, alt_tile)
