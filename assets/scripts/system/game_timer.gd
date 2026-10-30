extends Timer

func _ready() -> void:
	%GameTimer.wait_time = Global.base_time
	%GameTimer.one_shot = true
	%GameTimer.autostart = true #alter later for delay for tutorial level -- or maybe just have a level transition and only set this in main


func _process(delta: float) -> void:
	print(%GameTimer.time_left)
	if %GameTimer.time_left == 0.0:
		get_tree().change_scene_to_file("res://levels/temp_game_over.tscn")


func _on_hurt_pickup_zone_body_entered(body: Node3D) -> void:
	if body.is_in_group("time_pickup"):
		%GameTimer.start(%GameTimer.time_left + Global.time_pickup)
		%TimePickup.play()
		body.queue_free()
