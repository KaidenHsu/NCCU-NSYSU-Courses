#!/bin/bash
# Publish the initial sequence with intentional errors and correct events
topics=("CO" "random" "CF" "another" "DO" "DF")
for t in "${topics[@]}"
do
    mosquitto_pub -h localhost -t EVENT -m "$t"
    sleep 1
done