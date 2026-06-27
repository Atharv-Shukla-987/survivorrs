extends Area2D


const speed = 100
var direction = Vector2.RIGHT
var damage = 50
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	
	
func _physics_process(delta: float) -> void:
	position = position + (direction * speed * delta)
	rotation = direction.angle()
	
	
	
func _on_body_entered(body) -> void:
	if body.has_method("damage") :
		body.damage(damage)
		queue_free()
