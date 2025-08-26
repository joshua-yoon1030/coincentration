extends AnimatedSprite2D

var target_x = 0
var target_y = 0
var wall_target = 0

var left_bound = 0
var right_bound = 1140

var tween_x
var x_speed = randi()%100 + 100
var tween_y

var has_stopped = false
var has_checked_cross = false

func init(block: Block):
	randomize()
	z_index = 10
	global_position = Vector2(randi()%1000 + 70, -70)
	target_y = block.global_position.y-70
	target_x = block.global_position.x
	
	await get_tree().create_timer(randi()%3).timeout
	
	handle_y()
	wall_target = left_bound if randf() < 0.5 else right_bound
	handle_x(wall_target)
	
	
func handle_y():
	tween_y = create_tween()
	tween_y.tween_property($".", "global_position:y", target_y, 5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

func handle_x(target: float):
	has_checked_cross = false
	
	tween_x = create_tween()
	var distance = abs(target - global_position.x)
	var duration = distance / x_speed   # time = distance / speed
	tween_x.tween_property($".", "global_position:x", target, duration)
	
	tween_x.finished.connect(func():
		if not has_stopped:
			# Continue bouncing to the other edge
			var next_target = right_bound if (target == left_bound) else left_bound
			wall_target = next_target
			handle_x(next_target))

func _process(delta: float) -> void:
	if has_stopped: return
	if has_checked_cross: return
	
	if global_position.y == target_y and ((global_position.x <= target_x and wall_target < global_position.x) or (global_position.x >= target_x and wall_target > global_position.x)):
		has_checked_cross = true
		if randf() < 0.3:
			has_stopped = true
			global_position.x = target_x
			tween_x.kill()
			z_index = 0
			var final_tween = create_tween()
			final_tween.tween_property($".", "global_position:y", target_y + 100, 0.5)
			final_tween.finished.connect(func(): queue_free())
