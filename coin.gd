extends AnimatedSprite2D

var target_x = 0
var target_y = 0
var wall_target = 0

var left_bound = 0
var right_bound = 1140

var tween_x
var x_speed = randi()%100 + 100
var tween_y
var y_speed = randi()%20 + 60

var last_y: float
var last_velocity := 0.0

var has_stopped = false
var has_stop_bouncing = false
var has_checked_cross = false
var can_check_cross = false

signal coin_done

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
	last_y = global_position.y
	tween_y = create_tween()
	var distance = abs(target_y - global_position.y)
	var duration = distance / y_speed
	tween_y.tween_property($".", "global_position:y", target_y, duration).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween_y.finished.connect(func(): has_stop_bouncing = true)
	
func handle_bounce_sound(delta: float):
	if tween_y and tween_y.is_running():
		# Calculate velocity from position difference
		var current_velocity = (global_position.y - last_y) / delta
		last_y = global_position.y
		
		 # Detect bounce = velocity changes sign
		if sign(current_velocity) < 0 and sign(last_velocity) > 0 and abs(last_velocity) > 0.1:
			$bounce.play()
		last_velocity = current_velocity

func handle_x(target: float):
	has_checked_cross = false
	
	tween_x = create_tween()
	var distance = abs(target - global_position.x)
	var duration = distance / x_speed   # time = distance / speed
	tween_x.tween_property($".", "global_position:x", target, duration)
	
	tween_x.finished.connect(func():
		if not has_stopped:
			if(has_stop_bouncing):
				can_check_cross = true
			# Continue bouncing to the other edge
			var next_target = right_bound if (target == left_bound) else left_bound
			wall_target = next_target
			handle_x(next_target))

func _process(delta: float) -> void:
	handle_bounce_sound(delta)
	if has_stopped: return
	if !can_check_cross: return
	if has_checked_cross: return
	
	if global_position.y == target_y and ((global_position.x <= target_x and wall_target < global_position.x) or (global_position.x >= target_x and wall_target > global_position.x)):
		has_checked_cross = true
		has_stopped = true
		global_position.x = target_x
		tween_x.kill()
		z_index = 0
		var final_tween = create_tween()
		final_tween.tween_property($".", "global_position:y", target_y + 100, 0.5)
		final_tween.finished.connect(func(): 
			coin_done.emit()
			queue_free())
