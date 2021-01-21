extends Control

var tak = false

func _ready():
	visible = false

func _on_Back_pressed():
	visible = false

func _on_Music_pressed():
	visible = true


func _on_Mute_pressed():
	tak = not tak
	if tak == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		$Music_Panel/Mute/Mute_tag.text = "Unmute"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		$Music_Panel/Mute/Mute_tag.text = "Mute"
	


func _on_HScrollBar_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
