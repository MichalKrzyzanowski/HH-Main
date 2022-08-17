extends Node

var random = RandomNumberGenerator.new()
#####################################
#			Variables				#
#####################################
#change the value if you want to test the scene
var enemyAmount : float
var current_rotation : float
var enemyArray : Array
#change this prefab to its actual plane model
var enemyscene = load("res://RadarGame/Prefabs/Plane.tscn")
var planeNodes : Array
var pingNodes : Array
var gameEnd : bool

enum Levels {Easy,Normal,Hard}

#The game stats for the main menu
var currentScore : int = 0
var currentTime : float
var currentLevel : int
var currentAccuracy : float
# past game
var prevoiusScore : int
var prevoiusTime : float
var prevoiusLevel : int = -1
var prevoiusAccuracy : float

#####################################
#			Class Data				#
#####################################
class PlaneData:
	var planeID : int
	var planeType : int
	var faction : String
	var aircraftName : String
	var planeTexture : Texture
	var planePosition : Vector3

#####################################
#		Public Functions			#
#####################################

func _startSpawn():
	for _i in range(0,enemyAmount):
		var plane = PlaneData.new()
		random.randomize()
		plane.planeType = random.randi_range(0,5)
		_setData(plane)
		var enemy = enemyscene.instance()
		var new_pos = Vector3(random.randf_range(-200,200),random.randf_range(80,200),random.randf_range(-200,200))
		enemy.transform.origin = new_pos
		add_child(enemy)
		plane.planePosition = new_pos
		plane.planeID = _i
		enemyArray.append(plane)

func _setData(_plane : PlaneData):
	match _plane.planeType:
		0:
			_plane.aircraftName = "F6F Hellcat"
			_plane.faction = "allied"
			_plane.planeTexture = load("res://RadarGame/Sprites/Allied/f6f hellcat.png")
			#TODO add meshloder here
		1:
			_plane.aircraftName = "P-38 Lightning"
			_plane.faction = "allied"
			_plane.planeTexture = load("res://RadarGame/Sprites/Allied/p-38 lightning.png")
			#TODO add meshloder here
		2:
			_plane.aircraftName = "B-17 Flying Fortress"
			_plane.faction = "allied";
			_plane.planeTexture = load("res://RadarGame/Sprites/Allied/b-17 flying fortress.png")
			#TODO add meshloder here
		3:
			_plane.aircraftName = "Messerschmit 'ME. 110'"
			_plane.faction = "axis"
			_plane.planeTexture = load("res://RadarGame/Sprites/Axis/messerschmitt.png")
			#TODO add meshloder here
		4:
			_plane.aircraftName = "Heinkel 'HE.111'"
			_plane.faction = "axis";
			_plane.planeTexture = load("res://RadarGame/Sprites/Axis/heinkel.png")
			#TODO add meshloder here
		5:
			_plane.aircraftName = "Focke-wulf 'F.W.200'"
			_plane.faction = "axis"
			_plane.planeTexture = load("res://RadarGame/Sprites/Axis/fock-wulf.png")
			#TODO add meshloder here

func gameReset():
	currentScore = 0
	currentTime = 0
	currentLevel = 0
	currentAccuracy = 0

func fullReset():
	prevoiusScore = 0
	prevoiusTime = 0
	prevoiusAccuracy = 0
	prevoiusLevel = 0
	gameEnd = false
