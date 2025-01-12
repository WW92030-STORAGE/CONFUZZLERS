extends Node2D

var view = Vector2(0, 0)
var margin = 128
# Called when the node enters the scene tree for the first time.

var prevtime = 0
var intervalL = 0
var intervalH = 0
var interval = 0
var maxL = 350
var maxH = 400

var msecs = 120 * 1000

func _ready():
	view = get_viewport().get_visible_rect().size
	GlobalVariables.score = 0
	GlobalVariables.scoreDenom = 0
	print("STARTING GRILLMASTER")
	GlobalVariables.time0 = Time.get_ticks_msec()
	GlobalVariables.mu = "-"
	
	prevtime = Time.get_ticks_msec()
	intervalL = 3500
	intervalH = 4000
	interval = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.set_value(256 * (Time.get_ticks_msec() - GlobalVariables.time0) / msecs)
	if (Time.get_ticks_msec() - GlobalVariables.time0 >= msecs):
		GlobalVariables.scoreDenom -= len(GlobalVariables.set0.keys())
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	
	if (Time.get_ticks_msec() - prevtime > interval):
		prevtime = Time.get_ticks_msec()
		interval = randf_range(intervalL, intervalH)
		
		
		var protection = load("res://Minigames/grillmaster/button.tscn")
		var entity = protection.instantiate()
		
		var pos = Vector2(randf_range(margin, view.x - margin), randf_range(margin, view.y - margin))
		
		for i in range(256):
			var beep = true
			print("CHECKING " + str(pos) + " AGAINST " + str(GlobalVariables.set0.keys()))
			for obj in GlobalVariables.set0.keys():
				if obj.distance_squared_to(pos) <= 5 * 80 * 80:
					print("TOO CLOSE TO " + str(obj))
					beep = false
					break
			if (beep):
				break
			pos = Vector2(randf_range(margin, view.x - margin), randf_range(margin, view.y - margin))
		
		entity.global_position = pos
		entity.maximum = randf_range(maxL, maxH)
		get_tree().get_root().add_child(entity)
		
		if (intervalL > 250 && randf_range(0, 1) > 0.1):
			intervalL -= 250
		if (intervalH > 1500 && intervalH - 250 >= intervalL && randf_range(0, 1) > 0.1):
			intervalH -= 250
		if (maxL > 100 && randf_range(0, 1) > 0.1):
			maxL -= 50
		
		print(GlobalVariables.set0)
