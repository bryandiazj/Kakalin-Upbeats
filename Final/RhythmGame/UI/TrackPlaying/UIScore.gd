extends Label

var _total_score := 0

var final_score = 0


func _ready() -> void:
	Events.connect("scored", self, "_add_score")
	#SilentWolf.Scores.wipe_leaderboard("Cephalopod")
	#SilentWolf.Scores.wipe_leaderboard("Die_Prinzen")
	#SilentWolf.Scores.wipe_leaderboard("Disco_Lounge")
	#SilentWolf.Scores.wipe_leaderboard("Rebel_Yell")
	#SilentWolf.Scores.wipe_leaderboard("Secret_of_Life")
	#SilentWolf.Scores.wipe_leaderboard("Werq")


func _add_score(msg: Dictionary) -> void:
	_total_score += msg.score
	text = str(_total_score)
	
	if _total_score > final_score:
		final_score = _total_score
	else:
		return
		
func _exit_tree():
	if Global.save_track.name == "Disco Lounge":
		Global.save_track.name = "Disco_Lounge"
	if Global.save_track.name == "Secret of Life":
		Global.save_track.name = "Secret_of_Life"
	if Global.save_track.name == "Rebel Yell":
		Global.save_track.name = "Rebel_Yell"
	if Global.save_track.name == "Die Prinzen":
		Global.save_track.name = "Die_Prinzen"
	SilentWolf.Scores.persist_score(Global.store_username, final_score, Global.save_track.name)

	
