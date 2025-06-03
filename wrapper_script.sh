#!/bin/bash

# Delete port files if they exist
POCKET_IC_PORT="pocket-ic-port"
if [ -f "$POCKET_IC_PORT" ]; then
    rm "$POCKET_IC_PORT"
fi

POCKET_IC_PROXY_PORT="pocket-ic-proxy-port"
if [ -f "$POCKET_IC_PROXY_PORT" ]; then
    rm "$POCKET_IC_PROXY_PORT"
fi

# Start pocket-ic server
/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port 8081 --port-file "$POCKET_IC_PORT" --ttl 2592000 &

# Start pocket-ic gateway
/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port 8082 --port-file "$POCKET_IC_PROXY_PORT" --ttl 2592000 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
