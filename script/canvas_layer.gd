extends CanvasLayer
@onready var wave_label: Label = $waveLabel

func _ready() -> void:
	var wave_manager = get_tree().get_first_node_in_group("wave_manager")
	wave_manager.wavestart.connect(wavestared)
	wave_manager.waveend.connect(wavestared)
	wave_label.text = ""
func wavestared(wavenum:int) -> void:
	wave_label.text = "WAVE" + str(wavenum) 
	wave_label.modulate= Color.WHITE
	
	await get_tree().create_timer(1.0).timeout
	
	
	
func waveend(wavenum:int)-> void:
	wave_label.text = "WAVE" + str(wavenum) + "COMPLETED"
	wave_label.modulate= Color.DARK_RED
	await get_tree().create_timer(1.5).timeout
	
	
	
	
func fade()-> void:
	var tween = create_tween()
	tween.tween_property(wave_label,"modulate",Color.TRANSPARENT,.5)
	
