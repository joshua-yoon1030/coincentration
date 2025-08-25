extends Node2D


var emptyBlock = preload("res://Blocks/emptyBlock.tscn")
var oneCoinBlock = preload("res://Blocks/OneCoinBlock.tscn")
var twoCoinBlock = preload("res://Blocks/TwoCoinBlock.tscn")
var threeCoinBlock = preload("res://Blocks/ThreeCoinBlock.tscn")
var coinScene = preload("res://coin.tscn")

var blocks = [emptyBlock, oneCoinBlock, twoCoinBlock, threeCoinBlock]

var positions = []


func _ready():
	for y in range(200, 601, 200):
		for x in range(50, 1153, 105):
			positions.append(Vector2(x, y))
	positions.shuffle()
	
	for i in len(positions):
		var block
		if i < 8:
			block = threeCoinBlock.instantiate()
			block.global_position = positions[i]
			for j in range(3):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.init(block)
		elif i < 17:
			block = twoCoinBlock.instantiate()
			block.global_position = positions[i]
			for j in range(2):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.init(block)
		elif i < 25:
			block = oneCoinBlock.instantiate()
			block.global_position = positions[i]
			for j in range(1):
				var coin = coinScene.instantiate()
				add_child(coin)
				coin.init(block)
		else:
			block = emptyBlock.instantiate()
			block.global_position = positions[i]
		add_child(block)
