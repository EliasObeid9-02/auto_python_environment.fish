function handle_type_venv --description "Function to search possible virtual environment directories and activate them."
	# iterate over the possible directory names for virtual environments
	for directory in $_python_venv_order
		set --local activation_path	"$directory/bin/activate.fish"
		if test -e $activation_path
			source $activation_path &>/dev/null
			return 0
		end
	end
	return 1
end

function handle_type_poetry --description "Function to handle activating a poetry based virtual enviornment"
	set --local poetry_cmd	(command -v poetry)

	if test -z $poetry_cmd
		return 1
	end

	# this command checks for the existence of a 'pyproject.toml' file created using poetry
	$poetry_cmd check &>/dev/null

	if test $status -eq 0
		# if the file exists then we can activate the environment
		set --local env_path		($poetry_cmd env info --path)
		set --local activation_path	"$env_path/bin/activate.fish"
		source $activation_path &>/dev/null
	end
end

function deactivate_environment --description "Deactivates the currently active Python environment."
	# check if there is an active virtual environment
	# by checking for the existence of 'VIRTUAL_ENV' variable
	set	--query	VIRTUAL_ENV

	if test $status -eq 0
		# if the variable is present then we can deactivate the environment
		# by calling the 'deactivate' function
		deactivate &>/dev/null
	end
end

function activate_environment --argument-names starting_directory --description "Moves through the ancestor directories until it finds a directory which has the virtual environment files"
	set --local current_path	(realpath $starting_directory)
	while true
		# variable to check whether we found an environment or not
		set	--local	environment_found	false

		for env_type in $_python_env_order
			switch $env_type
				case venv
					handle_type_venv
				case poetry
					handle_type_poetry
				# case conda
				#	
			end

			if test $status -ne 0
				set --local environment_found true
			end
		end

		# the environment has been found and activated
		if test $environment_found
			break
		end

		# check if the current directory is root, in this case we terminate
		# the search because we haven't found a virtual environment
		if test $current = "/"
			break
		end

		# go to the parent directory
		set --local current_path	(realpath "$current_path/..")
	end
end

function _auto_python_environment --on-variable PWD --description "Automatically activates the first Python environment that is found in the ancestors to the current directory."
	deactivate_environment
	activate_environment $PWD
end
