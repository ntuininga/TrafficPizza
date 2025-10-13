extends Area2D

signal vehicle_hit

@export var speed = 400
@export var rotation_speed = 5
@onready var animated_sprite = $AnimatedSprite2D
var screen_size
const MAX_TURN_ANGLE = 25

func _ready():
	screen_size = get_viewport_rect().size
	connect("area_entered", Callable(self, "_on_area_entered"))
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	var target_angle = 0.0
	var rotate_speed = rotation_speed

	if Input.is_action_just_pressed("move_left"):
		animated_sprite.play("turn_left")
	if Input.is_action_just_pressed("move_right"):
		animated_sprite.play("turn_right")

	# Handle input and movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		target_angle = deg_to_rad(MAX_TURN_ANGLE)
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		target_angle = deg_to_rad(-MAX_TURN_ANGLE)
	else: 
		rotate_speed = 10
		if animated_sprite.animation != "default":
			animated_sprite.play("default")

	position += velocity * delta * speed * abs(rotation)
	position = position.clamp(Vector2.ZERO, screen_size)

	rotation = lerp_angle(rotation, target_angle, rotate_speed * delta)



func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	if area.is_in_group("vehicles"):
		vehicle_hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
