@tool
class_name CodeGeneratorSpecification extends Resource

const Action = preload("CodeGeneratorTemplateAction.gd")

@export_file var template: String
@export var comment_start: String
@export var comment_error_messages: bool = true

var _connected_actions: Array[Action] = []
@export var template_actions: Array[Action]:
	set(value):
		if template_actions != null:
			for connected_action in _connected_actions:
				connected_action.changed.disconnect(emit_changed)
			_connected_actions.clear()
		template_actions = value
		if template_actions != null:
			for child in template_actions:
				if child == null:
					continue
				child.changed.connect(emit_changed)
				_connected_actions.append(child)

