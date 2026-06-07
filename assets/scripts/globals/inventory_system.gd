# InventoryManager.gd
extends Node

signal item_added(item: ItemData)
var items: Array[ItemData] = []

func add_item(item: ItemData):
	# if item exist, update total for item
	if item in items:
		item.value += 1
		print("new " + item.name + " value is " + str(item.value))
		print("That item already exist in inventory. I'll update the count instead.")
	# if item doesn't exist, add new item to inventory
	elif item not in items:
		items.append(item)
		item.value += 1
		item_added.emit(item)
		print("Collected: ", item.name, ". Total is now: ", item.value)
		print("The totals number of items in inventory is " + str(items.size()))
		
