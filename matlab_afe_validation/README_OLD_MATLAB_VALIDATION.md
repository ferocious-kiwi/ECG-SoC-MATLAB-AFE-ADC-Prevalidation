# MATLAB AFE+ADC Validation 이전 README

이 MATLAB package는 ECG-SoC 프로젝트에서 사용하는 ECG AFE+ADC chain을 MATLAB에서 점검하기 위한 초기 버전 설명 문서이다.
현재 공식 README는 `README.md`이며, 본 문서는 이전 실행 흐름을 참고하기 위해 보관한다.

보고서용 초기 흐름은 다음과 같았다.

```text
기존 AFE schematic 값
  → MATLAB에서 gain / filter / ADC dynamic range 검산
  → SystemVerilog XModel 구현
  → SNN accelerator와 mixed-signal integration
```

## 1. 권장 공식 데이터셋 배치

repository dataset 폴더를 MATLAB 폴더 안에 복사한다.

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

CSV 파일은 다음 형식을 사용한다.

```text
sample_index, time_s, code_signed, voltage_V
```

PWL 파일은 다음 형식을 사용한다.

```text
time[s]    voltage[V]
```

프로젝트의 입력 scale은 다음과 같다.

```text
voltage_V = code_signed / 200000
1 code ≈ 5 uV
fs = 1000 Hz
```

## 2. 주요 script

### 단일 record 검증

기본 입력 하나를 실행한다. 먼저 `afe_input_dataset/afe_input_NSR.csv`를 찾고, 없으면 PWL 또는 이전 local test input을 사용한다.

```matlab
run_afe_adc_validation
```

결과는 아래 폴더에 저장된다.

```text
results/
```

### 4-class 공식 데이터셋 batch 검증

NSR / CHF / ARR / AFF를 실행하고, 가능하면 record100_NSR도 함께 실행한다.

```matlab
run_afe_dataset_validation
```

결과는 아래 폴더에 저장된다.

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
  → HPF fc ≈ 0.482 Hz
  → Instrumentation amplifier gain ×201
  → 60 Hz notch, Q ≈ 5
  → LPF fc ≈ 150 Hz
  → ADC input clamp ±1.65 V
  → 12-bit offset-binary ADC code
  → digital classifier용 signed 12-bit stream
```

## 4. PWL 지원

`parse_pwl_file.m`은 다음 형식을 지원한다.

1. 일반 numeric 2-column PWL:

```text
0.000000   -0.000145
0.001000   -0.000140
```

2. LTspice suffix 형식:

```text
0       -145u
1m      -140u
```

3. Inline PWL 형식:

```text
PWL(0 -145u 1m -140u 2m -130u)
```

SPICE suffix convention은 다음과 같다.

```text
m = 1e-3, u = 1e-6, n = 1e-9, k = 1e3, meg = 1e6
```

## 5. 보고서에 유용한 output figure

보고서에는 다음 figure들이 특히 유용하다.

```text
fig_total_frequency_response.png
fig_active_twin_t_notch_response.png
fig_input_differential_ecg.png
fig_after_ia_gain.png
fig_afe_output_before_adc.png
fig_adc_code_time_domain.png
fig_adc_code_distribution.png
```

## 6. 참고 사항

- MATLAB 분석에는 CSV 사용을 권장한다. CSV는 이미 1 kSPS이고 `voltage_V`를 직접 포함한다.
- PWL은 주로 XModel/SPICE 주입용이다. PWL에 보간 sample이 추가되어 있으면 MATLAB 검증 전에 AFE target `p.fs = 1000 Hz`로 다시 resampling한다.
- 공식 데이터셋 검증은 기본적으로 artificial baseline wander, 60 Hz PLI, random noise를 추가하지 않는다. 이는 MATLAB 입력을 repository waveform과 동일하게 유지하기 위한 것이다.
