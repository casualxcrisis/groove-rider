extends Label


func _process(_delta: float) -> void:
	var fire_score_string = var_to_str(int(Global.fire_score))
	%FireScoreHUD.set_text(fire_score_string)
