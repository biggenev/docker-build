#!/bin/bash
sed "s/tagVersion/$1/g" deployment.yaml > node_deployment.yaml