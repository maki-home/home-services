#!/bin/sh
echo y | fly -t home sp -p home-services -c pipeline.yml -l ../../credentials.yml