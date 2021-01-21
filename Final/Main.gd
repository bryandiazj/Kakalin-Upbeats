extends Control



func _on_RegisterButton_pressed() -> void:
	Global.reg = true
	#get_tree().change_scene("res://interface/register/Register.tscn")


func _on_LoginButton_pressed() -> void:
	Global.login = true
	#get_tree().change_scene("res://interface/login/Login.tscn")

