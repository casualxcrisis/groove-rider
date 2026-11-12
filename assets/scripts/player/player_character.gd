extends CharacterBody3D

###Movement###
var speed = Global.fwd_speed
var fall_accel = Global.fall_accel
var jump_force = Global.jump_force
var grav_scale = Global.grav_scale
var steer_speed = Global.steer_speed
var target_velocity = Vector3.ZERO

var start_buffer = false

###Camera###
var current_rot = deg_to_rad(0.0)
var rotation_left = deg_to_rad(-3.5)
var rotation_right = deg_to_rad(3.5)
var cam_acceleration = 20

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#implement real countdown timer with timeout being the beginning of the movement/level
	await get_tree().create_timer(5).timeout
	start_buffer = true

func _physics_process(delta: float) -> void:
	velocity = target_velocity
	
	if start_buffer:
		velocity.z = speed
		velocity.x = %PlayerVision.rotation.y * steer_speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_accel * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = jump_force
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%PlayerVision.rotate_y(-event.relative.x * 0.006)
		%PlayerVision.rotation.y = clamp(%PlayerVision.rotation.y, deg_to_rad(-30), deg_to_rad(30))
