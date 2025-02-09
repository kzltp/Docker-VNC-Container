FROM debian:12

ENV REFRESHED_AT=2025-02-09
LABEL maintainer="kzltpsgm@gmail.com"

LABEL io.k8s.description="Headless VNC Container with Xfce window manager, firefox, chromium, and SFTP" \
      io.k8s.display-name="Headless VNC Container based on Debian with SFTP" \
      io.openshift.expose-services="6901:http,5901:xvnc,22:ssh" \
      io.openshift.tags="vnc, debian, xfce, sftp" \
      io.openshift.non-scalable=true

## Connection ports
ENV DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    SFTP_PORT=22
EXPOSE $VNC_PORT $NO_VNC_PORT $SFTP_PORT

### Environment config
ENV HOME=/headless \
    TERM=xterm \
    STARTUPDIR=/dockerstartup \
    INST_SCRIPTS=/headless/install \
    NO_VNC_HOME=/headless/noVNC \
    DEBIAN_FRONTEND=noninteractive \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1280x1024 \
    VNC_PW=vncpassword \
    VNC_VIEW_ONLY=false
WORKDIR $HOME

### Add all install scripts
ADD ./src/common/install/ $INST_SCRIPTS/
ADD ./src/debian/install/ $INST_SCRIPTS/

### Install common tools
RUN $INST_SCRIPTS/tools.sh
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

### Install custom fonts
RUN $INST_SCRIPTS/install_custom_fonts.sh

### Install xvnc-server & noVNC
RUN $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/no_vnc.sh

### Install firefox and chrome
RUN $INST_SCRIPTS/firefox.sh

### Install xfce UI
RUN $INST_SCRIPTS/xfce_ui.sh
ADD ./src/common/xfce/ $HOME/


### Configure startup
RUN $INST_SCRIPTS/libnss_wrapper.sh
ADD ./src/common/scripts $STARTUPDIR
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME


### Install SSH server
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    ssh-keygen -A && \
    echo "root:rootpassword" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "export VISIBLE=now" >> /etc/profile


RUN mkdir -p /headless/Desktop/UploaddedFiles
### Start VNC and SSH on container startup
ENTRYPOINT ["/dockerstartup/vnc_startup.sh"]
CMD ["--wait", "&&", "/usr/sbin/sshd", "-D"]### Start VNC and SSH on container startup
