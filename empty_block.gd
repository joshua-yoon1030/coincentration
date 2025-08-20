extends Area2D

@onready var collision_shape = $CollisionShape2D
@export var texture_a: Texture2D
@export var texture_b: Texture2D

var clicked := false

func _ready():
	var rect_shape = collision_shape.shape as RectangleShape2D
	if rect_shape and texture_a:
		var rect_size = rect_shape.extents * 2.0 # extents are half-width/height
		var tex_size = texture_a.get_size()
		scale = rect_size / tex_size
	$CollisionShape2D/Sprite2D.texture = texture_a

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not clicked:
			$CollisionShape2D/Sprite2D.texture = texture_b
			print("test!~")
		
	
