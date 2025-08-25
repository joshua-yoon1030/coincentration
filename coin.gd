extends AnimatedSprite2D

var target = Vector2(0,0)

func init(block: Block):
	target = block.global_position
	
	var tween = create_tween()
	print(target)
	tween.tween_property($".", "position", target, 5)
	
