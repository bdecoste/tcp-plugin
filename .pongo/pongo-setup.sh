#!/usr/bin/env sh

# this runs in the test container upon starting it

set -x

luarocks install bit32
luarocks install lua-cjson
luarocks install lua_pack 2.0.0
luarocks install lua-resty-openssl 0.8.2-1

cd /kong-plugin

# install public dependencies
find /kong-plugin -maxdepth 1 -type f -name '*.rockspec' -exec luarocks install --only-deps {} \;

