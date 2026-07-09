# MATLAB AFE+ADC Validation

This MATLAB package validates the ECG AFE+ADC chain used in the ECG-SoC project.

Report-oriented flow:

```text
Existing AFE schematic values
  -> MATLAB validation of gain / filters / ADC dynamic range
  -> SystemVerilog XModel implementation
  -> mixed-signal integration with SNN accelerator
```

## 1. Recommended official dataset layout

Copy the repository dataset folder into this MATLAB folder:

```text
matlab_afe_validation/
├─ afe_input_dataset/
│  ├─ afe_input_NSR.csv
│  ├─ afe_input_CHF.csv
│  ├─ afe_input_ARR.csv
│  ├─ afe_input_AFF.csv
│  ├─ afe_input_NSR.pwl
│  ├─ afe_input_CHF.pwl
│  ├─ afe_input_ARR.pwl
│  ├─ afe_input_AFF.pwl
│  ├─ afe_input_record100_NSR.csv
│  └─ afe_input_record100_NSR.pwl
└─ *.m
```

CSV format expected:

```text
sample_index, time_s, code_signed, voltage_V
```

PWL format expected:

```text
time[s]    voltage[V]
```

The project scale is:

```text
voltage_V = code_signed / 200000
1 code ≈ 5 uV
fs = 1000 Hz
```

## 2. Main scripts

### Single-record validation

Runs one default input. It first looks for `afe_input_dataset/afe_input_NSR.csv`, then falls back to PWL or older local test inputs.

```matlab
run_afe_adc_validation
```

Results are saved under:

```text
results/
```

### 4-class official dataset batch validation

Runs NSR / CHF / ARR / AFF plus record100_NSR if available.

```matlab
run_afe_dataset_validation
```

Results are saved under:

```text
results_dataset/
├─ NSR/
├─ CHF/
├─ ARR/
├─ AFF/
├─ record100_NSR/
├─ afe_dataset_input_summary.csv
└─ afe_dataset_dynamic_range_summary.csv
```

## 3. AFE+ADC chain

```text
ECG differential input voltage [V]
  -> HPF fc ≈ 0.482 Hz
  -> Instrumentation amplifier gain ×201
  -> 60 Hz notch, Q ≈ 5
  -> LPF fc ≈ 150 Hz
  -> ADC input clamp ±1.65 V
  -> 12-bit offset-binary ADC code
  -> signed 12-bit stream for digital classifier
```

## 4. PWL support

`parse_pwl_file.m` supports:

1. Plain numeric two-column PWL:

```text
0.000000   -0.000145
0.001000   -0.000140
```

2. LTspice suffix style:

```text
0       -145u
1m      -140u
```

3. Inline PWL style:

```text
PWL(0 -145u 1m -140u 2m -130u)
```

SPICE suffix convention is used:

```text
m = 1e-3, u = 1e-6, n = 1e-9, k = 1e3, meg = 1e6
```

## 5. Report-useful output figures

For reports, the most useful figures are:

```text
fig_total_frequency_response.png
fig_active_twin_t_notch_response.png
fig_input_differential_ecg.png
fig_after_ia_gain.png
fig_afe_output_before_adc.png
fig_adc_code_time_domain.png
fig_adc_code_distribution.png
```

## 6. Notes

- For MATLAB analysis, CSV is recommended because it is already 1 kSPS and directly includes `voltage_V`.
- PWL is mainly useful for XModel/SPICE injection. If PWL has additional interpolated points, MATLAB resamples it back to the AFE target `p.fs = 1000 Hz` before validation.
- Official dataset validation does **not** add artificial baseline wander, 60 Hz PLI, or random noise by default. This keeps MATLAB input equal to the repository waveform.
