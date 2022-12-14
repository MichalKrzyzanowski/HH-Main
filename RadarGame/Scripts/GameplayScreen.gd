extends Control

#####################################
#			Variables				#
#####################################
onready var bino = $Pivot
onready var radar = $Pivot/Radar
onready var cheatSheet = $Pivot/HandbookButton/CheatSheet
onready var handbookButton = $Pivot/HandbookButton

#####################################
#		Public Functions			#
#####################################
func _ready():
	bino.visible = true
	cheatSheet.visible = false
	handbookButton.visible = true
	GameData.pingNodes = get_tree().get_nodes_in_group("PingNodes")
	GameData.planeNodes = get_tree().get_nodes_in_group("PlaneNodes")

func _input(event: InputEvent):
	GlobalTimer.reset()

func _process(delta):
	GameData.currentTime += delta
	$Pivot/Control/Score.text = "Score: " + str(GameData.currentScore)
	if GameData.planeNodes.size() == 0 || GameData.pingNodes.size() == 0:
		get_tree().root.get_node("Root").queue_free()
		get_tree().change_scene("res://RadarGame/Scenes/EndScene.tscn")

func _physics_process(delta):
	for _i in GameData.planeDataArray.size():
		GameData.pingNodes[_i].position.x = GameData.planeNodes[_i].get_child(0).get_child(0).global_transform.origin.x
		GameData.pingNodes[_i].position.y = GameData.planeNodes[_i].get_child(0).get_child(0).global_transform.origin.z

#####################################
#		Signal Functions			#
#####################################
func _on_HandbookButton_button_down():
	cheatSheet.visible = !cheatSheet.visible

func _on_QuitButton_pressed():
	GameData.gameReset()
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://RadarGame/Scenes/MainMenu.tscn")
