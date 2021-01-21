extends Control

func _ready():
	visible = false

func _on_PauseButton_pressed():
	get_tree().paused = true
	visible = true
	
func _on_Resume_pressed():
	get_tree().paused = false
	visible = false

func _on_Quite_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Restart_pressed():
	if Global.save_track.name == "Disco_Lounge":
		Global.save_track.name = "Disco Lounge"
	if Global.save_track.name == "Secret_of_Life":
		Global.save_track.name = "Secret of Life"
	if Global.save_track.name == "Rebel_Yell":
		Global.save_track.name = "Rebel Yell"
	if Global.save_track.name == "Die_Prinzen":
		Global.save_track.name = "Die Prinzen"
	get_tree().reload_current_scene()
	get_tree().paused = false
	Global.tak = true



func _on_LeaderBoard_pressed():
	get_tree().paused = false
	yield(get_tree().create_timer(0.5,0), "timeout")
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
