#! /usr/bin/bash
get_windows() {
    # Return all windows in the tree in the following format:
    # {
    #   "id": 1,
    #   "name": "nvim",
    #   "app_id": "kitty",
    #   "shell": "xdg_shell",
    # }
    swaymsg -t get_tree | \
        jq -r '.nodes[]
            | {output: .name, content: .nodes[]}
            | {
                output: .output,
                workspace: .content.name,
                apps: .content
                    | ..
                    | {id: (.id? | tostring), name: .name?, app_id: .app_id?, shell: .shell?}
            }
            | map(select(.app_id? != null or .shell? != null))
            | .[]
            '
}

