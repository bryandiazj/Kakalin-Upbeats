extends Control

func _ready():
	visible = false

func _on_Volume_pressed():
	visible = true

func _on_Back_pressed():
	visible = false



func _on_Volume_ScrollBar_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
