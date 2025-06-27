# Baseline TSML Dev Instance

A small Docker config for running WordPress with TSML plugin locally, that also supports XDebug step debugging.

## Requirements

- [Docker Desktop](https://www.docker.com/get-started/)

## Steps

1. Clone repo (*obviously*)
2. In root folder run this to checkout the TSML child repo:

    ```bash
    git submodule init
    git submodule update
    ```
    This folder will end up living at `/var/www/html/wp-content/plugins/12-step-meeting-list` in the client Docker container

3. In root folder, run this to start the docker containers:

    ```
    docker compose up -d
    ```

4. Site will be available at https://localhost:8080/. You should be able to login https://localhost:8080/wp-admin/ with `admin` / `admin` for username and password.

5. **Note:** Currently you still have to activate the **12-step-meeting-list** plugin in a new install. (http://localhost:8080/wp-admin/plugins.php - Activate the 12 Step Meeting List plugin).

## Development

MySQL is available to connect with your SQL GUI of your choice (ala [DBeaver](https://dbeaver.io/) or [HeidiSQL](https://www.heidisql.com/)). Connection settings should be standard, and based on the `.env` file:
- localhost:3306
- user: `wpdb`
- pwd: `wpdb`
- db: `wpdb`

To use xDebug step debugging with Visual Studio Code (ability to pause at breakpoints during execution):

1. Install **[PHP Debug](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug)** VS Code extension
2. Press Ctrl+Shift+P, find and select "**Debug: Add Configuration...**". If you have saved a Code Workspace, this will open your workspace settings JSON, otherwise it'll open a `/.vscode/launch.json`. Here's what the new entry should look like:

     ```json
     {
         "type": "php",
         "request": "launch",
         "name": "Listen for XDebug",
         "pathMappings": {
             "/var/www/html/wp-content/plugins/12-step-meeting-list": "${workspaceFolder}/12-step-meeting-list"
         },
         "xdebugSettings": {
             "max_children": 999
         },
         "port": 9003,
         "log": true
     }
     ```
 3. After that, you can add some breakpoints in 12-step-meeting-list code, and if you run the new debug setting from the debug menu and execute the code line with a breakpoint, it should pause execution and highlight the line in the code to display runtime context.
