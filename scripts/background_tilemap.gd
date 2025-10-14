extends TileMap

var screen_size : Vector2
var origninal_tile_size : float
var number_of_lanes = 6
var grid_size : Vector2i

#Setting atlas coords for different tiles
var empty_road_tile = Vector2i(3, 0)
var edge_tile = Vector2i(4,0)
var source_id = 0

func _ready():
	screen_size = get_viewport_rect().size
	origninal_tile_size = tile_set.tile_size.y
	print("Original tile size %s" % [origninal_tile_size])
	_get_number_of_tiles()
	print("Grid size should be %s,%s" % [grid_size.x, grid_size.y])
	_build_basic_background()
	
#Each lane contains ~2 tiles worth or ~32 pixels
#Divide screen width by number of lanes + min 2 for side pieces
#Determine scale up to reach the appropriate sizing for the screen
func _get_number_of_tiles():
	var target_tile_width = screen_size.x / (number_of_lanes + 2)
	var tile_width = ceil(target_tile_width / origninal_tile_size) * origninal_tile_size
	print("Tile width should be %s" % [tile_width])
	
	#Tile grid size should be rounded to whole number above its value
	grid_size = Vector2(ceil(screen_size.x / tile_width), ceil(screen_size.y / tile_width))	
	#If Tile grid size is an even number shift over to be centred
	if int(grid_size.x) % 2 == 0:
		position.x -= tile_width / 2
	
	#amount to scale up
	var scale_amount = int(tile_width / origninal_tile_size)
	print(scale_amount)
	scale = Vector2(scale_amount, scale_amount)

func _build_basic_background():
	for y in range(grid_size.y):
		for x in range(grid_size.x):
			var tile = empty_road_tile
			if x == 0 or x == grid_size.x - 1:
				tile = edge_tile
			
			set_cell(0, Vector2i(x,y), source_id, tile)
