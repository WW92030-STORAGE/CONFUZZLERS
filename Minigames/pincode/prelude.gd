extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_normal_pressed() -> void:
	GlobalVariables.args["mode"] = "N"
	get_tree().change_scene_to_file("res://Minigames/pincode/pincode.tscn")


func _on_reverse_pressed() -> void:
	GlobalVariables.args["mode"] = "R"
	get_tree().change_scene_to_file("res://Minigames/pincode/pincode.tscn")


func _on_sorted_pressed() -> void:
	GlobalVariables.args["mode"] = "S"
	get_tree().change_scene_to_file("res://Minigames/pincode/pincode.tscn")
