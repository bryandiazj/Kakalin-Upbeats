extends Control


func _ready():
	visible = false

func _on_Setting_pressed():
	visible = true


func _on_Resume_pressed():
	visible = false


func _on_Leaderboard_pressed():
	yield(get_tree().create_timer(0.5,0), "timeout")
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
