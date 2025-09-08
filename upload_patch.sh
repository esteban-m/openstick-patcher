#!/bin/bash

echo "=== Upload clean image ==="
edl wf initial.bin

echo "=== Upload aboot patch ==="
edl w aboot patch/aboot.mbn

echo "=== Reboot ==="
edl e boot
edl reset

echo "=== Get board model ==="
model=$(fastboot getvar lk2nd:model 2>&1 | sed -n 's/.*lk2nd:model: \([^ ]*\).*/\1/p')
echo "Board: $model"

echo "=== Upload patch ==="
fastboot flash partition patch/gpt_both0.bin
fastboot flash aboot patch/aboot.mbn
fastboot flash hyp patch/hyp.mbn
fastboot flash rpm patch/rpm.mbn
fastboot flash sbl1 patch/sbl1.mbn
fastboot flash tz patch/tz.mbn
fastboot flash boot patch/boot.bin
fastboot flash rootfs patch/rootfs.bin

echo "=== Upload stock ==="
for n in fsc fsg modem modemst1 modemst2 persist sec; do
    fastboot flash ${n} stock/${model}/${n}.bin
done

echo "=== Reboot ==="
fastboot reboot

echo "=== Done ==="