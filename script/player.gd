extends CharacterBody2D

var speed= 500
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direc = Vector2.ZERO 
	direc.x = Input.get_axis("left" , "right")
	direc.y = Input.get_axis("up","down")
	
	if direc != Vector2.ZERO :
		direc = direc.normalized()
		
		
	velocity = speed * direc
	move_and_slide()
	
	
	
	
	
		
		
