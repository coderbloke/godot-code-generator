@tool
class_name CodeGeneratorSpecification extends Resource

const Action = preload("CodeGeneratorTemplateAction.gd")

@export_file var template: String
@export var comment_start: String = "#"
@export var comment_error_messages: bool = true

var _connected_actions: Array[Action] = []
var template_actions: Array[Action]:
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

func _get_property_list():
	var properties = []
	properties.append({
		"name": "template_action_count",
		"class_name": "Template Actions,template_action_,add_button_text=Add template action,page_size=10",
		"type": TYPE_INT,
		"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ARRAY,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": ""
	})
	for i in template_actions.size():
		if template_actions[i] == null:
			template_actions[i] = CodeGeneratorTemplateAction.new()
		var template_action_property_list := template_actions[i].get_property_list().duplicate()
		for p in template_action_property_list:
			if p.usage & PROPERTY_USAGE_CATEGORY != 0:
				continue
			if p.name == "script" and template_actions[i]._hide_script_from_inspector():
				continue
			if p.name not in ["tag"]:
				#p.name = "details_%s/%s" % [i, p.name] # For some reason, if there is no number in the sub-group name, inspector mess up the folding
				p.name = "details/" + p.name
			p.name = "template_action_%s/%s" % [i, p.name]
			properties.append(p)
	return properties

func _set(property: StringName, value: Variant):
	if property == "template_action_count":
		template_actions.resize(value)
		property_list_changed.emit()
	elif property.begins_with("template_action_"):
		var slash_pos := property.find("/")
		var i := property.substr(0, slash_pos).trim_suffix("target_file_").to_int()
		property = property.substr(slash_pos + 1)
		if property.begins_with("details"):
			slash_pos = property.find("/")
			property = property.substr(slash_pos + 1)
		if template_actions[i] == null:
			template_actions[i] = CodeGeneratorTemplateAction.new()
		template_actions[i].set(property.substr(property.find("/") + 1), value)

func _get(property: StringName) -> Variant:
	if property == "template_action_count":
		return template_actions.size()
	elif property.begins_with("template_action_"):
		var slash_pos := property.find("/")
		var i := property.substr(0, slash_pos).trim_suffix("target_file_").to_int()
		property = property.substr(slash_pos + 1)
		if property.begins_with("details"):
			slash_pos = property.find("/")
			property = property.substr(slash_pos + 1)
		if template_actions[i] == null:
			return null
		return template_actions[i].get(property)
	return null

func _hide_script_from_inspector():
	return true

