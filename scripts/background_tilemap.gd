extends TileMapLayer

var screen_size : Vector2
var origninal_tile_size : float
@export var number_of_lanes = 7
@export var opposing_lanes = 2
@export var with_lanes = 2
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
	print("Grid size should be %s,%s" % [grid_size.x, grid_size.y])
	_generate_basic_background()
	
	
#Generate grid based on left/right edge tiles and number of lanes
func _generate_grid():
	var lanes = opposing_lanes + with_lanes
	grid_size.x = edge_tiles_left + edge_tiles_right + ((lanes - 1) * 2) + 1
	var tile_width = screen_size.x / grid_size.x
	var y_tile_count = ceil(screen_size.y / tile_width)
	grid_size = Vector2i(grid_size.x, y_tile_count)
	var scale_amount = tile_width / origninal_tile_size
	scale = Vector2(scale_amount, scale_amount)

func _generate_basic_background():
	var alt_tile = 0
	var lane_count = 0
	var yellow_line = edge_tiles_left + (opposing_lanes * 2 - 1)
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
			elif x == yellow_line:
				tile = yellow_line_tile
			else:
				if last_tile_placed == empty_road_tile:
					tile = dotted_line_tile
					
			
			last_tile_placed = tile
			set_cell(Vector2i(x,y),source_id, tile, alt_tile)
			var coords = self.map_to_local(Vector2i(x,y))
			print("%s,%s" % [coords.x, coords.y])
