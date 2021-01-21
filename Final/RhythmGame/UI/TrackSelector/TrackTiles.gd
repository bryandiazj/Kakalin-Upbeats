extends Node2D

export var scale_radius := 1000
export var separation := 450
export (Array, Resource) var tracks: Array
export var track_tile_scene: PackedScene

var _selected_track_tile = null
var _track_tiles := []
var _bound := {"left": 0, "right": 0}

onready var _align_timer := $AlignTimer
onready var _tween := $Tween


func _ready() -> void:
	for track in tracks:
		var track_tile = track_tile_scene.instance()
		track_tile.info = track
		_track_tiles.append(track_tile)
		add_child(track_tile)

	var current_separation = 0.0

	for track in _track_tiles:
		track.position = Vector2(current_separation, 0)
		current_separation += separation

	_update_tile_visuals()

	_bound.right = -(separation * (_track_tiles.size() - 1))


func _input(event) -> void:
	if event.is_action_released("touch"):
		_align_timer.start()
		yield(_align_timer, "timeout")
		_snap_to_track(_selected_track_tile)


func _process(_delta) -> void:
	if _tween.is_active():
		_update_tile_visuals()


func _snap_to_track(track_tile) -> void:
	var relative_position = track_tile.global_position.x - get_parent().global_position.x

	_tween.interpolate_property(
		self,
		"position",
		position,
		position + Vector2(-relative_position, 0),
		0.5,
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	_tween.start()


func scroll(amount: Vector2) -> void:
	_tween.stop_all()
	position.x = clamp(position.x + amount.x, _bound.right, _bound.left)
	_update_tile_visuals()
	_align_timer.start()


func _update_tile_visuals() -> void:
	var distance_scale
	var distance_fade
	for tile in _track_tiles:
		var distance_normalized = range_lerp(
			abs(tile.global_position.x - get_parent().global_position.x),
			0,
			get_parent().global_position.x,
			0,
			1
		)

		distance_scale = 1.0 - distance_normalized
		tile.scale = Vector2.ONE * distance_scale

		distance_fade = distance_normalized
		tile.modulate.a = (1 - pow(distance_fade, 3))


func _on_track_selected(track_tile) -> void:
	_selected_track_tile = track_tile
