extends Node2D

@export var vehicle: PackedScene
@export var spawn_width: int = 400  # Default value, customizable in editor

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	_spawn_vehicle()


func _spawn_vehicle():
	if not vehicle:
		push_error("No Vehicle Scene Assigned")
		return

	var x_location = randf_range(-spawn_width / 2.0, spawn_width / 2.0)
	var spawn_location = Vector2(screen_size.x / 2 + x_location, -screen_size.y)

	var vehicle_instance = vehicle.instantiate()
	vehicle_instance.global_position = spawn_location

	add_child(vehicle_instance)


func _on_vehicle_spawn_timer_timeout():
	_spawn_vehicle()


func _on_main_game_over() -> void:
	print("Stopping spawner")
	$VehicleSpawnTimer.stop()
	for child in get_children():
		if child.is_in_group("vehicles"):
			child.queue_free()
