extends Timer

func _ready() -> void:
	%GameTimer.wait_time = Global.base_time
	%GameTimer.one_shot = true
	%GameTimer.autostart = true #alter later for delay for tutorial level -- or maybe just have a level transition and only set this in main


func _process(delta: float) -> void:
	print(%GameTimer.time_left)
	if %GameTimer.time_left == 0.0:
		get_tree().change_scene_to_file("res://levels/temp_game_over.tscn")
