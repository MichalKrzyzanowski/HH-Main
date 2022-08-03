extends CPUParticles2D



func _on_Timer_timeout() -> void:
	get_tree().queue_delete(self)
