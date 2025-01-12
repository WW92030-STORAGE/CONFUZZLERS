extends MarginContainer

var stringvar = "..."

func resetMenu():
	stringvar = "..."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VBoxContainer/Label.text = stringvar

# Button presses

func _on_grill_button_pressed():
	get_tree().change_scene_to_file("res://Minigames/grillmaster/grillmaster.tscn")
func _on_grill_button_mouse_entered():
	stringvar = "ORB SMASHER"
func _on_grill_button_mouse_exited():
	resetMenu()

func _on_num_blocks_button_pressed():
	get_tree().change_scene_to_file("res://Minigames/numblocks/numblocks.tscn")
func _on_num_blocks_button_mouse_entered():
	stringvar = "NUMBER BLOCKS"
func _on_num_blocks_button_mouse_exited():
	resetMenu()


func _on_shapeshifter_button_pressed():
	get_tree().change_scene_to_file("res://Minigames/shapeshifter/shapeshifter.tscn")
func _on_shapeshifter_button_mouse_entered():
	stringvar = "SHAPE SHIFTER"
func _on_shapeshifter_button_mouse_exited():
	resetMenu()


func _on_balloon_button_pressed():
	get_tree().change_scene_to_file("res://Minigames/balloon/balloon.tscn")
func _on_balloon_button_mouse_entered():
	stringvar = "BALLOON"
func _on_balloon_button_mouse_exited():
	resetMenu()


func _on_code_compare_button_pressed():
	get_tree().change_scene_to_file("res://Minigames/codecompare/codecompare.tscn")
func _on_code_compare_button_mouse_entered():
	stringvar = "CODE COMPARE"
func _on_code_compare_button_mouse_exited():
	resetMenu()


func _on_pin_code_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Minigames/pincode/prelude.tscn")
func _on_pin_code_button_mouse_entered() -> void:
	stringvar = "PIN CODE"
func _on_pin_code_button_mouse_exited() -> void:
	resetMenu()


func _on_theswitch_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Minigames/theswitch/theswitch.tscn")
func _on_theswitch_button_mouse_entered() -> void:
	stringvar = "THE SWITCH"
func _on_theswitch_button_mouse_exited() -> void:
	resetMenu()


func _on_mastermind_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Minigames/mastermind/mastermind.tscn")
func _on_mastermind_button_mouse_entered() -> void:
	stringvar = "MASTERMIND"
func _on_mastermind_button_mouse_exited() -> void:
	resetMenu()


func _on_towers_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Minigames/towers/towers.tscn")
func _on_towers_button_mouse_entered() -> void:
	stringvar = "TOWERS"
func _on_towers_button_mouse_exited() -> void:
	resetMenu()
