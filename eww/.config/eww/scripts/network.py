#!/usr/bin/env -S python -u

import json
import subprocess

import jc


def bytes2str(x):
    if x is None:
        return None

    if x < 1024:
        unit = "B"
    elif x < 1024**2:
        x /= 1024
        unit = "KiB"
    elif x < 1024**3:
        x /= 1024**2
        unit = "MiB"
    else:
        x /= 1024**3
        unit = "GiB"
    return "%.1f%s" % (x, unit)


def read():
    try:
        # Check connected interface
        cp = subprocess.run(
            "nmcli device show".split(" "), capture_output=True, text=True
        )
        cp.check_returncode()
        interfaces = jc.parse("nmcli", cp.stdout)
        connectedInterface = None
        for interface in interfaces:
            if "state" in interface and interface["state"] == 100:
                connectedInterface = interface

        type = None
        ssid = None
        received = None  # in bytes
        transmitted = None  # in bytes
        if connectedInterface is not None:
            type = connectedInterface["type"]

            interface = connectedInterface["device"]
            with open("/proc/net/dev", "r") as f:
                stats_all = f.read()
            stats_all = jc.parse("proc", stats_all)
            for stats in stats_all:
                if stats["interface"] == interface:
                    received = stats["r_bytes"]
                    transmitted = stats["t_bytes"]

            if type == "wifi":
                ssid = connectedInterface["connection"]

        print(
            json.dumps(
                {
                    "type": type,
                    "received": bytes2str(received),
                    "transmitted": bytes2str(transmitted),
                    "ssid": ssid,
                }
            )
        )

    except subprocess.CalledProcessError:
        # TODO: Expected error handling
        return
    except Exception:
        # TODO: Unexpected error handling
        return


if __name__ == "__main__":
    read()
    # with subprocess.Popen(
    #     "nmcli monitor".split(" "), stdout=subprocess.PIPE, text=True
    # ) as proc:
    #     while True:
    #         # line = proc.stdout.read(1)
    #         line = proc.stdout.readline()
    #         read()
    #
    #         if not line and proc.poll() is not None:
    #             break
