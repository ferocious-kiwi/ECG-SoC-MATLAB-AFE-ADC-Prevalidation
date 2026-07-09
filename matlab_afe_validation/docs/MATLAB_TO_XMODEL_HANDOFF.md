# MATLAB-to-XMODEL Handoff Document

This document defines the MATLAB reference outputs that should be used for MATLAB-vs-XMODEL equivalence verification.
It does **not** claim that MATLAB and XMODEL are already bit-exact equivalent.

## MATLAB Role

The MATLAB stage serves as a nominal system-level pre-validation and reference-generation step before SystemVerilog XMODEL implementation.
It verifies schematic-derived AFE filter parameters, ADC headroom, code mapping, and reference output vectors for representative ECG inputs.
Circuit-level non-idealities and mixed-signal behavioral robustness are evaluated in the subsequent XMODEL verification stage.

## Block Order

```text
input ECG voltage [V]
→ HPF 0.482 Hz
→ Instrumentation amplifier ×201
→ 60 Hz notch, Q≈5
→ LPF 150 Hz
→ ADC saturation check, ±1.65 V
→ 12-bit offset-binary code
→ signed decimal stream
```

## Units and Sampling

| Item | Value |
|---|---:|
| Sampling rate | 1 kSPS |
| Input unit | V |
| Stage output unit | V |
| ADC voltage range | ±1.65 V |
| ADC output | 12-bit offset-binary, 0-4095 |
| Signed stream | offset-binary − 2048 |

## Reference Vector Locations

```text
reference_vectors/NSR/
reference_vectors/CHF/
reference_vectors/ARR/
reference_vectors/AFF/
reference_vectors/reference_vector_manifest.csv
reference_vectors/reference_vector_manifest.md
```

Each case contains:

```text
input.csv
matlab_stage_outputs.csv
adc_offset_binary.mem
adc_signed.txt
```

## Recommended XMODEL Comparison Metrics

| Metric | Target / Comment |
|---|---|
| waveform alignment | lag = 0 sample |
| RMS error | preferably 2-3 LSB or lower after convention matching |
| max absolute error | inspect outliers |
| correlation | 0.99 or higher recommended |
| ADC code convention | identical offset-binary/signed convention |
| final signed stream | same convention maintained |

## Non-Claims

This MATLAB package does not claim transistor-level, PCB-level, silicon-level, clinical validation, op-amp non-ideality verification, CMRR verification, ADC non-ideal robustness, or MATLAB-vs-XMODEL bit-exact equivalence completion.
