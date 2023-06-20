extends Node

var leaderboard = load("res://SaveData/TopScorerData.gd").new()
var playerName = ""
var gamesCleared = 0
var score = 0

func reset():
	leaderboard.add_score(playerName,score)
	playerName = ""
	gamesCleared = 0
	score = 0

func _exit_tree() -> void:
	leaderboard.save_to_file()
