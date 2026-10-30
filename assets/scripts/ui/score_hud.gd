extends Label


func _process(delta: float) -> void:
	var score_string = var_to_str(int(Global.current_score))
	%ScoreHUD.set_text(score_string)
