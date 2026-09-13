#!/usr/bin/env python3
"""Copy compose/init to the Docker host, wipe the volume, and start a fresh DB."""

from __future__ import annotations

import argparse
import os
import subprocess
from pathlib import Path


def run(args: list[str]) -> None:
    print("+", " ".join(args))
    subprocess.run(args, check=True)


def ssh_powershell(remote: str, command: str) -> None:
    # Remote OpenSSH uses cmd.exe, so the PowerShell command must be one
    # quoted string. Otherwise `|` is handled by cmd, not PowerShell.
    run(
        [
            "ssh",
            remote,
            f'powershell -NoProfile -Command "{command}"',
        ]
    )


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Redeploy Postgres with a wiped volume so init schema/seed run again.",
    )
    parser.add_argument("--host", default="192.168.0.45")
    parser.add_argument(
        "--user",
        default=os.environ.get("DOCKER_HOST_USER", "user"),
    )
    parser.add_argument(
        "--remote-dir",
        default="C:/docker/dicejobmanager-postgres",
    )
    args = parser.parse_args()

    compose = Path("docker-compose.yml")
    init_dir = Path("init")
    if not compose.is_file() or not init_dir.is_dir():
        raise SystemExit(
            "Run this from the dicejobmanager-postgres folder "
            "(docker-compose.yml and init/ must exist)."
        )

    remote = f"{args.user}@{args.host}"
    remote_dir = args.remote_dir

    print(f"Recreating Postgres on {remote}")
    ssh_powershell(
        remote,
        f"New-Item -ItemType Directory -Force -Path '{remote_dir}' | Out-Null",
    )
    run(["scp", str(compose), f"{remote}:{remote_dir}/docker-compose.yml"])
    run(["scp", "-r", str(init_dir), f"{remote}:{remote_dir}/init"])
    ssh_powershell(
        remote,
        f"Set-Location '{remote_dir}'; docker compose down -v; docker compose up -d",
    )
    print(f"Postgres: {args.host}:5432 database dicejobmanager")


if __name__ == "__main__":
    main()
