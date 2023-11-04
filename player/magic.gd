extends Node2D

var player;

func _ready():
	player = get_parent();
	visible = false;

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			global_position = get_global_mouse_position();

func _process(delta):
	if Input.is_action_pressed("select"):
		visible = true;
		scale.x = lerp(scale.x, 1, 0.2);
		scale.y = lerp(scale.y, 1, 0.2);
		rotation_degrees = lerp(rotation_degrees, 360, 0.2);
		$Pointer.global_transform = get_node(player.select+"/Position2D").global_transform;
		return
	
	scale.x = 0;
	scale.y = 0;
	rotation_degrees = 0;


func _on_ThunderShield_mouse_entered():
	player.select = "ThunderShield"

func _on_IceShot_mouse_entered():
	player.select = "IceShot"

func _on_GrassRadial_mouse_entered():
	player.select = "GrassRadial"

func _on_BloodHeal_mouse_entered():
	player.select = "BloodHeal"
