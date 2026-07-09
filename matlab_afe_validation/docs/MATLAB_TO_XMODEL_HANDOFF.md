# MATLAB-to-XMODEL Handoff 문서

이 문서는 MATLAB-vs-XMODEL 등가성 검증에 사용할 MATLAB reference output을 정의한다.  
이 문서는 MATLAB과 XMODEL이 이미 bit-exact로 일치함을 주장하지 않는다.

## MATLAB의 역할

MATLAB 단계는 SystemVerilog XMODEL 구현 이전의 nominal system-level pre-validation 및 reference generation 단계이다.  
본 단계에서는 schematic 기반 AFE 필터 파라미터, ADC headroom, code mapping, 대표 ECG 입력에 대한 reference output vector를 정의한다.  
회로 소자 수준 non-ideality와 mixed-signal behavioral robustness는 후속 XMODEL 검증 단계에서 다룬다.

## Block order

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

## 단위 및 sampling

| 항목 | 값 |
|---|---:|
| Sampling rate | 1 kSPS |
| Input unit | V |
| Stage output unit | V |
| ADC voltage range | ±1.65 V |
| ADC output | 12-bit offset-binary, 0-4095 |
| Signed stream | offset-binary − 2048 |

## Reference vector 위치

```text
reference_vectors/NSR/
reference_vectors/CHF/
reference_vectors/ARR/
reference_vectors/AFF/
reference_vectors/reference_vector_manifest.csv
reference_vectors/reference_vector_manifest.md
```

각 case에는 다음 파일이 포함된다.

```text
input.csv
matlab_stage_outputs.csv
adc_offset_binary.mem
adc_signed.txt
```

## 권장 XMODEL 비교 metric

| Metric | 목표 / 비고 |
|---|---|
| waveform alignment | lag = 0 sample |
| RMS error | convention matching 후 가능하면 2-3 LSB 이하 |
| max absolute error | outlier 확인 |
| correlation | 0.99 이상 권장 |
| ADC code convention | 동일한 offset-binary/signed convention 유지 |
| final signed stream | 동일 convention 유지 |

## 주장하지 않는 항목

본 MATLAB package는 transistor-level, PCB-level, silicon-level, clinical validation, op-amp non-ideality 검증, CMRR 검증, ADC non-ideal robustness 검증, MATLAB-vs-XMODEL bit-exact equivalence 완료를 주장하지 않는다.
