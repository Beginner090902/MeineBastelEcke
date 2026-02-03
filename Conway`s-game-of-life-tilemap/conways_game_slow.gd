extends Control
var Debug_Level = 1
var Ready = false

var img: Image
var tex: ImageTexture



func Update_img():
	Resize_img()



func Logging(label: String, value) -> void:
	if Debug_Level >=1:
		# value wird automatisch in String umgewandelt
		print("[LOG] %s: %s" % [label, str(value)])

func _ready():
	Ready = true
	Resize_img()

		
func Resize_img() -> void:
	if not is_inside_tree():
		Logging("Scene ist noch nicht geladen", false)
		return

	Logging("Start Resize_img", true)
	Logging("Gesamt Pixel", CONWAYSVARIABEL.Pixel)
	if CONWAYSVARIABEL.Pixel <= 3:
		Logging("Keine Pixel zum Zeichnen", CONWAYSVARIABEL.Pixel)
		return
	CONWAYSVARIABEL.Breite = int(sqrt(CONWAYSVARIABEL.Pixel))
	Logging("Berechnete Breite des Bildes", CONWAYSVARIABEL.Breite)
	img = Image.create(CONWAYSVARIABEL.Breite, CONWAYSVARIABEL.Breite, false, Image.FORMAT_RGBA8)
	img.fill(Color.BLACK)
	#img.set_pixel(CONWAYSVARIABEL.Breite/2 , CONWAYSVARIABEL.Breite / 2, Color.WHITE)
	display_new_img(img)
	Logging("Ende Resize_img", true)
	
func display_new_img(img:Image):
	var rect: TextureRect = find_child("TextureRect")
	if rect == null:
		Logging("rect ist null – TextureRect nicht gefunden!", true)
		return
	#Logging("rect ist gültig", true)
	tex = ImageTexture.create_from_image(img)
	rect.texture = tex



func _on_start_stop_button_pressed() -> void:
	if CONWAYSVARIABEL.Simulation_Status == false:
		CONWAYSVARIABEL.Simulation_Status = true
	else :
		CONWAYSVARIABEL.Simulation_Status = false
	Logging("Simulation Status",CONWAYSVARIABEL.Simulation_Status)



func _on_simulation_speed_edit_text_submitted(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^[0-9]*$")
	if regex.search(new_text):
		CONWAYSVARIABEL.simulation_speed_in_seconds = int(new_text)
		Logging("Simulations Speed Changed to ", CONWAYSVARIABEL.simulation_speed_in_seconds)


func _on_pixelanzahldersimulation_text_submitted(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^[0-9]*$")
	if regex.search(new_text):
		CONWAYSVARIABEL.Pixel = int(new_text)
		Update_img()


func _on_bild_lerren_pressed() -> void:
	Logging("Bild lerren gedrückt ", true)
	img.fill(Color.BLACK)
	display_new_img(img)
	


func _on_run_or_stepmode_toggled(toggled_on: bool) -> void:
	if CONWAYSVARIABEL.Modus_auswahl_run_step == "run":
		CONWAYSVARIABEL.Modus_auswahl_run_step = "step"
	else:
		CONWAYSVARIABEL.Modus_auswahl_run_step = "run"
	Logging("Step oder Run Modus", CONWAYSVARIABEL.Modus_auswahl_run_step)

@onready var zahl_der_lebenden_cellen: Label = $"HBoxContainer/Links-MarginContainer/Linke_seite/HBoxContainer2/zahl der lebenden cellen"
func _on_start_dichte_in_prozent_item_selected(index: int) -> void:
	Logging("",true)
	Logging("start_dichte_in_prozent ausgewohlter index", index)
	var weiße_pixel_liste = []
	var x: int
	var fläche: int
	var prozent_fläche_in_weiß: int
	var i := 0
	

	img.fill(Color.BLACK)
	if index == 0:
		display_new_img(img)
		zahl_der_lebenden_cellen.set_text(str(i))
	x = img.get_height()
	fläche = x * x
	Logging("Bild Fläche (anzahl aller Pixel)", fläche)
	prozent_fläche_in_weiß = roundi(fläche * (float(index)/10))
	Logging("Anzahl der Pixel die weiß werden sollen", prozent_fläche_in_weiß)
	
	while i < prozent_fläche_in_weiß:
		
		#Logging("Gesamt weiße pixel wenn es vertig ist", prozent_fläche_in_weiß)
		#Logging("schon weiße pixel erstellt ", i )
		var neuer_piexel_weiß_x : int
		var neuer_piexel_weiß_y : int
		var pixel_schon_vorhanden : bool
		
		neuer_piexel_weiß_x = randi_range(0,x-1)
		#Logging("position von dem neuen weißen pixel x", neuer_piexel_weiß_x)
		neuer_piexel_weiß_y = randi_range(0,x-1)
		#Logging("position von dem neuen weißen pixel y", neuer_piexel_weiß_y)

		for weißer_pixel in weiße_pixel_liste:
			var xposotion = weißer_pixel[0]
			var yposition = weißer_pixel[1]
			if neuer_piexel_weiß_x == xposotion and neuer_piexel_weiß_y == yposition: 
				#Logging("pixel schon vorhanden wird neu gestartet", true)
				pixel_schon_vorhanden = true
		if not pixel_schon_vorhanden:
			weiße_pixel_liste.append([neuer_piexel_weiß_x,neuer_piexel_weiß_y])
			img.set_pixel(neuer_piexel_weiß_x, neuer_piexel_weiß_y, Color.WHITE)
			display_new_img(img)
			await get_tree().process_frame
			i = i +1
		zahl_der_lebenden_cellen.set_text(str(i))
		pixel_schon_vorhanden  = false
		
func Simulation_step():
	CONWAYSVARIABEL.Simulation_steps = CONWAYSVARIABEL.Simulation_steps + 1
	Logging("Simulation Step Count", CONWAYSVARIABEL.Simulation_steps)
	
func _process(delta: float) -> void:
	CONWAYSVARIABEL.time_sins_last_frame = CONWAYSVARIABEL.time_sins_last_frame + delta
	if CONWAYSVARIABEL.Simulation_Status == false:
		return
		
	if CONWAYSVARIABEL.Modus_auswahl_run_step == "run":
		if CONWAYSVARIABEL.time_sins_last_frame >= CONWAYSVARIABEL.simulation_speed_in_seconds:
			CONWAYSVARIABEL.time_sins_last_frame = 0.0
			Simulation_step()
			
	if CONWAYSVARIABEL.Modus_auswahl_run_step == "step":
		if CONWAYSVARIABEL.manual_steps_prest > 0 :
			var i = 0
			while i < CONWAYSVARIABEL.manual_steps_prest:
				i = i + 1
				Simulation_step()
			i =  0 
			CONWAYSVARIABEL.manual_steps_prest = 0

func _on_pluse_one_simulation_step_pressed() -> void:
	CONWAYSVARIABEL.manual_steps_prest = 1

func _on_pluse_tue_simulation_step_pressed() -> void:
	CONWAYSVARIABEL.manual_steps_prest = 2

func _on_pluse_three_simulation_step_pressed() -> void:
	CONWAYSVARIABEL.manual_steps_prest = 3
