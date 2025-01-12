extends Node2D

var LEN = 4
var DIGITS = 10

var expected = ""
var input = ""
var solved = false
var nrounds = 5

var atts = 0

@onready var pre = $MarginContainer/VBoxContainer/Grid/Attempts/VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.scoreDenom = -1
	GlobalVariables.score = 0
	GlobalVariables.mu = 0 # total attempts
	GlobalVariables.nsize = -1
	solved = true
	
	randDigits(LEN)
	

func _render():
	$TextureProgressBar.set_value(256 * GlobalVariables.scoreDenom / nrounds)
	var res = str(input)
	while len(res) < LEN:
		res = res + "*"
	$MarginContainer/VBoxContainer/Grid/VBoxContainer/Score.text = str(GlobalVariables.score)
	$MarginContainer/VBoxContainer/Grid/VBoxContainer/INPUT.text = res
	$MarginContainer/VBoxContainer/Grid/VBoxContainer/Time.text = str(atts)
	$MarginContainer/VBoxContainer/Grid/VBoxContainer/AvgTime.text = str(GlobalVariables.mu)

func randDigits(len):
	expected = ""
	for i in range(len):
		expected = str(randi_range(0, 9)) + expected

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_render()
	
	if solved:
		solved = false
		GlobalVariables.scoreDenom += 1
		randDigits(LEN)
		
		GlobalVariables.mu += atts
		
		atts = 0
		
		for obj in pre.get_children():
			obj.queue_free()
		
	if GlobalVariables.scoreDenom >= nrounds:
		get_tree().change_scene_to_file("res://EndScreen.tscn")

func _on_x_1_pressed() -> void:
	if (len(input) < LEN):
		input = input + "1"


func _on_x_2_pressed() -> void:
	if (len(input) < LEN):
		input = input + "2"


func _on_x_3_pressed() -> void:
	if (len(input) < LEN):
		input = input + "3"


func _on_x_4_pressed() -> void:
	if (len(input) < LEN):
		input = input + "4"


func _on_x_5_pressed() -> void:
	if (len(input) < LEN):
		input = input + "5"


func _on_x_6_pressed() -> void:
	if (len(input) < LEN):
		input = input + "6"


func _on_x_7_pressed() -> void:
	if (len(input) < LEN):
		input = input + "7"


func _on_x_8_pressed() -> void:
	if (len(input) < LEN):
		input = input + "8"


func _on_x_9_pressed() -> void:
	if (len(input) < LEN):
		input = input + "9"


func _on_x_0_pressed() -> void:
	if (len(input) < LEN):
		input = input + "0"


func _on_back_pressed() -> void:
	if (len(input) > 0):
		input = input.substr(0, len(input) - 1)

func dist(a, b):
	var res = 0
	for i in range(min(len(a), len(b))):
		if a[i] != b[i]:
			res += 1
	return res

func _on_enter_pressed() -> void:
	if (len(input) != LEN):
		return
		
	atts += 1
	
	if input == expected:
		input = ""
		solved = true
		GlobalVariables.score += 1
		return
	else:
		print(input, expected)
		var lastatt = str(input) + " | " + str(LEN - dist(input, expected)) + " CORRECT"
		
		var thisone = Label.new()
		thisone.horizontal_alignment = 1
		thisone.theme = load("res://Minigames/mastermind/mastermind.tres")
		thisone.text = lastatt
		pre.add_child(thisone);
		
		input = ""


func _on_skip_pressed() -> void:
	solved = true
	
