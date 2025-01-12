extends Node2D

var COLS = 8
var BLS = 2 # one less than teh starting amount

var MAX_BLS = 6
var MAX_PER_S = 4

var nrounds = 5

var solved = true

func randomOptions(n, k):
	if k > n:
		k = n
	var res = []
	var cnt = 0
	while cnt < 1024 && len(res) < k:
		cnt += 1
		var thing = randi_range(0, n - 1)
		if not thing in res:
			res.append(thing)
			
	if len(res) >= k:
		res.sort()
		return res
		
	for i in range(k):
		if (i not in res) and (len(res) < k):
			res.append(i)
			
	res.sort()
	return res

func randomConfig(n, k):
	var cols = randomOptions(n, k)
	var pos = []
	var cnt = 1024
	
	for ii in range(cnt):
		pos = []
		var f = [0, 0, 0]
		for i in range(k):
			var num = randi_range(0, 2)
			f[num] += 1
			pos.append(num)
		
		var valid = true
		for i in f:
			if i > MAX_PER_S:
				valid = false
		if valid:
			return [cols, pos]
	
	pos = []
	for i in range(k):
		pos.append(i % 3)
		
	return [cols, pos]
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.scoreDenom = 0
	GlobalVariables.score = 0
	GlobalVariables.mu = 0
	GlobalVariables.nsize = 0
	solved = true

func _render():
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	$VBoxContainer/Score.text = str(GlobalVariables.score)
	$VBoxContainer/Moves.text = str($Blocks.moves)
	$VBoxContainer/Total.text = str(GlobalVariables.mu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_render()
	if solved:
		if BLS < MAX_BLS:
			BLS += 1
		solved = false
		var ss = randomConfig(COLS, BLS)
		$Blocks.init(ss[0], ss[1])
		$Blocks2.init(ss[0], ss[1])
		
		for i in range(randi_range(1, 64)):
			var a = randi_range(0, 2)
			var d = 1 - 2 * randi_range(0, 1)
			# print(a, d)
			$Blocks2.move(a, (a + d + 600) % 3)
		
		for d in range(2):
			for a in range(3):
				if test():
					return
				$Blocks2.move(a, (a + 600 + (1 - 2 * d)) % 3)
		
		$Blocks.disp()
		$Blocks2.disp()
		
		return
	
	var done = test()
	if (done):
		GlobalVariables.mu += $Blocks.moves
		GlobalVariables.score += 1
		GlobalVariables.scoreDenom += 1
		GlobalVariables.nsize += 1
		solved = true
	
	if GlobalVariables.scoreDenom >= nrounds:
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	
@onready var Blocks1 = $Blocks
@onready var Blocks2 = $Blocks2

func test():
	for s in range(3):
		var s1 = Blocks1.S[s].get_children()
		var s2 = Blocks2.S[s].get_children()
		
		if len(s1) != len(s2):
			return false
		
		for i in range(len(s1)):
			
			if (s1[i].name != s2[i].name):
				return false
		
	return true
		
		


func _on_skip_pressed() -> void:
	GlobalVariables.scoreDenom += 1
	solved = true
