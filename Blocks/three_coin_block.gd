extends Area2D
@onready var collision_shape = $CollisionShape2D
@export var texture_a: Texture2D
@export var texture_b: Texture2D

var clicked := false

func _ready():
	_resize_and_assign(texture_a)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not clicked:
			$CollisionShape2D/AnimationPlayer.play("Collect_3")
		

func _resize_and_assign(tex: Texture2D):
	$CollisionShape2D/Sprite2D.texture = tex
	var shape = $CollisionShape2D.shape
	var target_size = Vector2(shape.extents.x * 2, shape.extents.y * 2)
	var tex_size = tex.get_size()
	$CollisionShape2D/Sprite2D.scale = target_size / tex_size


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Collect_3"):
		_resize_and_assign(texture_b)
