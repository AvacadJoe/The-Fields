extends Node3D

var is_found = false
@onready var book_item = $Book

func _process(delta):
    if not is_found and GameManager.book:
        is_found = true
        book_item.view_item()
