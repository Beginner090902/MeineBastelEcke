extends Line2D

var num_points  = Globale.num_points
var abstand  = Globale.abstand
var geschwindigkeit  = Globale.geschwindigkeit

var bewegungs_geschwindigkeit: float


func _ready() -> void:
	# Lösche vorherige Punkte, falls vorhanden
	clear_points()
	start_line()

func start_line():
	for i in range(num_points):
		add_point(Vector2(i * abstand,0))

		
		
func _process(delta: float) -> void:
	var amplitude = Globale.amplitude1
	var frequency = Globale.frequency1
	var offset_x = Globale.offset_x1
	var offeset_y = Globale.offset_y1
	bewegungs_geschwindigkeit += geschwindigkeit * delta
	
	for i in range(num_points - 1):
		var next_pos = get_point_position(i + 1)
		set_point_position(i, Vector2(next_pos.x - abstand, next_pos.y))
	
	var y = amplitude * sin(frequency * bewegungs_geschwindigkeit + offset_x) + offeset_y
	set_point_position(num_points-1, Vector2(num_points* abstand +1, y))


func _on_amp_eingabe_1_text_changed(new_text: String) -> void:
	Globale.amplitude1 = float(new_text)


func _on_fre_eingabe_1_text_changed(new_text: String) -> void:
	Globale.frequency1 = float(new_text)

func _on_xver_eingabe_1_text_changed(new_text: String) -> void:
	Globale.offset_x1 = float(new_text)


func _on_yver_eingabe_1_text_changed(new_text: String) -> void:
	Globale.offset_y1 = float(new_text)
