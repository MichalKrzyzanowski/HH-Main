extends Control
#####################################
#			Varibable				#
#####################################
var faction : String
var slot : int

#####################################
#		Public Functions			#
#####################################
func _input(event):
	if event is InputEventMouseButton:
		for i in GameData.pingNodes.size():
			if GameData.pingNodes[i].isFound:
				setData(GameData.pingNodes[i].planeData, i)
				self.visible = true

func setData(data : GameData.PlaneData, index : int):
	$ImageCenterContainer/PlaneSprite.texture = data.planeTexture
	$ImageCenterContainer/PlaneSprite/AircraftName.text = data.aircraftName
	faction = data.faction
	slot = index
	print(index)

func delete():
	var temp1 = GameData.pingNodes[slot]
	var temp2 = GameData.planeNodes[slot]
	GameData.pingNodes.remove(slot)
	GameData.planeNodes.remove(slot)
	GameData.planeDataArray.remove(slot)
	temp1.queue_free()
	temp2.queue_free()
	self.visible = false

#####################################
#		Signal Functions			#
#####################################
func _on_FriendlyButton_pressed():
	if faction == "allied":
		GameData.currentScore += 1
	delete()

func _on_EnemyButton_pressed():
	if faction == "axis":
		GameData.currentScore += 1
	delete()


