#!/bin/bash
set -e

echo "starting SSH ..."
service ssh start
echo "ssh started."

echo "starting nginx..."
service nginx start
echo "nginx started."


