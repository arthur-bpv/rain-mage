extends Area2D

var explosion = preload("res://effects/explosion/1.tscn");

func _process(delta):
	position += transform.x * 220 * delta;

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		var p = explosion.instantiate();
		get_tree().root.get_child(0).add_child(p);
		
		p.amount = int(randf_range(2, 6));
		p.global_position = global_position;
		p.process_material.set("color", Color8(72, 207, 127));
		
		queue_free();
