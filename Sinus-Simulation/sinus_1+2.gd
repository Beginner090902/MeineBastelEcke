extends Line2D

var num_points  = SinusWellen.num_points
var abstand  = SinusWellen.abstand
var geschwindigkeit  = SinusWellen.geschwindigkeit

var bewegungs_geschwindigkeit: float

var welle1_sichtbar := 0 
var welle2_sichtbar := 0 

func _ready() -> void:
	# Lösche vorherige Punkte, falls vorhanden
	clear_points()
	start_line()

func start_line():
	for i in range(num_points):
		add_point(Vector2(i * abstand,0))
		
func get_y1():
	var amplitude1 = SinusWellen.amplitude1
	var frequency1 = SinusWellen.frequency1
	var offset_x1 = SinusWellen.offset_x1
	var offeset_y1 = SinusWellen.offset_y1
	
	var y1 = amplitude1 * sin(frequency1 * bewegungs_geschwindigkeit + offset_x1) + offeset_y1
	if welle1_sichtbar == 1:
		return(y1)
	else:
		return(0)
		
func get_y2():
	var amplitude2 = SinusWellen.amplitude2
	var frequency2 = SinusWellen.frequency2
	var offset_x2 = SinusWellen.offset_x2
	var offeset_y2 = SinusWellen.offset_y2	
	
	var y2 = amplitude2 * sin(frequency2 * bewegungs_geschwindigkeit + offset_x2) + offeset_y2
	if welle2_sichtbar == 1:
		return(y2)
	else:
		return(0)
		
func _process(delta: float) -> void:
	if welle1_sichtbar == 0 and welle2_sichtbar == 0:
		hide()
	else:
		show()
	bewegungs_geschwindigkeit += geschwindigkeit * delta
	if SinusWellen.simulatoin_anhalten == 1:
		pass
	else:
		for i in range(num_points - 1):
			var next_pos = get_point_position(i + 1)
			set_point_position(i, Vector2(next_pos.x - abstand, next_pos.y))
		
		
		var yges = get_y1() + get_y2()
		set_point_position(num_points-1, Vector2(num_points* abstand +1, yges))


func _on_welle_1_button_pressed() -> void:
	if welle1_sichtbar == 0:
		welle1_sichtbar = 1
	else:
		welle1_sichtbar = 0


func _on_welle_2_button_pressed() -> void:
	if welle2_sichtbar == 0:
		welle2_sichtbar = 1
	else:
		welle2_sichtbar = 0
