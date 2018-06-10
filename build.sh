#!/bin/bash
docker build . -t tanaka9230/`cat imagetag`
docker images
