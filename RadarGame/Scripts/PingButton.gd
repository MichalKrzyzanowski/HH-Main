extends Node2D

#####################################
#			Variables				#
#####################################
var planeData : GameData.PlaneData
var isFound : bool = false
onready var button = $Area2D/Sprite/TextureButton

#####################################
#		Public Functions			#
####################################
func _ready():
	self.modulate.a = 0

func _process(delta):
	self.modulate.a -= 0.025

#####################################
#			Signals					#
#####################################
func _on_radarline_entered(area):
	self.modulate.a = 1

func _on_TextureButton_pressed():
	isFound = true

#####################################
#		Getter Functions			#
#####################################

