# Getting Started

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
