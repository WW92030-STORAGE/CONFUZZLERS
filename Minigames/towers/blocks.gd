class_name Blocks
extends Node2D

# Things

@onready var S = [$s0, $s1, $s2]
@onready var B = [$b0, $b1, $b2]
@onready var X = [$x0, $x1, $x2]

var MAX_PER_S = 4

var OFFSET = Vector2(32, 32)

# Game state variables
var PRESSED = -1
var moves = 0

func makeTextureRect(i):
	var node = TextureRect.new()
	if i == 1:
		node.texture = load("res://Minigames/towers/red.png")
	elif i == 2:
		node.texture = load("res://Minigames/towers/yellow.png")
	elif i == 3:
		node.texture = load("res://Minigames/towers/green.png")
	elif i == 4:
		node.texture = load("res://Minigames/towers/cyan.png")
	elif i == 5:
		node.texture = load("res://Minigames/towers/blue.png")
	elif i == 6:
		node.texture = load("res://Minigames/towers/magenta.png")
	elif i == 7:
		node.texture = load("res://Minigames/towers/blank.png")
	else:
		node.texture = load("res://Minigames/towers/0.png")
		
	node.name = "TextureRect__" + str(i)
	
	return node

func init(cols, pos):
	moves = 0
	for s in S:
		for i in s.get_children():
			i.free()
	
	
	for i in range(len(cols)):
		var node = makeTextureRect(cols[i])
		# print(node, node.texture)
		S[pos[i]].add_child(node)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$b0.hide()
	$b1.hide()
	$b2.hide()
	if PRESSED == 0:
		$b0.show()
	if PRESSED == 1:
		$b1.show()
	if PRESSED == 2:
		$b2.show()
		
func move(s, e):
	PRESSED = -1
	
	
	var l1 = S[s].get_children()
	var l2 = S[e].get_children()
	
	# print(l1, l2)
	
	if len(l1) <= 0:
		return
	if len(l2) >= MAX_PER_S:
		return
		
	moves += 1
	
	var themoved = l1[len(l1) - 1]
	S[s].remove_child(themoved)
	S[e].add_child(themoved)
	

func _on_x_0_pressed() -> void:
	if not get_meta("CLICKABLE"):
		return
	print("0 PRESSED")
	if PRESSED == -1:
		PRESSED = 0
	elif PRESSED == 0:
		PRESSED = -1
	
	else:
		move(PRESSED, 0)

func _on_x_1_pressed() -> void:
	if not get_meta("CLICKABLE"):
		return
	print("1 PRESSED")
	if PRESSED == -1:
		PRESSED = 1
	elif PRESSED == 1:
		PRESSED = -1
	
	else:
		move(PRESSED, 1)

func _on_x_2_pressed() -> void:
	if not get_meta("CLICKABLE"):
		return
	print("2 PRESSED")
	if PRESSED == -1:
		PRESSED = 2
	elif PRESSED == 2:
		PRESSED = -1
		
	else:
		move(PRESSED, 2)
	
func disp():
	print(name)
	
	for s in range(3):
		print("S ", s)
		for i in S[s].get_children():
			print(i.name)
