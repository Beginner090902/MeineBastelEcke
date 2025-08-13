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

	var amplitude = SinusWellen.amplitude2
	var frequency = SinusWellen.frequency2
	var offset_x = SinusWellen.offset_x2
	var offeset_y = SinusWellen.offset_y2
	bewegungs_geschwindigkeit += geschwindigkeit * delta
	
	if SinusWellen.simulatoin_anhalten == 1:
		pass
	else:
		for i in range(num_points - 1):
			var next_pos = get_point_position(i + 1)
			set_point_position(i, Vector2(next_pos.x - abstand, next_pos.y))
		
		var y = amplitude * sin(frequency * bewegungs_geschwindigkeit + offset_x) + offeset_y
		set_point_position(num_points-1, Vector2(num_points* abstand +1, y))


func _on_amp_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.amplitude2 = float(new_text)


func _on_fre_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.frequency2 = float(new_text)

func _on_xver_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.offset_x2 = float(new_text)


func _on_yver_eingabe_1_text_changed(new_text: String) -> void:
	SinusWellen.offset_y2 = float(new_text)


func  _on_welle_2_einzeln_button_pressed()-> void:
	if sichtbar  == 0:
		sichtbar = 1
	else:
		sichtbar = 0
	print(sichtbar)
