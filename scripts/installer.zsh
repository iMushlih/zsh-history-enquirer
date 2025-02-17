#!/usr/bin/env zsh

# bash strict mode (https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425)
set -xo pipefail

local package_name="zsh-history-enquirer"

# install via nvm if node not found
if [[ ! $commands[node] ]]; then
  if [[ -z "${NVM_DIR}" ]]; then
    NVM_DIR="$HOME/.nvm"
  fi

  if [[ ! -d ${NVM_DIR} ]]; then
    # https://github.com/nvm-sh/nvm
    set +x
    echo '[info] not found node or nvm, will install them'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    set -x
  fi

  export NVM_DIR="$HOME/.nvm"
  \. "$NVM_DIR/nvm.sh"  # This loads nvm

  # install node lts if nvm haven't default version
  if ! nvm list default; then
    nvm install --lts
  fi

  nvm use default
fi

# access to install for root
# use `--unsafe-perm` for compatible with npm@6 in root
# https://stackoverflow.com/questions/49084929/npm-sudo-global-installation-unsafe-perm
# https://docs.npmjs.com/cli/v6/using-npm/config#unsafe-perm
npm i -g ${package_name} --unsafe-perm
echo 'source `npm root -g`/zsh-history-enquirer/scripts/zsh-history-enquirer.plugin.zsh' >> ~/.zshrc
