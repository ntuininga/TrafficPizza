extends Node2D
#
#@export var scroll_speed := 100.0
@export var tilemap_base : PackedScene
#
#var tilemaps = []
#var loop_height := 0.0
#
func _ready():
	var tilemap1 = tilemap_base.instantiate()
	#var tilemap2 = tilemap_base.instantiate()
	#
	add_child(tilemap1)
	#add_child(tilemap2)
	#
	#tilemaps = [tilemap1, tilemap2]
	#
	#
	#var tile_size = tilemap1.tile_set.tile_size.y
#
	## Determine how many rows are in one loop segment
	#var tile_count = 0
	#for cell in tilemap1.get_used_cells(0):
		#if cell.y > tile_count:
			#tile_count = cell.y
	#tile_count = int((tile_count + 1))
#
	#loop_height = tile_count * tile_size
	#tilemap2.position = Vector2(0, -loop_height)
#
#func _process(delta):
	#for tilemap in tilemaps:
		#tilemap.position.y += scroll_speed * delta
		#
	#for tilemap in tilemaps:
		#if tilemap.position.y > loop_height:
			#tilemap.position = Vector2(0, -loop_height)
