function _auto_python_environment_install --on-event auto_python_environment_install
	set --universal --export _python_env_order		"venv" "poetry"
	set	--universal --export _python_venv_order		".venv" "venv"
end

function _auto_python_environment_uninstall --on-event auto_python_environment_uninstall
	set --erase _python_env_order
    set --erase _python_venv_order
end

_auto_python_environment
