extends Node2D


var emptyBlock = preload("res://Blocks/emptyBlock.tscn")
var oneCoinBlock = preload("res://Blocks/OneCoinBlock.tscn")
var twoCoinBlock = preload("res://Blocks/TwoCoinBlock.tscn")
var threeCoinBlock = preload("res://Blocks/ThreeCoinBlock.tscn")

var blocks = [emptyBlock, oneCoinBlock, twoCoinBlock, threeCoinBlock]

func _ready():
	for i in range(200, 601, 200):
		var pos = Vector2(50, i)
		while pos.x < 1152:
			var block = blocks.pick_random().instantiate()
			add_child(block)
			block.global_position = pos
			pos.x += (block.get_node("CollisionShape2D").shape.size * block.get_node("CollisionShape2D").scale / 2 ).x + 5
