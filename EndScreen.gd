extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/SCORE.text = "SCORE - " + str(GlobalVariables.score) + " / " + str(GlobalVariables.scoreDenom)
	if (GlobalVariables.pdf):
		$MarginContainer/VBoxContainer/AVG.text = "AVERAGE - " + str(GlobalVariables.mu) + " | STDEV - " + str(GlobalVariables.nsize)  
	else:
		$MarginContainer/VBoxContainer/AVG.text = "AVERAGE - " + str(GlobalVariables.mu) + " (n = " + str(GlobalVariables.nsize) + ")"  
	GlobalVariables.pdf = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://TitleMenu.tscn")
