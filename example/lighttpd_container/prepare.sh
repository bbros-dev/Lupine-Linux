#!/bin/bash

cd lighttpd_container || exit 1

podman build -t lighttpd .

cd .. || exit 1

echo "[+OK] $PWD lighttpd example podman build complete"

cd ../docker || exit 1

podman build -t linuxbuild -f build-env.Dockerfile .

echo "[+OK] $PWD linuxbuild podman image built -\> compiles linux..."

cd .. || exit 1

./scripts/build-with-configs.sh configs/lupine-djw-kml.config configs/apps/general.config

echo "[+OK] $PWD built kernel .."


./scripts/image2rootfs.sh lighttpd latest ext2

echo "[+OK] $PWD built rootfs ..."

./scripts/firecrackerd.sh &

sleep 2

echo "[+OK] $PWD Started firecracker daemon ..."

./scripts/firecracker-run.sh kernelbuild/lupine-djw-nokml++general/vmlinux lighttpd.ext2 /bin/guest_init.sh

sleep 2

IP="192.168.100.1/24"
ip l set tap100 up
ip a add $IP dev tap100

echo "[+OK] firecrackerd started, tap100 up with ip $IP"

echo "[+OK] guest spawned :\).... hoping for best"
echo "[INF] check console output or ping / curl 192.168.100.2 ..."
echo "[INF] if you are done, $ killall firecracker"
