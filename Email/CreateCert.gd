extends Button

var font = load("res://MainMenu/Font/CertFont.tres")
var viewport = Viewport.new()
var viewportImage
var cvitem
var size := Vector2(2000, 1414)

func _ready() -> void:
	viewport.size = size
	viewport.render_target_update_mode = Viewport.UPDATE_ALWAYS
	self.add_child(viewport)
	var textureItem = TextureRect.new()
	textureItem.texture = load("res://Email/Cert.png")
	viewport.add_child(textureItem)
	cvitem = Control.new()
	viewport.add_child(cvitem)
	cvitem.rect_min_size = size
	cvitem.set_script(load("res://Email/DrawText.gd"))
	cvitem.modulate = Color(0.26, 0.26, 0.28)

func saveImage():
	yield(get_tree(), "idle_frame")
	viewportImage = viewport.get_texture().get_data()
	viewportImage.flip_y()
	viewportImage.save_png("user://NamedCert.png")
