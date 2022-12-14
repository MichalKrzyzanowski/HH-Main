extends Node2D
#####################################
#			Variables			#
#####################################
var pingPrefab = load("res://RadarGame/Prefabs/PingScene.tscn")

#####################################
#		Public Functions			#
#####################################
func _ready():
	for _i in range(0,GameData.planeDataArray.size()):
		var pingInstance = pingPrefab.instance()
		pingInstance.position = Vector2(GameData.planeDataArray[_i].planePosition.x,GameData.planeDataArray[_i].planePosition.z)
		pingInstance.planeData = GameData.planeDataArray[_i]
		add_child(pingInstance)