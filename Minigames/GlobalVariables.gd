extends Node

# Variables that can be used for various purposes (these variables are used across all minigames, most of them in multiple)

var score = 0 # Countable score (e.g. number of completed rounds)
var scoreDenom = 0 # Denominator for countable score (e.g. total number of rounds)

var time0 = 0 # Time variable 1
var time1 = 0 # Time variable 2

var set0 = {} # Set or dictionary for data storage

var pdf = false
var mu = 0 # Used for a cumulative average
var nsize = 0 # Sample size
var highest = 0 # Highest of a data stream
var lowest = 0 # Lowest of a data stream

var args = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
