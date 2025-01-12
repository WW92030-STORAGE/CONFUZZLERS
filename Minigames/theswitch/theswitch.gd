extends Node2D

var maxval = 40
var nrounds = 40

var solved = false

var nums = [1, 1]
var LArrows = "<<<<"
var RArrows = ">>>>"

var ArrowTest = false

func _ready():
	GlobalVariables.scoreDenom = -1
	GlobalVariables.score = 0
	GlobalVariables.mu = 0
	GlobalVariables.nsize = -1
	solved = true

func render():
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	$INPUT.text = "ARROWS EQUAL?" if ArrowTest else "SUM IS EVEN?"
	
	$LEFT.text = LArrows + "|" + RArrows
	$RIGHT.text = str(nums[0]) + " + " + str(nums[1])
	
	$Score.text = str(GlobalVariables.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if solved:
		solved = false
		
		GlobalVariables.scoreDenom += 1
		GlobalVariables.nsize += 1
		
		var elapsed = Time.get_ticks_msec() - GlobalVariables.time0
		GlobalVariables.time0 = Time.get_ticks_msec()
		$Time.text = str(elapsed)
		if (GlobalVariables.nsize > 0):
			GlobalVariables.mu = (elapsed + GlobalVariables.mu * GlobalVariables.nsize) / (GlobalVariables.nsize + 1)
		$AvgTime.text = str(GlobalVariables.mu)
		
		ArrowTest = (randi_range(0, 1) == 1)
		
		LArrows = ""
		RArrows = ""
		for i in range(4):
			LArrows = LArrows + ("<" if randi_range(0, 1) == 0 else ">")
			RArrows = RArrows + ("<" if randi_range(0, 1) == 0 else ">")
			
		if randi_range(0, 1) == 0:
			RArrows = LArrows
		
		
		nums[0] = randi_range(0, 9)
		nums[1] = randi_range(0, 9)
		
		GlobalVariables.time0 = Time.get_ticks_msec()
	
	if (GlobalVariables.scoreDenom >= nrounds):
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	
	render()


func _on_true_pressed() -> void:
	solved = true
	if ArrowTest:
		if (LArrows == RArrows):
			GlobalVariables.score +=1
	else:
		if ((nums[0] + nums[1]) % 2 == 0):
			GlobalVariables.score += 1


func _on_false_pressed() -> void:
	solved = true
	if ArrowTest:
		if (LArrows != RArrows):
			GlobalVariables.score +=1
	else:
		if ((nums[0] + nums[1]) % 2 != 0):
			GlobalVariables.score += 1
