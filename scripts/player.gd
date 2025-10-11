extends Area2D

signal vehicle_hit

@export var speed = 400
@export var rotation_speed = 5
var screen_size
const MAX_TURN_ANGLE = 25

func _ready():
	screen_size = get_viewport_rect().size
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process(delta):
	var velocity = Vector2.ZERO
	var target_angle = 0.0
	var rotate_speed = rotation_speed

	# Handle input and movement
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		target_angle = deg_to_rad(MAX_TURN_ANGLE)
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		target_angle = deg_to_rad(-MAX_TURN_ANGLE)
	else: 
		rotate_speed = 10

	position += velocity * delta * speed * abs(rotation)
	position = position.clamp(Vector2.ZERO, screen_size)

	rotation = lerp_angle(rotation, target_angle, rotate_speed * delta)



func _on_body_entered(body):
	vehicle_hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
