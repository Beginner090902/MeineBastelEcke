extends Line2D

var num_points  = SinusWellen.num_points
var abstand  = SinusWellen.abstand
var geschwindigkeit  = SinusWellen.geschwindigkeit

var bewegungs_geschwindigkeit: float
var sichtbar := 0


func _ready() -> void:
	# Lösche vorherige Punkte, falls vorhanden
	clear_points()
	start_line()
	hide()
func start_line():
	for i in range(num_points):
		add_point(Vector2(i * abstand,0))

		
		
func _process(delta: float) -> void:
	if sichtbar == 0:
		hide()
	else:
		show()

	var amplitude = SinusWellen.amplitude1
	var frequency = SinusWellen.frequency1
	var offset_x = SinusWellen.offset_x1
	var offeset_y = SinusWellen.offset_y1
	bewegungs_geschwindigkeit += geschwindigkeit * delta
	
	for i in range(num_points - 1):
		var next_pos = get_point_position(i + 1)
		set_point_position(i, Vector2(next_pos.x - abstand, next_pos.y))
	
	var y = amplitude * sin(frequency * bewegungs_geschwindigkeit + offset_x) + offeset_y
	set_point_position(num_points-1, Vector2(num_points* abstand +1, y))


func _on_amp_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.amplitude1 = float(new_text)


func _on_fre_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.frequency1 = float(new_text)

func _on_xver_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.offset_x1 = float(new_text)


func _on_yver_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.offset_y1 = float(new_text)


func _on_welle_1_einzeln_button_pressed() -> void:
	if sichtbar  == 0:
		sichtbar = 1
	else:
		sichtbar = 0
	print(sichtbar)
