extends Node2D
@onready var bars_container = $Bars
var screen = get_viewport_rect().size
var bar_count = 100
var values = []

func _ready():

	
	var bar_width = screen.x / bar_count

	for i in range(bar_count):

		var value = randi_range(10, 100)
		values.append(value)

		var bar = ColorRect.new()

		bar.size.x = bar_width
		bar.size.y = value * 5

		bar.position.x = i * bar_width
		bar.position.y = screen.y - bar.size.y

		add_child(bar)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
