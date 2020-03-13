#!/bin/bash

# ninja light_switch_server_nrf52832_xxAA_s132_7.0.1
# nrfjprog --program ../bin/softdevice/s132_nrf52_7.0.1_softdevice.hex --chiperase
# nrfjprog --program  examples/light_switch/server/light_switch_server_nrf52832_xxAA_s132_7.0.1.hex --sectorerase
# nrfjprog -r

echo "Please enter device role:"

node="node"
prov="provisioner"

read role

if [ $role = $node ]
then
echo "Device is a node"
ninja clean
ninja light_switch_server_nrf52832_xxAA_s132_7.0.1
nrfjprog --program ../bin/softdevice/s132_nrf52_7.0.1_softdevice.hex --chiperase
nrfjprog --program  examples/light_switch/server/light_switch_server_nrf52832_xxAA_s132_7.0.1.hex --sectorerase
nrfjprog -r
elif [ $role = $prov ]
then
echo "Device is a Provisioner"
ninja clean
ninja light_switch_provisioner_nrf52832_xxAA_s132_7.0.1
nrfjprog --program ../bin/softdevice/s132_nrf52_7.0.1_softdevice.hex --chiperase
nrfjprog --program  examples/light_switch/provisioner/light_switch_provisioner_nrf52832_xxAA_s132_7.0.1.hex --sectorerase
nrfjprog -r
else
echo "Invalid device role: $role"
fi