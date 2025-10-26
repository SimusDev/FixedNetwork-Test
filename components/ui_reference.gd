extends Resource
class_name UIReference

var node: Node

func instantiate_for_player() -> Node:
	if not node.is_inside_tree():
		PlayerCanvas.instance.add_child(node)
	return node
	
