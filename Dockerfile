# code_aster 18.1.0 (official image by Simvia), set up for root logins on rented machines.
# The official image runs as "user" and activates code_aster only in that user's ~/.bashrc;
# hosts like Vast.ai log in as root over SSH.
FROM simvia/code_aster:18.1.0

USER root
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server rsync \
    && rm -rf /var/lib/apt/lists/* \
    # activate code_aster for every root shell, then stop non-interactive shells (Debian's root .bashrc has no
    # such guard, so the host's tmux auto-attach appended later would break plain "ssh host command")
    && printf 'source /opt/activate.sh\n[ -z "$PS1" ] && return\n' | cat - /root/.bashrc > /tmp/bashrc && mv /tmp/bashrc /root/.bashrc \
    && bash -c "source /opt/activate.sh && command -v run_aster"

# Vast.ai (and similar hosts) add SSH keys at start-up; sshd refuses them if /root has loose modes
RUN chmod 700 /root && mkdir -p /root/.ssh && chmod 700 /root/.ssh \
    && printf "StrictModes no\n" > /etc/ssh/sshd_config.d/10-hosted-keys.conf

WORKDIR /workspace
