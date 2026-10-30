extends RigidBody3D

func _ready() -> void:
	gravity_scale = 0


func _on_pickup_area_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		Global.current_score += Global.small_coin
		%CollectSound.play()
		$CollisionShape3D.queue_free()
		await get_tree().create_timer(1).timeout
		self.queue_free()
