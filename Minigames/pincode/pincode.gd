extends Node2D

var LEN = 2
var solved = false
var DELAY = 750
var INDEX = -1

var expected = ""
var input = ""

var FAIL = 0
var MAXFAIL = 2

@onready var buttons = [$KEYPAD/x0, $KEYPAD/x1, $KEYPAD/x2, $KEYPAD/x3, $KEYPAD/x4, $KEYPAD/x5, $KEYPAD/x6, $KEYPAD/x7, $KEYPAD/x8, $KEYPAD/x9]

func reveal(ind):
	var res = ""
	for i in range(len(expected)):
		if ind == i:
			res = res + expected[i]
		else:
			res = res + "*"
	return res
	
func _render():
	$Score.text = str(GlobalVariables.score)
	$FAIL.text = str(MAXFAIL - FAIL) + " LIVES REMAINING"
	$INPUT.text = input
	

func randDigits(len):
	expected = ""
	for i in range(len):
		expected = str(randi_range(0, 9)) + expected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.scoreDenom = -1
	GlobalVariables.score = 0
	GlobalVariables.mu = 0
	GlobalVariables.nsize = -1
	solved = true
	for i in range(1000):
		LEN = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_render()
	if (solved):
		randDigits(LEN)
		input = ""
		GlobalVariables.time0 = Time.get_ticks_msec()
		$CODE/Label.text = reveal(-1)
		INDEX = -1
		solved = false
		
		for button in buttons:
			button.disabled = true
	
	if INDEX >= -1:
		
		if (Time.get_ticks_msec() - GlobalVariables.time0 >= DELAY):
			INDEX += 1
			$CODE/Label.text = reveal(INDEX)
			print(reveal(INDEX))
			GlobalVariables.time0 = Time.get_ticks_msec()
	
	if INDEX >= LEN:
		for button in buttons:
			button.disabled = false


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

func sort(s):
	var res = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	for ss in s:
		res[int(ss)] += 1
	var sres = ""
	for i in range(10):
		for j in range(res[i]):
			sres = sres + str(i)
	return sres

func _on_enter_pressed() -> void:
	if (len(input) != LEN):
		return
	GlobalVariables.scoreDenom += 1
	if (GlobalVariables.scoreDenom % 2 == 0):
		LEN += 1
	if GlobalVariables.args["mode"] == "N":
		if input == expected:
			GlobalVariables.score += 1
			FAIL = 0
		else:
			FAIL += 1
	if GlobalVariables.args["mode"] == "R":
		if input == expected.reverse():
			GlobalVariables.score += 1
			FAIL = 0
		else:
			FAIL += 1
	if GlobalVariables.args["mode"] == "S":
		if input == sort(expected):
			GlobalVariables.score += 1
			FAIL = 0
		else:
			FAIL += 1
	
	
	if FAIL >= MAXFAIL:
		get_tree().change_scene_to_file("res://EndScreen.tscn")
	
	
	solved = true
