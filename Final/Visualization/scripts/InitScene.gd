extends Node2D

var bip_length = 60 / 132.0
var first_timer = true

export(PackedScene) var circle_scene 

onready var scene_1 = preload("res://Main.tscn")
onready var scene_2 = preload("res://interface/login/Login.tscn")
onready var scene_3 = preload("res://interface/register/Register.tscn")

onready var scene_instance_1 = scene_1.instance()
onready var scene_instance_2 = scene_2.instance()
onready var scene_instance_3 = scene_3.instance()

func _ready():
	scene_instance_1.set_size(Vector2(1920,1080))
	add_child(scene_instance_1)
	
	scene_instance_2.set_size(Vector2(1920,1080))
	add_child(scene_instance_2)
	scene_instance_2.visible = false

	scene_instance_3.set_size(Vector2(1920,1080))
	add_child(scene_instance_3)
	scene_instance_3.visible = false

func _on_CircleRadius_value_changed(value):
	$ShaderCircle.change_first_param(value)

func _on_GlowRadius_value_changed(value):
	$Shader.change_first_param(value)

func _on_GlowAmount_value_changed(value):
	$Shader.change_second_param(value)

func _on_Timer_timeout():
	var circle_run = circle_scene.instance()
	circle_run.speed = 0.05
	add_child(circle_run)
	
	if first_timer:
		$Timer.start(bip_length * 4)
		first_timer = false 
	
func _process(delta):
	if Input.is_action_just_pressed("shader_options"):
		$HudOptions.visible = !$HudOptions.visible
	
	if Input.is_action_just_pressed("music_start"):
		$Timer.start(bip_length)
		
	if Global.login == true:
		scene_instance_1.visible = false
		scene_instance_2.visible = true
		scene_instance_3.visible = false
		
	if Global.reg == true:
		scene_instance_1.visible = false
		scene_instance_2.visible = false
		scene_instance_3.visible = true




