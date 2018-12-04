# Dimming examples (experimental)

@note The example is not supported by the nRF52810 Series.

This demo project consists of two examples: the dimming server and the dimming client.
In addition, it requires the provisioner example that is provided as part of the `light_switch` examples
or `nRF Mesh` mobile app.

@note
This example is experimental, meaning it is ready for use, but not qualified.

## Hardware requirements

- One development board for the client.
- One development board for the provisioner or `nRF Mesh` mobile app (iOS or Android).
- One or more development boards for the servers.
  If you have more than thirty boards for the servers, set `SERVER_NODE_COUNT` (in `light_switch_example_common.h`)
  to the number of boards available and rebuild the provisioner example.

See [Compatibility](@ref md_doc_introduction_mesh_compatibility) for information about the supported boards.

@note This example uses the PWM peripheral for dimming. Therefore, it cannot be run on nRF51 devices.

## Running the demo

To build the examples, follow the instructions in
[Building the Mesh Stack](@ref md_doc_getting_started_how_to_build). For commands required to program a device using `nrfjprog`,
see the [Running examples using nrfjprog](@ref how_to_run_examples_nrfjprog) section on the @ref md_doc_getting_started_how_to_run_examples page.

To run the examples, the boards must be provisioned first. It can be done using either
[the development board](@ref dimming_prov_prov_example) or [nRF Mesh mobile app](@ref dimming_prov_nrf_mesh).

#### Provisioning using the development board @anchor dimming_prov_prov_example

1. Erase the device flash of your development boards and program the SoftDevice.
2. Flash the provisioner firmware on one board, the client firmware on another board,
and the server firmware on the remaining boards.
3. After a reset, press Button 1 on the provisioner to start the provisioning and configuration of the
   devices. The provisioner first provisions and configures the client and then moves on to provision and configure the servers, one by one.
4. Use the [RTT](@ref segger-rtt) viewer to view the RTT output generated by the provisioner.

The provisioner prints details about the provisioning and the configuration process in the RTT log.
While the provisioner is scanning and provisioning a device, LED 1 on the provisioner board is turned ON.
During configuration, LED 2 on the provisioner board is turned ON.

The provisioner configures the two client model instances on the client board to communicate with the
Odd and Even server groups.

If the provisioner encounters an error during the provisioning or configuration process for one of the nodes,
you can reset the provisioner to restart the process for that node.

### Provisioning using nRF Mesh mobile app @anchor dimming_prov_nrf_mesh

1. Erase the device flash of your development boards and program the SoftDevice.
2. Flash the client firmware on one board and the server firmware on the remaining boards.
3. Download the `nRF Mesh` app for your mobile phone (iOS or Android).
4. Provision the nodes. The client board has name `nRF5x Mesh Dimmer`,
the server board has name `nRF5x Mesh Dimmable Light`.
5. Bind the Generic Level client and server model instances on the nodes with the same app key.
6. Set the publish address of the 1st Generic Level client model instance on the client example to
the unicast address of any server node.

### Testing

When provisioning and configuration of the client node and at least one of the server nodes is completed,
you can send numbers using the RTT viewer and see the dimming action on LED 1 of the server boards.

To do that, connect the RTT viewer to the dimming client to control the dimming level.
Three message types are demonstrated: Set, Delta Set, and Move Set. The RTT
input is used to emulate the button numbers `0` to `6`, so to send level messages, you send
numbers from `0` to `6` via the RTT viewer.

The client example is configured as follows:

- RTT inputs `1`/`3`/`5` increase the internal target level value parameters in large steps.
- RTT inputs `0`/`2`/`4` decrease the internal target level value parameters in large steps.

- RTT inputs `0` and `1` cause the client to send a Generic Level Set message.
- RTT inputs `2` and `3` cause the client to send a Generic Level Delta Set message.
- RTT inputs `4` and `5` cause the client to send a Generic Level Move Set message.
- RTT input `6` cause the client to switch between Odd or Even group nodes.

> **Note:** If you use the buttons on the DK instead of RTT input, you can only send Set and Delta Set messages.
> You cannot send Move message or switch between Odd or Even groups.

You can also connect the RTT viewer to one of the servers and send `0` or `1` to locally increase or decrease
the brightness of their LED 1 in steps.
Observe the corresponding status printed in the RTT log of the client board.

> **Note:** You cannot use buttons on the server boards since dimming server does not use `simple_hal`
> module.

If any of the devices are powered off and back on, they remember their configuration
in flash and rejoin the network. More information about the flash manager can be found
in the [flash manager documentation](@ref md_doc_libraries_flash_manager).

## Details

The demonstration consists of two example applications that use the Generic Level Client/Server model.

### Dimming client

The *dimming client* has a provisionee role in the network.
The client accepts RTT inputs from `0` to `6` to control the state of LED 1 on the servers.
It instantiates two instances of the Generic Level Client model.
It can either be provisioned and configured by the provisioner device or by
a GATT-based provisioner.
The provisioner configures this client model instances to communicate with the
servers.

### Dimming server

The *dimming server* has a provisionee role in the network. It instantiates one instance
of the Generic Level server model to control the state of LED 1. It uses the APP_PWM library of the nRF5 SDK
to control the brightness of the LED. It can either be provisioned and configured
by the provisioner device or by a GATT-based provisioner.The provisioner configures this
server model instance to communicate with the client model on the client board and to publish a message
when the value of the Level state changes.

The examples are based on the Generic Level model, which works with signed 16-bit level values.
Therefore, the dimming server maps this range on the allowed range of PWM tick values.
As a consequence, sending a level model message that sets the target level to zero results in a 50%
duty cycle on the PWM output when the target level is reached.

### Generic Level Client/Server model

The Generic Level Client/Server is used for manipulating the
Level state. Note that when the server has a publish address set (as in this example),
the server publishes information about any state changes to its publish address.

More information about the Generic Level model can be found in the
[Generic Level model documentation](@ref GENERIC_LEVEL_MODEL)
and the [Generic Level server behaviour documentation](@ref APP_LEVEL).