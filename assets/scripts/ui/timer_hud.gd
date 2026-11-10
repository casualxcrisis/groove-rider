extends Label


func _process(_delta: float) -> void:
	var timer_string = var_to_str(int(%GameTimer.time_left))
	%TimerHUD.set_text(timer_string)
