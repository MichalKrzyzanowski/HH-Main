extends Node

var score_file = File.new()
var PATH = "res://SaveData/TopScore.json"

class RankEntry:
	var key : String
	var Name: String
	var Score: int

func compareScores(a, b):
	return a.Score - b.Score

func write_score(scores: Dictionary, file_path: String):
	score_file.open(file_path, File.WRITE)
	score_file.seek_end()
	score_file.store_line(str(JSON.print(scores)))
	score_file.close()

func read_score(file_path: String) -> Dictionary:
	var scores = {}
	if score_file.file_exists(file_path):
		score_file.open(file_path, File.READ)
		var score_text = str(score_file.get_as_text().strip_edges())
		scores = JSON.parse(score_text).result
		score_file.close()
		scores = sort_scores(scores) # Sort the scores
	return scores

func sort_scores(scores: Dictionary) -> Dictionary:
	var rankArray = []
	for key in scores.keys():
		var entry = RankEntry.new()
		entry.key = str(key)
		entry.Name = scores[key].Name
		entry.Score = scores[key].Score
		rankArray.append(entry)
	rankArray.sort_custom(self, "compareScores") # Sort by score
	var sortedRankList = {}
	for i in range(rankArray.size()):
		sortedRankList[str(i)] = {
			"Name": rankArray[i].Name,
			"Score": rankArray[i].Score
		}
	return sortedRankList

func add_score(name : String, score : int):
	var rankList = read_score(PATH)
	var newKey = rankList.size() # Use the current size as the new key
	var newRank = { "Name": name, "Score": score }
	rankList[str(newKey)] = newRank
	rankList = sort_scores(rankList) # Sort the scores
	write_score(rankList, PATH)

func _ready():
	var rankList = read_score(PATH)
	write_score(rankList, PATH)
