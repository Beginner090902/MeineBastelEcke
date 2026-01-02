extends Node2D
# Größe der Zeichenfläche (Pixel)
const WIDTH = 65
const HEIGHT = 65

var img: Image
var tex: ImageTexture

var time_sins_last_frame = 0
var simulation_speed_in_seconds := 0.5

@onready var sprite = $Canvas

# Called when the node enters the scene tree for the first time.
func _ready():
# Neues leeres Bild (schwarz)
	img = Image.create(WIDTH, HEIGHT, false, Image.FORMAT_RGBA8)
	img.fill(Color.BLACK)
	img.set_pixel(int(WIDTH/2) , int(HEIGHT/2)  ,Color.WHITE)
	
	tex = ImageTexture.create_from_image(img)
	sprite.texture = tex
	
# Sprite skalieren, damit man Pixel besser sieht
	#sprite.scale = Vector2(8, 8)  # 8x Vergrößerung
	sprite.position = Vector2(0, 0)

func _process(delta: float) -> void:
	time_sins_last_frame += delta
	if time_sins_last_frame < simulation_speed_in_seconds:
		return
	
