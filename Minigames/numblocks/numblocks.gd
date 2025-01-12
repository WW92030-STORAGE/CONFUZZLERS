extends Node2D

var maxval = 20
var nrounds = 10

var sequence = []
var original = [] # A copy of the original sequence for resets
var expected = 24

var selected = [0, 0, 0, 0]
var solved = false

func testSequence(v, target):
	if len(v) == 1:
		return v[0] == 24
	
	for i in range(len(v)):
		for j in range(i):
			var x = v[i]
			var y = v[j]
			
			var dz = [x + y, abs(x - y), x * y]
			if (y != 0 && x % y == 0):
				dz.append(x / y)
			if (x != 0 && y % x == 0):
				dz.append(y / x)
			
			var v2 = []
			for k in range(len(v)):
				if (k == i || k == j):
					continue
				v2.append(v[k])
			
			for k in range(len(dz)):
				v2.push_back(dz[k])
				if (testSequence(v2, target)):
					return true
				v2.pop_back()
			

func generateSequence(): # Generates a 4-vector containing the numbers for this round
	expected = 24 + 12 * randi_range(0, 1)
	var seq = [1, 1, 1, expected]
	for i in range(4096):
		seq[0] = randi_range(0, maxval)
		seq[1] = randi_range(0, maxval)
		seq[2] = randi_range(0, maxval)
		seq[3] = randi_range(0, maxval)
		if (testSequence(seq, expected)):
			break
	
	GlobalVariables.time0 = Time.get_ticks_msec()
	return seq

func clone(seq):
	var res = []
	for i in seq:
		res.append(i)
	return res
	
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.scoreDenom = 0
	GlobalVariables.score = 0
	GlobalVariables.mu = 0
	GlobalVariables.nsize = 0
	
	var seq = generateSequence()
	sequence = clone(seq)
	original = clone(seq)
	print(seq)

func render():
	$Label.text = str(expected)
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	
	if (selected[0]):
		$VBoxContainer/PanelContainer/Label.text = "> " + str(sequence[0])
	else:
		$VBoxContainer/PanelContainer/Label.text = str(sequence[0])
	
	if (len(sequence) > 1):
		if (selected[1]):
			$VBoxContainer/PanelContainer2/Label.text = "> " + str(sequence[1])
		else:
			$VBoxContainer/PanelContainer2/Label.text = str(sequence[1])
	else:
		$VBoxContainer/PanelContainer2/Label.text = "-"
	if (len(sequence) > 2):
		if (selected[2]):
			$VBoxContainer/PanelContainer3/Label.text = "> " + str(sequence[2])
		else:
			$VBoxContainer/PanelContainer3/Label.text = str(sequence[2])
	else:
		$VBoxContainer/PanelContainer3/Label.text = "-"
	if (len(sequence) > 3):
		if (selected[3]):
			$VBoxContainer/PanelContainer4/Label.text = "> " + str(sequence[3])
		else:
			$VBoxContainer/PanelContainer4/Label.text = str(sequence[3])
	else:
		$VBoxContainer/PanelContainer4/Label.text = "-"

func play():
	render()
	if (solved):
		var elapsed = Time.get_ticks_msec() - GlobalVariables.time0
		$Time.text = str(elapsed)
		GlobalVariables.mu = (elapsed + GlobalVariables.mu * GlobalVariables.nsize) / (GlobalVariables.nsize + 1)
		$AvgTime.text = str(GlobalVariables.mu)
		print("SOLVED!!!")
		GlobalVariables.score += 1
		GlobalVariables.scoreDenom += 1
		GlobalVariables.nsize += 1
		selected = [0, 0, 0, 0]
			
		var seq = generateSequence()
		sequence = clone(seq)
		original = clone(seq)
		solved = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GlobalVariables.scoreDenom >= nrounds):
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	play()
	pass


func _on_texture_button_1_pressed():
	if (len(sequence) < 1):
		return
	print("TEXTURE BUTTON 1 PRESSED")
	selected[0] = 1 - selected[0]
	print(selected)
func _on_texture_button_2_pressed():
	if (len(sequence) < 2):
		return
	print("TEXTURE BUTTON 2 PRESSED")
	selected[1] = 1 - selected[1]
	print(selected)
func _on_texture_button_3_pressed():
	if (len(sequence) < 3):
		return
	print("TEXTURE BUTTON 3 PRESSED")
	selected[2] = 1 - selected[2]
	print(selected)
func _on_texture_button_4_pressed():
	if (len(sequence) < 4):
		return
	print("TEXTURE BUTTON 4 PRESSED")
	selected[3] = 1 - selected[3]
	print(selected)

func xprocess(c):
	var numselected = 0
	for i in selected:
		numselected += i
	if (numselected != 2):
		print("ERROR BAD SELECTION")
		return
		
	var sel = []
	for i in range(len(selected)):
		if (selected[i]):
			sel.append(i)
			
	var s1 = sel[0]
	var s2 = sel[1]
	var n1 = sequence[s1]
	var n2 = sequence[s2]
	
	print("CONCATENATING NUMBERS " + str(sequence[s1]) + " " + str(sequence[s2]))
	print("INDICES " + str(s1) + " " + str(s2))
	
	selected = [0, 0, 0, 0]
	
	var result = null
	if (c == '+'):
		result = n1 + n2
	if (c == '-'):
		result = abs(n1 - n2)
	if (c == '*'):
		result = n1 * n2
	if (c == '/'):
		if (n2 != 0 && n1 % n2 == 0):
			result = n1 / n2
		elif (n1 != 0 && n2 % n1 == 0):
			result = n2 / n1
		else:
			return
	
	if (result == null):
		return
		
	sequence.erase(n1)
	sequence.erase(n2)
	sequence.append(result)
	
	
	if (len(sequence) == 1):
		print("EVALUATING...")
		print(original)
		if (sequence[0] == expected):
			solved = true
			return
		else:
			sequence = clone(original)
			selected = [0, 0, 0, 0]
			render()
			return
			

func _on_button_plus_pressed():
	xprocess('+')


func _on_button_minus_pressed():
	xprocess('-')


func _on_button_times_pressed():
	xprocess('*')


func _on_button_divide_pressed():
	xprocess('/')


func _on_button_skip_pressed():
	var elapsed = Time.get_ticks_msec() - GlobalVariables.time0
	$Time.text = str(elapsed)
	GlobalVariables.mu = (elapsed + GlobalVariables.mu * GlobalVariables.scoreDenom) / (GlobalVariables.scoreDenom + 1)
	$AvgTime.text = str(GlobalVariables.mu)
	selected = [0, 0, 0, 0]
	var seq = generateSequence()
	sequence = clone(seq)
	original = clone(seq)
	render()
	solved = false
	GlobalVariables.scoreDenom += 1
	return
