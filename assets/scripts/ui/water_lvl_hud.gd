extends Label


func _process(_delta: float) -> void:
	var water_lvl_string = var_to_str(int(Global.water_lvl))
	%WaterLevelHUD.set_text(water_lvl_string)
