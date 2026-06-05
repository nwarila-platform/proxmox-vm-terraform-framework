#!/usr/bin/env python3
"""Fail when workflow Terraform pins drift from terraform/versions.tf."""

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def required_version() -> str:
    versions_tf = ROOT / "terraform" / "versions.tf"
    text = versions_tf.read_text(encoding="utf-8")
    match = re.search(r'required_version\s*=\s*"=\s*([^"]+)"', text)
    if not match:
        raise SystemExit("could not find exact required_version in terraform/versions.tf")
    return match.group(1).strip()


def workflow_versions() -> list[tuple[Path, int, str]]:
    found: list[tuple[Path, int, str]] = []
    paths = subprocess.check_output(
        ["git", "ls-files", ".github/workflows/*.yml", ".github/workflows/*.yaml"],
        cwd=ROOT,
        text=True,
    ).splitlines()
    for rel_path in sorted(paths):
        path = ROOT / rel_path
        if not path.is_file():
            continue
        for index, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            match = re.search(r'terraform_version:\s*"([^"]+)"', line)
            if match:
                found.append((path, index, match.group(1)))
    return found


def tflint_required_version() -> str:
    tflint_hcl = ROOT / ".tflint.hcl"
    text = tflint_hcl.read_text(encoding="utf-8")
    match = re.search(r'required_version\s*=\s*"=\s*([^"]+)"', text)
    if not match:
        raise SystemExit("could not find exact required_version in .tflint.hcl")
    return match.group(1).strip()


def workflow_tflint_versions() -> list[tuple[Path, int, str]]:
    found: list[tuple[Path, int, str]] = []
    paths = subprocess.check_output(
        ["git", "ls-files", ".github/workflows/*.yml", ".github/workflows/*.yaml"],
        cwd=ROOT,
        text=True,
    ).splitlines()
    for rel_path in sorted(paths):
        path = ROOT / rel_path
        if not path.is_file():
            continue
        for index, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            match = re.search(r'tflint_version:\s*"([^"]+)"', line)
            if match:
                found.append((path, index, match.group(1)))
    return found


def main() -> int:
    expected = required_version()
    mismatches = [
        (path, line, actual)
        for path, line, actual in workflow_versions()
        if actual != expected
    ]
    expected_tflint = tflint_required_version()
    tflint_mismatches = [
        (path, line, actual)
        for path, line, actual in workflow_tflint_versions()
        if actual != expected_tflint
    ]
    if mismatches:
        for path, line, actual in mismatches:
            rel = path.relative_to(ROOT).as_posix()
            print(
                f"{rel}:{line}: terraform_version {actual} != required_version {expected}",
                file=sys.stderr,
            )
    if tflint_mismatches:
        for path, line, actual in tflint_mismatches:
            rel = path.relative_to(ROOT).as_posix()
            print(
                f"{rel}:{line}: tflint_version {actual} != .tflint.hcl required_version {expected_tflint}",
                file=sys.stderr,
            )
    if mismatches or tflint_mismatches:
        return 1
    print(
        "workflow pins match: "
        f"terraform required_version {expected}, tflint required_version {expected_tflint}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
