extends Node

var leaderboard = load("res://SaveData/TopScorerData.gd").new()
var playerName = ""
var gamesCleared = 0
var score : int


func reset():
	totalScore()
	leaderboard.add_score(playerName,score)
	playerName = ""
	gamesCleared = 0
	score = 0
	
func totalScore():
	score = GameData.totalScore + ColorBlindData.highestScore + ReactionTestData.highscore

func _exit_tree() -> void:
	leaderboard.save_to_file()
