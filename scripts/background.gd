extends Node2D

@onready var camera = $Camera2D
@onready var tilemap = $TileMapLayer

func _ready():
	var tilemap_rect = tilemap.get_used_rect()
	tilemap_rect.position *= Vector2i(32,32)
	tilemap_rect.size *= Vector2i(32,32)
	var camera_rect = camera.get_viewport_rect()
	camera.offset = tilemap_rect.position+Vector2i(tilemap_rect.size / 2) 
	var x_ratio = 1.02*camera_rect.size.x/tilemap_rect.size.x 
	var y_ratio = 1.02*camera_rect.size.y/tilemap_rect.size.y 
	if x_ratio < y_ratio:
		camera.zoom = Vector2(x_ratio,x_ratio)
	else:
		camera.zoom = Vector2(y_ratio,y_ratio)
