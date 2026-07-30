# Round_Robin_Arbiter

A parameterizable **Round Robin Arbiter** implemented in **SystemVerilog** that ensures fair access among multiple requesters while incorporating a **time-threshold based starvation prevention mechanism**.

## Features

- Round Robin arbitration for fair request scheduling.
- Configurable number of requesters.
- Starvation prevention using configurable wait-time threshold.
- Synchronous design suitable for FPGA/ASIC implementation.
- Fully synthesizable RTL.
- Self-checking testbench with multiple arbitration scenarios.

---

## Arbitration Flow

1. Accept incoming request signals.
2. Check whether any requester has exceeded the starvation threshold.
3. If a starving requester exists:
   - Grant the oldest starving request.
4. Otherwise:
   - Continue standard Round Robin arbitration.
5. Update the Round Robin pointer.
6. Reset the granted request's wait counter.
7. Increment wait counters for remaining active requests.

---

## Parameters

| Parameter | Description |
|----------|-------------|
| `NUM_REQ` | Number of requesters |
| `THRESHOLD` | Maximum wait cycles before starvation prevention activates |

---


## Simulation

Using **Icarus Verilog**

```bash
iverilog -g2012 -o sim *.v
vvp sim
```

View waveform

```bash
gtkwave wave.vcd
```

---

## Verification

The testbench verifies:

- Single requester operation
- Multiple simultaneous requests
- Proper Round Robin pointer rotation
- Continuous request scenarios
- Starvation threshold activation
- Counter reset after grant
- Fairness over long simulations

---


## Future Improvements

- Weighted Round Robin arbitration
- Deficit Round Robin scheduling
- Dynamic priority assignment
- QoS-aware arbitration
- Pipelined arbiter implementation
- Formal verification using SystemVerilog Assertions (SVA)

---

## License

This project is released under the MIT License.
