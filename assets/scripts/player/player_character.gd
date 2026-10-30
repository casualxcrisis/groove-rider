extends CharacterBody3D

###Movement###
var speed = Global.fwd_speed
var fall_accel = Global.fall_accel
var jump_force = Global.jump_force
var grav_scale = Global.grav_scale
var steer_speed = Global.steer_speed
var target_velocity = Vector3.ZERO
#sloppy start delay - in future make actually good
var start_buffer = false

###Camera###
var current_rot = deg_to_rad(0.0)
var rotation_left = deg_to_rad(-3.5)
var rotation_right = deg_to_rad(3.5)
var cam_acceleration = 20

func _ready() -> void:
	#slop
	await get_tree().create_timer(5).timeout
	start_buffer = true

func _physics_process(delta: float) -> void:
	velocity = target_velocity
	#slop cont.
	if start_buffer:
		velocity.z = move_toward(0, 4, speed)
	#jump
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_accel * delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		target_velocity.y = jump_force
	#steering
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_toward(0, 50, 10)
		%PlayerVision.rotation.z = lerp(current_rot, rotation_left, cam_acceleration * delta)
	if Input.is_action_just_released("move_left"):
		$PlayerVision.rotation.z = current_rot 
	if Input.is_action_pressed("move_right"):
		velocity.x = move_toward(0, 50, 10)
		$PlayerVision.rotation.z = lerp(current_rot, rotation_right, cam_acceleration * delta) 
	if Input.is_action_just_released("move_right"):
		%PlayerVision.rotation.z = deg_to_rad(0.0) 

	#var mouse_pos = get_viewport().get_mouse_position()
	#if mouse_pos.x > 600:
		#velocity.x = steer_speed
	#if mouse_pos.x < 600:
		#velocity.x = -steer_speed
	#if mouse_pos.x == 500:
		#velocity.x = 0
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * steer_speed
		#velocity.z = direction.z * steer_speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, steer_speed)
		#velocity.z = move_toward(velocity.z, 0, steer_speed)	
	move_and_slide()

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#var mouse_pos = get_viewport().get_mouse_position()
		#if mouse_pos.x > 600:
			#velocity.x = steer_speed
		#if mouse_pos.x < 600:
			#velocity.x = -steer_speed
		#if mouse_pos.x == 500:
			#velocity.x = 0
