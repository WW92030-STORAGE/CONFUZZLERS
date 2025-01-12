extends CharacterBody2D

var radius = 0
var center = Vector2(0, 0)
var progress = 0
var maximum = 100 # Must be a multiple of 4

var disabled = false
var opacity = 1.0

var red_tint = 0
var green_tint = 0

func _ready():
	radius = $CollisionShape2D.shape.get_rect().size.x / 2 * transform.get_scale().x
	center = global_position
	$TextureProgressBar.value = 0
	$TextureProgressBar.max_value = maximum
	GlobalVariables.set0[center] = null
	GlobalVariables.scoreDenom += 1
	print("ENTITY " + str(radius) + " / " + str(center))

func _physics_process(delta):
	center = global_position
	var x = $CollisionShape2D
	progress = progress + 1
	$TextureProgressBar.value = progress
	
	if (progress >= maximum * 0.75):
		$TextureProgressBar.tint_progress = Color(0.5, 1, 1, 1)
	
	if (progress >= maximum):
		red_tint = 1
		disabled = true
	if (disabled):
		GlobalVariables.set0.erase(center)
		opacity -= 0.1
		if (opacity < 0):
			queue_free()
			
		$TextureProgressBar.tint_progress = Color(red_tint, green_tint, 0, opacity)

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		if ((event.position).distance_squared_to(center) <= radius * radius):
			print("Hit in circle")
			if (!disabled):
				if (progress >= maximum * 0.75):
					print("WIN")
					GlobalVariables.score += 1
					opacity = 1
					red_tint = 0
					green_tint = 1
					disabled = true
				else:
					red_tint = 1
					disabled = true
					
	
