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
		
		# If player picks up grimoire set global variable so it isn't added back to scene
		if item.name == "grimoire":
			GameManager.has_grimoire = true
		
	# If player picks up a gem, increase the global gem count and score
	if item.name == "gem":
		GameManager.gem_count +=1
		GameManager.score += 100
		
		# If player collects 100 gems add an extra life 1UP
		if GameManager.gem_count == 100:
			GameManager.player_lives += 1
		
