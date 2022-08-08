extends Popup

func _process(delta: float) -> void:
	if GlobalTimer.thresholdReached():
		show()
		# get_tree().paused = true
	else:
		hide()

	if visible:
		$Body.text = "You will return to the splash\nmenu in " + str(GlobalTimer.getRemainingTime() as int) + "s\n\n" + \
		"Tap the screen to cancel"

	if GlobalTimer.kickTimeReached():
		get_tree().paused = false
		get_tree().root.get_node("Root").queue_free()
		get_tree().change_scene("res://MainMenu/Scenes/SplashScene.tscn")
		ColorBlindData.reset()
		PlayerData.reset()
		ReactionTestData.reset()
