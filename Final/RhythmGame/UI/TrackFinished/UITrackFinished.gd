extends Control

onready var _animation_player := $AnimationPlayer


func _ready() -> void:
	Events.connect("track_finished", self, "_fade_in")


func _fade_in(_msg: Dictionary) -> void:
	_animation_player.play("show")


func _on_ButtonBack_pressed():
	#get_tree().reload_current_scene()
	yield(get_tree().create_timer(0.5,0), "timeout")
	get_tree().change_scene("res://addons/silent_wolf/Scores/Leaderboard.tscn")
