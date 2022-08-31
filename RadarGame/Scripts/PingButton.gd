extends Node2D

#####################################
#			Variables				#
#####################################
var planeData : GameData.PlaneData
var isFound : bool = false

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


#####################################
#		Getter Functions			#
#####################################

