#!/usr/bin/env bash
# Customize the logic of the pull step of the main part
#
# Copyright 2024 林博仁(Buo-ren Lin) <buo.ren.lin@gmail.com>
# SPDX-License-Identifier: MIT

printf \
    'Info: Configuring the defensive interpreter behaviors...\n'
set_opts=(
    # Terminate script execution when an unhandled error occurs
    -o errexit
    -o errtrace

    # Terminate script execution when an unset parameter variable is
    # referenced
    -o nounset
)
if ! set "${set_opts[@]}"; then
    printf \
        'Error: Unable to configure the defensive interpreter behaviors.\n' \
        1>&2
    exit 1
fi

printf \
    'Info: Setting the ERR trap...\n'
if ! trap 'printf "Error: The program has encountered an unhandled error and is prematurely aborted.\\n" 1>&2' ERR; then
    printf \
        'Error: Unable to set the ERR trap.\n' \
        1>&2
    exit 1
fi

printf 'Info: Running the default logic for the pull step...\n'
if ! craftctl default; then
    printf \
        'Error: Unable to run the default logic for the pull step.\n' \
        1>&2
    exit 2
fi

printf 'Info: Detecting the version string of the main part...\n'
if ! upstream_version_string_raw="$(
    git describe \
        --always \
        --tags \
        --dirty
    )"; then
    printf \
        'Error: Unable to detect the raw upstream version string of the main part.\n' \
        1>&2
    exit 2
fi
upstream_version_string="${upstream_version_string_raw#v}"
printf \
    'Info: Upstream version string of the main part determined to be "%s".\n' \
    "${upstream_version_string}"

printf 'Info: Determining the packaging version string...\n'
if ! packaging_version_string="$(
    git -C "${CRAFT_PROJECT_DIR}" describe \
        --always \
        --abbrev=4
    )"; then
    printf \
        'Error: Unable to determine the packaging version string.\n' \
        1>&2
    exit 2
fi
printf \
    'Info: Packaging version string determined to be "%s".\n' \
    "${packaging_version_string}"

printf 'Info: Determining the snap version string...\n'
snap_version_string="${upstream_version_string}+s${packaging_version_string}"
printf \
    'Info: Snap version string determined to be "%s".\n' \
    "${snap_version_string}"

printf \
    'Info: Setting the version property of the snap metadata...\n'
if ! craftctl set version="${snap_version_string}"; then
    printf \
        'Error: Unable to set the version property of the snap metadata.\n' \
        1>&2
    exit 2
fi

printf 'Info: Operation completed successfully.\n'
