extends Node2D

var maxval = 20
var nrounds = 20

var sequence = []
var original = [] # A copy of the original sequence for resets
var expected = 0

var options = [0, 0, 0, 0]
var rightanswer = 0
var chosen = -1
var solved = false

var LEN = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.scoreDenom = -1
	GlobalVariables.score = -1
	GlobalVariables.mu = 0
	GlobalVariables.nsize = -1
	solved = true
	
func rand_digits():
	var blip = str(randi_range(0, pow(10, LEN) - 1))
	while len(blip) < LEN:
		blip = "0" + blip
	return blip

func alter(s):
	var n = len(s)
	var nd = randi_range(1, min(3, n))
	
	var hi = {}
	
	while (len(hi) < nd):
		hi[randi_range(0, n - 1)] = 0
	
	for key in hi:
		var value = int(s[key])
		while (value == int(s[key])):
			value = randi_range(0, 9)
		s[key] = str(value)
	return s

func render():
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	$Label.text = str(expected)
	$VBoxContainer/PanelContainer/Label.text = str(options[0])
	$VBoxContainer/PanelContainer2/Label.text = str(options[1])
	$VBoxContainer/PanelContainer3/Label.text = str(options[2])
	$VBoxContainer/PanelContainer4/Label.text = str(options[3])

func play():
	render()
	if (solved):
		var elapsed = Time.get_ticks_msec() - GlobalVariables.time0
		GlobalVariables.time0 = Time.get_ticks_msec()
		$Time.text = str(elapsed)
		if (GlobalVariables.nsize > 0):
			GlobalVariables.mu = (elapsed + GlobalVariables.mu * GlobalVariables.nsize) / (GlobalVariables.nsize + 1)
		$AvgTime.text = str(GlobalVariables.mu)
		print("SOLVED!!!")
		if (chosen == rightanswer):
			GlobalVariables.score += 1
		GlobalVariables.scoreDenom += 1
		GlobalVariables.nsize += 1
		
		expected = rand_digits()
		rightanswer = randi_range(0, 3)
		options = [expected, expected, expected, expected]
		
		for i in range(4):
			if (i == rightanswer):
				continue
			options[i] = alter(options[i])
			
			print(expected)
			
		
		solved = false
		
		chosen = -1
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GlobalVariables.scoreDenom >= nrounds):
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	play()


func _on_texture_button_4_pressed():
	solved = true
	chosen = 3
func _on_texture_button_3_pressed():
	solved = true
	chosen = 2
func _on_texture_button_2_pressed():
	solved = true
	chosen = 1
func _on_texture_button_1_pressed():
	solved = true
	chosen = 0
