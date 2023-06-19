extends Node

var score_file = File.new()
var PATH = "res://SaveData/TopScore.json"
var scores_max := 10
var rankList := Dictionary()

class RankEntry:
	var key : String
	var Name: String
	var Score: int

func compareScores(a, b):
	return a.Score > b.Score

func write_score(scores: Dictionary, file_path: String):
	score_file.open(file_path, File.WRITE)
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

func get_lowest_score(dict: Dictionary):
	var lowest_key = "0"
	var lowest_score = dict["0"]["Score"]
	for key in dict.keys():
		if dict[key]["Score"] < lowest_score:
			lowest_key = key
	return lowest_key

func add_score(name : String, score : int):
	var newKey = rankList.size() # Use the current size as the new key

	# update the new key with lowest score key if array is filled up
	if rankList.size() >= scores_max:
		var lowest_key = get_lowest_score(rankList)
		prints(lowest_key, rankList[lowest_key]["Score"])
		if score > rankList[lowest_key]["Score"]:
			newKey = lowest_key
		else: return

	var newRank = { "Name": name, "Score": score }
	rankList[str(newKey)] = newRank
	rankList = sort_scores(rankList) # Sort the scores

func get_rank_list():
	print("getting rank list...")
	if !rankList.empty(): return rankList

	rankList = read_score(PATH)
	return rankList

func save_to_file():
	print("saving scoreboard...")
	write_score(rankList, PATH)
