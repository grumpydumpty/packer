# Container Image for HashiCorp packer

## Overview

Provides a container image for running HashiCorp packer.

This image includes the following components:

| Component                        | Version | Description                                                                                              |
|----------------------------------|---------|----------------------------------------------------------------------------------------------------------|
| VMware Photon OS                 | 4.0     | A Linux container host optimized for vSphere and cloud-computing platforms.                              |
| HashiCorp Packer                 | 1.8.6   | Packer is an open source image creation tool.                                                            |
| Packer Plugin for VMware vSphere | 1.1.1   | Packer Plugin that uses the vSphere API to creates virtual machines remotely, starting from an ISO file. |

## Get Started

Run the following to download the latest container from Docker Hub:

```bash
docker pull harbor.sydeng.vmware.com/rcroft/packer:latest
```

Run the following to download a specific version from Docker Hub:

```bash
docker pull harbor.sydeng.vmware.com/rcroft/packer:x.y.z
```

Open an interactive terminal:

```bash
docker run --rm -it harbor.sydeng.vmware.com/rcroft/packer console
```

Run a local plan:

```bash
 cd /path/to/tf/files
docker run --rm -it --name packer -v $(pwd):/tmp -w /tmp harbor.sydeng.vmware.com/rcroft/packer init
docker run --rm -it --name packer -v $(pwd):/tmp -w /tmp harbor.sydeng.vmware.com/rcroft/packer validate
docker run --rm -it --name packer -v $(pwd):/tmp -w /tmp harbor.sydeng.vmware.com/rcroft/packer fmt
docker run --rm -it --name packer -v $(pwd):/tmp -w /tmp harbor.sydeng.vmware.com/rcroft/packer build
```

Where `/path/to/tf/files` is the local path for your packer scripts.
