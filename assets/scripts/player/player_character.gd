extends CharacterBody3D

###Movement###
var fall_accel = Global.fall_accel
var jump_force = Global.jump_force
var steer_speed = Global.steer_speed
var target_velocity = Vector3.ZERO


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	velocity = target_velocity
	velocity.x = %PlayerVision.rotation.y * steer_speed
	
	if %PlayerVision.rotation.y > deg_to_rad(10):
		%PlayerVision.rotation.z = lerp(%PlayerVision.rotation.z, deg_to_rad(12.4), deg_to_rad(1.0))
	elif %PlayerVision.rotation.y < deg_to_rad(-10):
		%PlayerVision.rotation.z = lerp(%PlayerVision.rotation.z, deg_to_rad(-12.4), deg_to_rad(1.0))
	else:
		var current_rot = %PlayerVision.rotation.z
		%PlayerVision.rotation.z = lerp(current_rot, deg_to_rad(0.0), deg_to_rad(3.0))
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_accel * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = jump_force
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		%PlayerVision.rotate_y(-event.relative.x * 0.006)
		%PlayerVision.rotation.y = clamp(%PlayerVision.rotation.y, deg_to_rad(-35), deg_to_rad(35))
		
