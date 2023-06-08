@tool
class_name CodeGenerator extends Object

enum CommentHandling {
	REMOVE_AND_STRIP_WHITESPACES,
	REMOVE_AND_KEEP_WHITESPACES,
	KEEP_AS_COMMENT,
}

enum PrefixHandling {
	REPEAT_WHITESPACES_ONLY,
	REPEAT_NON_WHITESPACES_ALSO,
}

enum SuffixHandling {
	PUT_TO_END_OF_LAST_LINE,
	PUT_TO_NEW_LINE,
	PUT_TO_NEW_LINE_WITH_ADDITIONAL_IDENT,
	KEEP_IN_FIRST_LINE,
	REPEAT,
}

class _Tracking:
	var specification: CodeGeneratorSpecification
	var context: Object
	var action_methods := { }
	
static func _get_debug_info_log() -> DebugInfoLog:
	return DebugInfo.get_log("CodeGenerator", "Code Generator")
	
static func _process_line(tracking: _Tracking, line: String):
	var log := _get_debug_info_log()
	
	var specification := tracking.specification
	var output := line
	
	log.print_colored(Color.LIGHT_GREEN.to_html(false), "[_process_line] line = %s" % line)
	for action in specification.template_actions:
		var tag_index := line.find(action.tag)
		if tag_index >= 0:
			# Comment handling
			if action.comment_handling == CommentHandling.REMOVE_AND_STRIP_WHITESPACES \
					or action.comment_handling == CommentHandling.REMOVE_AND_KEEP_WHITESPACES:
				var comment_start_index := line.find(specification.comment_start)
				if comment_start_index >= 0 and comment_start_index < tag_index:
					var prefix = line.substr(0, comment_start_index)
					line = line.substr(comment_start_index + specification.comment_start.length())
					if action.comment_handling == CommentHandling.REMOVE_AND_STRIP_WHITESPACES:
						line = line.strip_edges(true, false)
					line = prefix + line
					tag_index = line.find(action.tag)
			# Prefix handling
			var first_line_prefix := line.substr(0, tag_index)
			var suffix := line.substr(tag_index + action.tag.length())
			var prefix: String
			if action.prefix_handling == PrefixHandling.REPEAT_NON_WHITESPACES_ALSO:
				prefix = first_line_prefix
			else:
				# This string creation could be avoided, but made like this, to surely do the same stripping as the internal function
				var stripped_first_line_prefix = first_line_prefix.strip_edges(true, false)
				prefix = first_line_prefix.substr(0, first_line_prefix.length() - stripped_first_line_prefix.length())
			var additional_ident := "\t".repeat(action.additional_indent)
			if tracking.context.has_method(action.action_method):
				var output_lines := (tracking.context.call(action.action_method) as String).split("\n")
				if output_lines.size() == 0:
					output_lines = [""]
				for i in output_lines.size():
					var output_line = output_lines[i]
					# First handle suffixes, as they can rely on, wheteher the line is empty or note
					match action.suffix_handling:
						SuffixHandling.PUT_TO_END_OF_LAST_LINE:
							if i == output_lines.size() - 1:
								output_line += suffix.strip_edges(true, false) if output_line.is_empty() else suffix
						SuffixHandling.PUT_TO_NEW_LINE:
							if i == output_lines.size() - 1:
								if not output_line.ends_with("\n"):
									output_line += "\n"
								output_line += prefix + suffix.strip_edges(true, false)
						SuffixHandling.PUT_TO_NEW_LINE_WITH_ADDITIONAL_IDENT:
							if i == output_lines.size() - 1:
								if not output_line.ends_with("\n"):
									output_line += "\n"
								output_line += prefix + additional_ident + suffix.strip_edges(true, false)
						SuffixHandling.KEEP_IN_FIRST_LINE:
							if i == 0:
								output_line += suffix
						SuffixHandling.REPEAT:
							output_line += suffix.strip_edges(true, false) if output_line.is_empty() else suffix
					# Add prefixes to the line, which already has the suffix
					output_line = (first_line_prefix if i == 0 else prefix) + (additional_ident if i > 0 else "") + output_line
					if i == 0:
						output = output_line
					else:
						output += "\n" + output_line
			else:
				output = specification.comment_start + " CODE GENERATION ERROR: No action method '%s' in context." % action.action_method
			break

	return output

static func generate_source_code(generator_specification: CodeGeneratorSpecification, context: Object) -> String:
	_get_debug_info_log().clear()
	
	var template_path = generator_specification.template if generator_specification.template.is_absolute_path() \
		else generator_specification.resource_path.get_base_dir().path_join(generator_specification.template)

	var tracking = _Tracking.new()
	tracking.specification = generator_specification
	tracking.context = context

	var template_file := FileAccess.open(template_path, FileAccess.ModeFlags.READ)
	var source_code := ""
	while not template_file.eof_reached():
		var line := template_file.get_line()
		var output = _process_line(tracking, line)
		source_code += output + "\n"
	return source_code

