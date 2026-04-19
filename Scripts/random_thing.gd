extends Label

var rng_thing = RandomNumberGenerator.new()
var Strings = ["Hi","Testing"]

func  _ready() -> void:
	var string_new = Strings.pick_random()
	text = string_new
	print(string_new)
