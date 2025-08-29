extends Block

@onready var collision_shape = $CollisionShape2D
@export var texture_a: Texture2D
@export var texture_b: Texture2D

var clicked := false

func _ready():
	_resize_and_assign(texture_a)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not clicked:
			clicked = true
			on_click.emit(0)
			_resize_and_assign(texture_b)
		

func _resize_and_assign(tex: Texture2D):
	$CollisionShape2D/Sprite2D.texture = tex
	var shape = $CollisionShape2D.shape
	var target_size = Vector2(shape.extents.x * 2, shape.extents.y * 2)
	var tex_size = tex.get_size()
	$CollisionShape2D/Sprite2D.scale = target_size / tex_size
