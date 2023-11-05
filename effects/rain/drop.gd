extends Area2D

var back = preload("res://effects/rain/back.tscn");

var speed = rand_range(80, 150)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	var p = back.instance();
	p.global_position = global_position;
	p.global_position.y -= 3;
	get_tree().root.get_child(0).add_child(p);
	queue_free();

func _process(delta):
	global_position.y += speed * delta
