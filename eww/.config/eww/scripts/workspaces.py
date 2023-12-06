#!/usr/bin/env -S python -u

import json
import os
import socket
import subprocess


def read():
    try:
        # Check monitors
        cp = subprocess.run(
            "hyprctl monitors -j".split(" "), capture_output=True, text=True
        )
        cp.check_returncode()
        monitors = json.loads(cp.stdout)

        # Check workspaces
        cp = subprocess.run(
            "hyprctl workspaces -j".split(" "), capture_output=True, text=True
        )
        cp.check_returncode()
        workspaces = json.loads(cp.stdout)
        # Preprocess workspaces
        tmp = {}
        for workspace in workspaces:
            name = workspace["monitor"]
            id = workspace["id"]
            if name in tmp:
                tmp[name].append(id)
            else:
                tmp[name] = [id]
        workspacesPerMonitor = {k: sorted(v) for k, v in tmp.items()}

        # Merge monitors and workspaces
        results = {}
        for monitor in monitors:
            workspaces = workspacesPerMonitor[monitor["name"]]
            results[monitor["id"]] = {
                "monitorId": monitor["id"],
                "workspaces": workspaces,
                "activeWorkspace": monitor["activeWorkspace"]["id"],
            }

        # Print
        print(json.dumps(results))

    except subprocess.CalledProcessError:
        # TODO: Expected error handling
        return
    except Exception:
        # TODO: Unexpected error handling
        return


if __name__ == "__main__":
    bufsize = 1024
    address = f"/tmp/hypr/{os.environ['HYPRLAND_INSTANCE_SIGNATURE']}/.socket2.sock"

    read()
    with socket.socket(socket.AF_UNIX) as s:
        s.connect(address)
        data = ""
        while True:
            data += s.recv(bufsize).decode("utf-8")
            if data.endswith("\n"):
                read()
                data = ""
