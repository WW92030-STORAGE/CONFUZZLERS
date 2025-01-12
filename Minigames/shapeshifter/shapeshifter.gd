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
var isvisible = false
var pressed = false

var shape = 0
var side = 0

func _ready():
	view = get_viewport().get_visible_rect().size
	GlobalVariables.score = 0
	GlobalVariables.scoreDenom = 0
	print("STARTING SHAPESHIFTER")
	GlobalVariables.time0 = Time.get_ticks_msec() # Starting time used for the timer
	GlobalVariables.mu = 0
	GlobalVariables.nsize = 0
	
	prevtime = Time.get_ticks_msec()
	intervalL = 500
	intervalH = 4000
	interval = randi_range(2000, 3000)
	
	$LEFT.set_texture(load("res://Minigames/shapeshifter/blank.png"))
	$RIGHT.set_texture(load("res://Minigames/shapeshifter/blank.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.set_value(256 * (Time.get_ticks_msec() - GlobalVariables.time0) / msecs)
	if (Time.get_ticks_msec() - GlobalVariables.time0 >= msecs):
		GlobalVariables.scoreDenom -= len(GlobalVariables.set0.keys())
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if (direction != 0): # -1 SQUARE +1 CIRCLE
		if (!pressed):
			pressed = true
			GlobalVariables.scoreDenom += 1
			if (isvisible):
				var elapsed = Time.get_ticks_msec() - GlobalVariables.time1
				GlobalVariables.mu = (GlobalVariables.mu * GlobalVariables.nsize + elapsed) / (GlobalVariables.nsize + 1)
				GlobalVariables.nsize += 1
				
				if ((direction > 0) == (shape == false)):
					GlobalVariables.score += 1
				
				isvisible = false
				prevtime = Time.get_ticks_msec()
				interval = randi_range(intervalL, intervalH)
				$LEFT.set_texture(load("res://Minigames/shapeshifter/blank.png"))
				$RIGHT.set_texture(load("res://Minigames/shapeshifter/blank.png"))
			
	else:
		pressed = false
	
	if (Time.get_ticks_msec() - prevtime >= interval && !isvisible):
		isvisible = true
		shape = randf_range(0, 1) > 0.5 # 1 = SQUARE
		side = randf_range(0, 1) > 0.5
		
		GlobalVariables.time1 = Time.get_ticks_msec() # Time used for reaction time calculations
		if (side):
			if (shape):
				$LEFT.set_texture(load("res://Minigames/shapeshifter/SQUARE.png"))
			else:
				$LEFT.set_texture(load("res://Minigames/shapeshifter/CIRCLE.png"))
		else:
			if (shape):
				$RIGHT.set_texture(load("res://Minigames/shapeshifter/SQUARE.png"))
			else:
				$RIGHT.set_texture(load("res://Minigames/shapeshifter/CIRCLE.png"))
		
