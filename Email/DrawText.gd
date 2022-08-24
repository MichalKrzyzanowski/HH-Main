extends Control

var font = load("res://MainMenu/Font/CertFont.tres")
var text := "Test"

func _draw():
	draw_string(font, Vector2(827, 754), str(PlayerData.playerName))