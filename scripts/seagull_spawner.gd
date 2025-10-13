extends Node2D

@export var seagull_scene : PackedScene
@onready var spawn_timer = $SeagullSpawnTimer
var seagull_spawn_time : int
var screen_size : Vector2
var x_locations = []
var spawn_range = [5, 20]

func _ready():
	screen_size = get_viewport_rect().size
	x_locations = [-50, screen_size.x + 50]
	randomize()
	seagull_spawn_time = randi_range(spawn_range[0], spawn_range[1])
	spawn_timer.start(seagull_spawn_time)


func _on_seagull_spawn_timer_timeout() -> void:
	if not seagull_scene:
		push_error("No Seagull Scene assigned")
		return
	
	var x_location = x_locations[randi() % x_locations.size()]
	var spawn_location = Vector2(x_location, randf_range(0, screen_size.y))
	#spawn in seagull
	var seagull = seagull_scene.instantiate()
	seagull.global_position = spawn_location
	add_child(seagull)
	
	seagull_spawn_time = randi_range(spawn_range[0], spawn_range[1])
	spawn_timer.start(seagull_spawn_time)
