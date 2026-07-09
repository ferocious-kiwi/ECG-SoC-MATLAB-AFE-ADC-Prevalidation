# MATLAB-to-XMODEL Handoff Document

This document defines the MATLAB reference outputs that should be used for MATLAB-vs-XMODEL equivalence verification.
It does not claim that MATLAB and XMODEL are already bit-exact equivalent.

## 1. MATLAB AFE Chain Block Order

```text
input ECG voltage [V]
→ HPF 0.482 Hz
→ IA ×201
→ 60 Hz notch, Q≈5.0
→ LPF 150.1 Hz
→ ADC ±1.65 V
→ 12-bit offset-binary / signed stream
```

## 2. Time-domain stream equivalence 기준

XMODEL의 time-domain output은 아래 MATLAB reference와 비교한다.

- `reference_vectors/<CLASS>/matlab_stage_outputs.csv`
- `reference_vectors/<CLASS>/adc_offset_binary.mem`
- `reference_vectors/<CLASS>/adc_signed.txt`

| Metric | Target / Comment |
|---|---|
| sample alignment | lag = 0 sample |
| RMS LSB error | preferably 2-3 LSB or lower after convention matching |
| max abs LSB error | inspect outliers |
| correlation | 0.99 or higher recommended |
| ADC code convention | identical offset-binary convention |
| signed stream convention | identical signed decimal convention |

## 3. Active Twin-T notch frequency-response 기준

60 Hz notch의 parameter-level/frequency-domain reference는 아래 결과와 비교한다.

- `docs/notch_60hz_reference.md`
- `results_dataset/notch_dense_sweep.csv`
- `results_dataset/notch_dense_sweep_metrics.csv`

The MATLAB time-domain stream uses a digital Q≈5 notch approximation.
The dense notch sweep provides an active Twin-T frequency-domain reference.
These are related but not identical comparison targets.
For XMODEL verification, time-domain stream equivalence and notch frequency-response validation should be checked separately.

## 4. Input / Output convention

- XMODEL analog input은 `reference_vectors/<CLASS>/input.csv`의 `voltage_V`를 사용한다.
- `source_code_signed_est_5uV_per_code`는 source ECG scale 추적용 estimate이며 AFE ADC output code가 아니다.
- 권장 XMODEL/RTL replay format은 `adc_offset_binary.mem`이다.
- signed stream 비교에는 `adc_signed.txt`를 사용한다.
