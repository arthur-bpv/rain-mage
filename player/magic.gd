extends Node2D

var player;

func _ready():
	player = get_tree().root.get_child(0).get_node("Player");
	visible = false;

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2:
			global_position = get_global_mouse_position();

func _process(delta):
	if Input.is_action_pressed("select"):
		var a = get_node(player.select+"/Position2D");
		
		$Menu.scale = lerp($Menu.scale, Vector2(1,1), 0.2);
		$Menu.rotation_degrees = lerp($Menu.rotation_degrees, 360, 0.2);
		
		$Staffs.scale = lerp($Staffs.scale, Vector2(1,1), 0.2);
		$Staffs.rotation_degrees = lerp($Staffs.rotation_degrees, 360, 0.2);
		
		$Pointer.scale = lerp($Pointer.scale, Vector2(1,1), 0.2);
		$Pointer.global_position = a.global_position;
		$Pointer.global_rotation = a.global_rotation;
		
		visible = true;
		return
	
	$Menu.scale = Vector2(0,0);
	$Menu.rotation_degrees = 0;
	
	$Staffs.scale = Vector2(0,0);
	$Staffs.rotation_degrees = 0;
	
	$Pointer.scale = Vector2(0,0);
	
	visible = false;


func _on_ThunderShield_mouse_entered():
	player.select = "ThunderShield"

func _on_IceShot_mouse_entered():
	player.select = "IceShot"

func _on_GrassRadial_mouse_entered():
	player.select = "GrassRadial"

func _on_BloodHeal_mouse_entered():
	player.select = "BloodHeal"

func _on_Staff_mouse_entered():
	player.select = "CrystalShot"
