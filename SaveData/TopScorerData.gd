extends Node

var score_file = File.new()
var PATH = "res://SaveData/TopScore.json"
var list = {}


func write_score(scores : Dictionary, file_path: String) :
	score_file.open(file_path, File.WRITE)
	score_file.seek_end()
	score_file.store_line(str(JSON.print(scores)))
	score_file.close()

func read_score(file_path : String) -> Dictionary:
	var scores = { "Name": "AAA", "Score": 0}
	if score_file.file_exists(file_path):
		score_file.open(file_path, File.READ)
		var score_text = str(score_file.get_as_text().strip_edges())
		scores = JSON.parse(score_text).result
		score_file.close()
	return scores

func add_score(name : String, score : int):
	var rankList = read_score(PATH)
	var newRank = { "Name": name, "Score": score }
	rankList[rankList.size()] = newRank
	write_score(rankList, PATH)

