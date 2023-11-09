FROM photon:5.0

# set argument defaults
ARG OS_ARCH="amd64"
ARG PACKER_VERSION="1.9.4"
ARG VSPHERE_PLUGIN_VERSION="1.2.2"
ARG USER=vlabs
ARG USER_ID=1280
ARG GROUP=users
ARG GROUP_ID=100
#ARG LABEL_PREFIX=com.vmware.eocto

# add metadata via labels
#LABEL ${LABEL_PREFIX}.version="0.0.1"
#LABEL ${LABEL_PREFIX}.git.repo="git@gitlab.eng.vmware.com:sydney/commonpool/containers/packer.git"
#LABEL ${LABEL_PREFIX}.git.commit="DEADBEEF"
#LABEL ${LABEL_PREFIX}.maintainer.name="Richard Croft"
#LABEL ${LABEL_PREFIX}.maintainer.email="rcroft@vmware.com"
#LABEL ${LABEL_PREFIX}.maintainer.url="https://gitlab.eng.vmware.com/rcroft/"
#LABEL ${LABEL_PREFIX}.released="9999-99-99"
#LABEL ${LABEL_PREFIX}.based-on="photon:5.0"
#LABEL ${LABEL_PREFIX}.project="containers"

# update repositories, install packages, and then clean up
RUN tdnf update -y && \
    tdnf install -y wget tar git shadow unzip && \
    # add user/group
    useradd -u ${USER_ID} -g ${GROUP} -m ${USER} && \
    chown -R ${USER}:${GROUP} /home/${USER} && \
    # add /workspace and give user permissions
    mkdir -p /workspace && \
    chown -R ${USER}:${GROUP} /workspace && \
    # set git config
    echo -e "[safe]\n\tdirectory=/workspace" > /etc/gitconfig && \
    # download and install packer
    wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_${OS_ARCH}.zip && \
    unzip -o -d /usr/local/bin/ packer_${PACKER_VERSION}_linux_${OS_ARCH}.zip && \
    packer plugins install github.com/hashicorp/vsphere v${VSPHERE_PLUGIN_VERSION} && \
    rm packer_${PACKER_VERSION}_linux_${OS_ARCH}.zip && \
    # clean up
    tdnf erase -y unzip shadow && \
    tdnf clean all

# set user
USER ${USER}

# set working directory
WORKDIR /workspace

# set entrypoint to packer, not a shell
ENTRYPOINT ["packer"]

#############################################################################
# vim: ft=unix sync=dockerfile ts=4 sw=4 et tw=78:
