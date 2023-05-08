extends Node

var score_file = File.new()
var PATH = "res://SaveData/TopScorerData.gd"


func write_score(scores : Dictionary, file_path: String):
    score_file.open(file_path, File.WRITE)
    score_file.store_string(JSON.print(scores))
    score_file.close()

func read_score(file_path : String) -> Dictionary:
    var scores = {}
    if score_file.file_exists(file_path):
        score_file.open(file_path, File.READ)
        scores = JSON.parse(score_file.get_string().strip_edges())
        score_file.close()
    return scores

func add_score(name : String, score : int):
    var scores = read_score(PATH)
    scores[name] = score
    write_score(scores, PATH)