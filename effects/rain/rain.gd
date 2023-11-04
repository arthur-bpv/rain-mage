extends Node2D


var drop = preload("res://effects/rain/drop.tscn");

var MIN_PER_SPAWN = 8.0;
var MAX_PER_SPAWN = 42.0;
var cooldown = 0;

func _process(delta):
	cooldown -= delta;
	
	if cooldown <= 0:
		
		for n in int(rand_range(MIN_PER_SPAWN, MAX_PER_SPAWN)):
			var d = drop.instance();
			d.position.x = rand_range(0, 384);
			d.position.y = -rand_range(0, 128);
			add_child(d);
		
		cooldown = 1;
