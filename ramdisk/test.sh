#!/system/bin/sh

mount -o remount,rw /
mkdir /debug
mount -t debugfs debugfs /debug

echo "Get all online clk"
for f in /debug/clk/*; do grep -q 1 $f/enable && echo $f; done

echo "Get all online regulators"
for f in /debug/regulator/*; do grep -q 1 $f/enable && echo $f; done

echo "done"
