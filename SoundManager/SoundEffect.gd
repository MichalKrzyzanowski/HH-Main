extends AudioStreamPlayer



func _on_SoundEffect_finished() -> void:
	queue_free()
