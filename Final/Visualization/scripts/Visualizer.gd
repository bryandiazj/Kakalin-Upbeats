extends Node2D

const VU_COUNT = 128
const FREQ_MAX = 10000.0 # 21050.0

const MAX_HEIGHT = 256
const MAX_RADIUS_SMALL = 16

const MIN_DB = 100

var prev_energy = []
var prev_small_radius = 0

var spectrum

var rng = RandomNumberGenerator.new()

func _draw():
	#warning-ignore:integer_division
	# calculating angle between points in major circle
	var angle = (2 * PI) / VU_COUNT
	var prev_hz = 0
	var magnitude_full_db = spectrum.get_magnitude_for_frequency_range(0, 15000).length()
	var energy_volume = clamp((MIN_DB + linear2db(magnitude_full_db)) / MIN_DB, 0, 1)
	rotation_degrees = $Player.get_playback_position() * 5
	
	var small_radius = (MAX_RADIUS_SMALL/2.0) *  (8 * energy_volume)
	if small_radius < prev_small_radius:
		 small_radius = prev_small_radius - 0.2
		
	prev_small_radius = small_radius
	
	for i in range(VU_COUNT):	
		# calculating height of sample
		var hz = (i + 1) * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
		if energy < prev_energy[i]:
			energy = prev_energy[i] - 0.01
		prev_energy[i] = energy
		# energy is in percent from 0 -> 1.0
		
		# drawing samples
		var vec = Vector2(sin(i * angle), -cos(i * angle))
		var pos_start = vec * small_radius
		var pos_end = vec * (small_radius + energy * MAX_HEIGHT)

		# draw_line(pos_start, pos_end, $ColorScripts.get_color_gray((i * 1.0) / VU_COUNT), 5, true)
		draw_line(pos_start, pos_end, Color.blue, 3, true)
		# draw_rect(Rect2(w * (i - 1), HEIGHT - height, w, height), Color.white)
		prev_hz = hz


func _process(_delta):
	update()
	
	if $Player.playing == false:
		$Player.play()

	# print(str(Engine.get_frames_per_second()))


func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(1, 5)
	prev_energy.resize(VU_COUNT)
	for i in range(prev_energy.size()):
		prev_energy[i] = 0
		
	spectrum = AudioServer.get_bus_effect_instance(0,0)
	self.position = Vector2(960,540)

	
	if my_random_number == 1:
		$Player.set_stream($Music_1.get_stream())
	elif my_random_number == 2:
		$Player.set_stream($Music_2.get_stream())
	elif my_random_number == 3:
		$Player.set_stream($Music_3.get_stream())
	elif my_random_number == 4:
		$Player.set_stream($Music_4.get_stream())
	else:
		$Player.set_stream($Music_5.get_stream())

