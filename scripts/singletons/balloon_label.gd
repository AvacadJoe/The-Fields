extends RichTextLabel

func _process(delta):
    #Should be a better way to do this but we're game jammin'
    visible = GameManager.balloon_unlocked 
    
    if GameManager.hide_labels:
        visible = false
    pass
