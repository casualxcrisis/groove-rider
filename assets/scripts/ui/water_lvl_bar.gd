extends TextureProgressBar


func _process(delta: float) -> void:
	%WaterLvlHUD.value = %GameTimer.time_left
