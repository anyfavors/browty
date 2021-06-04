#!/bin/sh

if [ "x${BASE}" == "x" ]; then
  BASE="/"
fi

if [ "x${REMOTE_SSH_SERVER}" == "x" ]; then
  # Login mode, no SSH_SERVER
  npm start -- -p ${WETTY_PORT}
else
  # SSH connect mode
  #
  # Preload key
  mkdir ~/.ssh && \
  ssh-keyscan -H -p ${REMOTE_SSH_PORT} ${REMOTE_SSH_SERVER} > ~/.ssh/known_hosts

  cmd="npm start -- -p ${WETTY_PORT} --ssh-host ${REMOTE_SSH_SERVER} --ssh-port ${REMOTE_SSH_PORT} --base ${BASE} --ssh-config /etc/ssh/ssh_config" 
  if ! [ "x${REMOTE_SSH_USER}" == "x" ]; then
    cmd="${cmd} --ssh-user ${REMOTE_SSH_USER}"
  fi 
  if ! [ "x${SSH_AUTH}" == "x" ]; then
    cmd="${cmd} --ssh-auth ${SSH_AUTH}"
  fi
  if ! [ "x${KNOWN_HOSTS}" == "x" ]; then
    cmd="${cmd} --known-hosts ${KNOWNHOSTS}"
  fi
  if ! [ "x${SSH_KEY}" == "x" ]; then
    cmd="${cmd} --ssh-key ${SSH_KEY}"
  fi
  su -c "${cmd}" node
fi
