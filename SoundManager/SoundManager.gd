extends Node

onready var soundEffectScene = preload("res://SoundManager/SoundEffect.tscn")

func playSound(soundPath: String):
	var sound = soundEffectScene.instance()
	sound.stream = load(soundPath)
	if sound.stream == null:
		print("sound failed to load")
		return
	
	add_child(sound)
	sound.play()
