extends Area2D

var explosion = preload("res://effects/explosion/1.tscn");

func _process(delta):
	position += transform.x * 210 * delta;
	$Sprite2D.rotation_degrees += 16;

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Area2D_body_entered(body):
	if body.name != "Player": 
		var p = explosion.instantiate();
		get_tree().root.get_child(0).add_child(p);
		
		p.amount = int(randf_range(3, 8));
		p.global_position = global_position;
		p.process_material.set("gravity", Vector3(0, 260, 0));
		p.process_material.set("color", Color8(144, 189, 230));
		
		queue_free();
