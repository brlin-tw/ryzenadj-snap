# Unofficial snap packaging for RyzenAdj

Provide ready-to-use RyzenAdj software for snap-enabled GNU/Linux distributions.

<https://gitlab.com/brlin/ryzenadj-snap>  
[![The GitLab CI pipeline status badge of the project's `main` branch](https://gitlab.com/brlin/ryzenadj-snap/badges/main/pipeline.svg?ignore_skipped=true "Click here to check out the comprehensive status of the GitLab CI pipelines")](https://gitlab.com/brlin/ryzenadj-snap/-/pipelines) [![GitHub Actions workflow status badge](https://github.com/brlin-tw/ryzenadj-snap/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/ryzenadj-snap/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/gitlab.com/brlin/ryzenadj-snap "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/gitlab.com/brlin/ryzenadj-snap)

## Installation

Currently due to [the missing snapd confinement interface support of writing to the north bridge PCI config space](https://forum.snapcraft.io/t/feature-request-please-implement-interface-for-writing-to-the-pci-config-space/41887) the snap can now only installed using the `devmode` confinement mode by running the following commands in a text terminal:

```bash
snap_install_opts=(
    # Install the snap under devmode confinement
    --devmode

    # Install the version from the beta channel(the snap currently can
    # only be distributed via the beta and edge channels)
    --beta
)
sudo snap install "${snap_install_opts[@]}" ryzenadj
```

## References

The following external material is referenced during the development of this project:

* [FlyGoat/RyzenAdj: Adjust power management settings for Ryzen APUs](https://github.com/FlyGoat/RyzenAdj)  
  Upstream project.

## Licensing

Unless otherwise noted(individual file's header/[REUSE.toml](REUSE.toml)), this product is licensed under [the MIT license](https://opensource.org/license/mit), or any of its recent versions you would prefer.

This work complies to [the REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.
