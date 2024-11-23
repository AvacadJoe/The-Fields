extends RichTextLabel

func _process(delta):
    visible = GameManager.flashlight_unlocked 
    pass
