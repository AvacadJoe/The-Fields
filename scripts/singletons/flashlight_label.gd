extends RichTextLabel

func _process(delta):
    visible = GameManager.flashlight_unlocked 
    
    if GameManager.hide_labels:
        visible = false

    pass
