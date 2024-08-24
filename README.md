# Auto Python Environment
Fish shell plugin that automatically sources `Python` virtual environment files upon directory changes.

## Installation
You can install this plugin using the [fisher](https://github.com/jorgebucaran/fisher) plugin manager by running the following command:
```fish
fisher install EliasObeid9-02/auto_python_environment.fish
```

You can install the package manually by cloning the git repo using the command:
```fish
git clone https://github.com/EliasObeid9-02/auto_python_environment.fish
```
and copying the files in `conf.d` and `functions` directories into the same directories in your fish config directory.

> the plugin can be installed using other types of plugin managers but it hasn't been tested officialy.

## Configuring
You can configure the plugin by changing the value of two environment variables:

1. `_python_env_order`: changing the value of this variable specifies the order in which the virtual environment files are searched. Default value is `"venv" "poetry"` which means it looks for `venv` files first then `poetry` files. Accepted values are `venv` and `poetry`.

2. `_python_venv_order`: changing the value of this variable specfies the name of the directories that the plugin will inside to check whether the directory exists and contains the virtual environment files. Default values is `".venv" "venv"`. The variables accepts custom names, for example if on your system your environments are always in a directory called `py_env` then you can set the value of this variable to "py_env"

You can change the two variables using the `set` command from `fish` inside your `config.fish` file. Examples:

```fish
set --universal --export _python_env_order "venv"
set --universal --export _python_venv_order "py_env"
```
