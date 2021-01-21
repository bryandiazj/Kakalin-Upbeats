extends Control

var tak = false

func _ready():
	visible = false

func _on_Setting_pressed():
	visible = true

func _on_Back_pressed():
	visible = false

func _on_Mute_pressed():
	tak = not tak
	if tak == true:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		$Setting_Panel/Mute/Mute_text.text = "Unmute"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		$Setting_Panel/Mute/Mute_text.text = "Mute"
