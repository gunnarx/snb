#!/bin/sh -xe

# Build in a repeatable container environment

# NOTE: This could have run a container directly from ubuntu:latest
# and then exec each build command, but with a Dockerfile we get caching of
# each step and don't need to repeat all the steps if something goes wrong.

sudo=sudo  # If your group is not set up correctly to be privileged for docker/podman
#frontend=docker
frontend=podman
imgname=snb_build_container_image
cname=snb_build_container.$$

$sudo $frontend build -t $imgname .
$sudo $frontend run --name $cname $imgname
$sudo $frontend cp $cname:/snb/bin .
$sudo $frontend stop $cname
$sudo $frontend rm -f $cname
set +x
echo Result copied to ./bin
ls -l bin/
promt -p "Remove container image? (y/n) " x
[ "$x" = "y" ] && sudo $frontend rmi $imgname

