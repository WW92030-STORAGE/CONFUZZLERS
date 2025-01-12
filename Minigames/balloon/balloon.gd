extends Node2D

var mu = 5
var stdev = 2 # NOTE - The RNG never picks a number more than 2 standard deviations distant
var pumps = 0
var maxpumps = 0

var nrounds = 20

func randnum():
	var res = randfn(mu, stdev)
	return max(0, min(res, mu + 2 * stdev), mu - 2 * stdev)

# Called when the node enters the scene tree for the first time.
func _ready():
	mu = randi_range(10, 15)
	stdev = randi_range(3, 5)
	GlobalVariables.score = 0
	GlobalVariables.scoreDenom = 0
	GlobalVariables.mu = mu
	GlobalVariables.nsize = stdev
	GlobalVariables.pdf = true
	reset()
	
func reset():
	pumps = 0
	maxpumps = randnum()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	$Pumps.text = str(pumps)
	$Score.text = str(GlobalVariables.score)
	if (GlobalVariables.scoreDenom >= nrounds):
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	pass


func _on_button_take_pressed():
	GlobalVariables.score += pumps
	reset()
	GlobalVariables.scoreDenom += 1
	


func _on_button_gamble_pressed():
	pumps += 1
	if (pumps > maxpumps):
		reset()
		GlobalVariables.scoreDenom += 1
