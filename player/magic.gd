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
		scale.x = lerp(scale.x, 1.4, 0.2);
		scale.y = lerp(scale.y, 1.4, 0.2);
		rotation_degrees = lerp(rotation_degrees, 360, 0.2);
		return
	
	scale.x = 0;
	scale.y = 0;
	rotation_degrees = 0;


func _on_ThunderShield_mouse_entered():
	player.select = "thunder_shield"

func _on_IceShot_mouse_entered():
	player.select = "ice_shot"

func _on_GrassRadial_mouse_entered():
	player.select = "grass_radial"

func _on_BloodHeal_mouse_entered():
	player.select = "blood_heal"
