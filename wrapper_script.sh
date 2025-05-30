#!/bin/bash

# Start pocket-ic server
/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port 8081 --ttl 2592000 &

# Start pocket-ic gateway
/pocket-ic/pocket-ic --ip-addr 0.0.0.0 --port 8082 --ttl 2592000 &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
