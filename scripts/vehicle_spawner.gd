#VehicleSpawner.gd
extends Node2D

@export var vehicle : PackedScene
@export var spawn_width : int
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size
	spawn_width = screen_size.x / 2
	_spawn_vehicle()
	

func _spawn_vehicle():
	if not vehicle:
		push_error("No Vehicle Scene Assigned")
		return
		
	var spawn_location : Vector2
	var x_location = randi_range(-spawn_width, spawn_width)
	spawn_location = Vector2(x_location, 300)
	
	var vehicle = vehicle.instantiate()
	vehicle.global_position = spawn_location
	
