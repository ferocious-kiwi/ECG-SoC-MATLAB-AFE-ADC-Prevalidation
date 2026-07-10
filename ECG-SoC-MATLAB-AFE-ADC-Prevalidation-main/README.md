# MATLAB 기반 ECG AFE+ADC Nominal Pre-Validation

본 repo는 ECG AFE+ADC chain의 MATLAB 기반 **nominal pre-validation**을 수행한다.  
목적은 SystemVerilog XMODEL 구현 전에 schematic 기반 필터 파라미터, ADC 동적 범위, code mapping, reference vector를 정의하는 것이다.

> 본 검증은 transistor-level, PCB-level, silicon-level, clinical validation을 의미하지 않는다.  
> 또한 MATLAB과 SystemVerilog XMODEL의 bit-exact equivalence를 이미 검증했다는 의미도 아니다.  
> MATLAB 결과는 후속 XMODEL 검증에서 비교 기준으로 사용할 reference output이다.

## 프로젝트 내 역할

```text
MATLAB nominal pre-validation
→ SystemVerilog XMODEL AFE+ADC implementation
→ digital SNN RTL / Vivado / Vitis validation
→ XMODEL AFE+ADC stream + locked digital RTL integration
```

MATLAB 파트는 다음을 제공한다.

```text
nominal parameter reference
frequency response reference
ADC headroom reference
ADC code mapping convention
golden/reference input-output vector
```

## 신호 처리 체인

본 MATLAB 모델에서는 다음과 같은 AFE+ADC 신호 처리 체인을 적용하였다.

```text
ECG input voltage_V
→ HPF 0.482 Hz
→ Instrumentation Amplifier ×201
→ 60 Hz notch filter, Q≈5
→ LPF 150 Hz
→ 12-bit ADC, ±1.65 V
→ 12-bit offset-binary ADC code
→ signed decimal stream
```

## ADC output format / RTL replay convention

`adc_offset_binary.mem`은 physical ADC offset-binary code convention 확인용 reference이다.  
`adc_signed.txt`는 offset-binary code에서 mid-code 2048을 제거한 signed stream reference이다.  
공식 XMODEL/RTL replay format은 downstream XMODEL과 locked digital RTL testbench의 input convention에 따라 확정한다.  
최종 digital input contract는 signed 12-bit ECG stream이므로, offset-binary code를 RTL에 직접 넣는 경우 명시적인 mid-code subtraction 또는 convention matching이 필요하다.

현재 MATLAB repo는 아래 세 후보 중 어떤 형식이 canonical downstream replay format인지 임의로 선택하지 않는다.

| 후보 format | 설명 | 현재 repo 상태 |
|---|---|---|
| offset-binary 12-bit hex `.mem` | physical ADC code reference | `reference_vectors/<CLASS>/adc_offset_binary.mem`으로 제공 |
| signed 12-bit two's-complement hex `.mem` | signed stream을 RTL-friendly hex로 저장한 후보 | downstream convention 확인 전까지 canonical로 주장하지 않음 |
| signed decimal stream | signed stream reference | `reference_vectors/<CLASS>/adc_signed.txt`로 제공 |

공식 downstream 형식이 signed two's-complement hex `.mem`으로 확정되면 `reference_vectors/<CLASS>/adc_signed_twos_complement.mem`을 추가 생성하고, reference-vector manifest와 SHA256을 다시 생성해야 한다.

## 폴더 구조

```text
README.md                         # GitHub repo 첫 화면용 README
matlab_afe_validation/
├─ run_all_matlab_afe_prevalidation.m
├─ run_afe_dataset_validation.m
├─ generate_prevalidation_reference_package.m
├─ afe_adc_params.m
├─ afe_adc_model.m
├─ design_afe_filters.m
├─ active_twin_t_response.m
├─ docs/
├─ figures/
├─ results_dataset/
└─ reference_vectors/
```

## 주요 산출물

| 구분 | 파일 |
|---|---|
| Parameter reference | `matlab_afe_validation/docs/afe_adc_parameter_reference.md`, `matlab_afe_validation/results_dataset/afe_adc_parameter_reference.csv` |
| Frequency response reference | `matlab_afe_validation/docs/frequency_response_reference.md`, `matlab_afe_validation/results_dataset/afe_frequency_response_metrics.csv` |
| Dense 60 Hz notch reference | `matlab_afe_validation/docs/notch_60hz_reference.md`, `matlab_afe_validation/results_dataset/notch_dense_sweep.csv` |
| Dynamic range/headroom | `matlab_afe_validation/docs/dynamic_range_headroom_reference.md`, `matlab_afe_validation/results_dataset/afe_dynamic_range_headroom_summary.csv` |
| ADC code mapping | `matlab_afe_validation/docs/adc_code_mapping_convention.md`, `matlab_afe_validation/results_dataset/adc_code_mapping_test.csv` |
| XMODEL handoff | `matlab_afe_validation/docs/MATLAB_TO_XMODEL_HANDOFF.md` |
| Input dataset manifest | `matlab_afe_validation/docs/INPUT_DATASET_MANIFEST.md`, `matlab_afe_validation/results_dataset/input_dataset_manifest.csv` |
| Validation status | `matlab_afe_validation/docs/VALIDATION_STATUS.md` |
| Figure captions | `matlab_afe_validation/figures/FIGURE_CAPTIONS.md` |
| Reference vectors | `matlab_afe_validation/reference_vectors/*`, `matlab_afe_validation/reference_vectors/reference_vector_manifest.csv` |
| Figures | `matlab_afe_validation/figures/*.png`, `matlab_afe_validation/figures/*.pdf` |

## 검증 결과 요약

MATLAB nominal pre-validation 결과, NSR/CHF/ARR/AFF 대표 ECG 입력에 대해 AFE 출력은 모두 ADC 입력 범위인 ±1.65 V 내에서 동작했으며 clipping ratio는 0%였다.

| Class | AFE Output Min [V] | AFE Output Max [V] | ADC Code Range | Clipping Ratio |
|---|---:|---:|---:|---:|
| NSR | -0.111193 | 0.385184 | 1909-2525 | 0.0% |
| CHF | -0.278713 | 0.557422 | 1701-2739 | 0.0% |
| ARR | -0.630367 | 0.466399 | 1265-2626 | 0.0% |
| AFF | -0.350374 | 0.326538 | 1612-2452 | 0.0% |

주요 해석은 다음과 같다.

- 선택한 IA gain ×201은 대표 ECG 입력에 대해 ADC 입력 범위인 ±1.65 V rail에 도달하지 않았다.
- 모든 클래스에서 positive/negative rail hit count는 0이다.
- ADC code는 0 또는 4095에 붙지 않고 정상적인 12-bit stream으로 생성되었다.
- 이 결과는 XMODEL 구현 전 nominal ADC headroom reference로 사용한다.

## 재현 방법

MATLAB Current Folder를 `matlab_afe_validation/`로 설정한 뒤 아래 script를 실행한다.

```matlab
run_all_matlab_afe_prevalidation
```

이 script는 `afe_input_dataset/` 존재 여부에 따라 가능한 범위에서 다음 항목을 재생성하도록 구성되어 있다.

```text
parameter reference
frequency response metrics
60 Hz notch dense sweep
dynamic range/headroom summary
ADC code mapping test
reference vector package
figure export
manifest/hash generation
```

실제 4-class ECG 입력 데이터셋이 있는 경우 `afe_input_dataset/`을 `matlab_afe_validation/` 폴더 아래에 둔 뒤 실행한다.

재현성 기준은 다음과 같다.

```text
afe_input_dataset/이 있는 경우:
    run_all_matlab_afe_prevalidation.m은 4-class ECG 입력으로부터
    dataset-level MATLAB output과 reference package를 재생성한다.

afe_input_dataset/이 없는 경우:
    script는 repo에 포함된 results_dataset/ artifact를 기반으로
    secondary report, figure, manifest를 재생성한다.
```

즉, top-level script가 항상 raw ECG input부터 모든 것을 재생성하는 것은 아니다.  
새로 clone한 환경에서 raw input부터 완전히 재생성하려면 `afe_input_dataset/`이 필요하다.  
이미 생성된 reference package는 `matlab_afe_validation/results_dataset/` 및 `matlab_afe_validation/reference_vectors/`에 포함되어 있다.

## 60 Hz notch 해석 주의

MATLAB time-domain chain의 60 Hz digital notch approximation은 정확히 60 Hz에서 ideal zero를 만들 수 있다.  
따라서 이 수치값은 실제 analog 회로의 감쇠량을 주장하는 값이 아니다.

최종 논문에서 사용할 analog-style notch attenuation claim은 `matlab_afe_validation/docs/notch_60hz_reference.md`와 `matlab_afe_validation/results_dataset/notch_dense_sweep.csv`의 active Twin-T dense sweep 기준을 사용한다.

## Frequency response 해석 주의

`matlab_afe_validation/results_dataset/afe_frequency_response_metrics.csv`의 absolute magnitude는 IA gain ×201을 포함한 전체 chain gain이다. 따라서 baseline-drift 영역의 absolute dB가 양수로 보여도, 이것이 drift가 ECG passband 대비 증폭된다는 뜻은 아니다. 해석에는 `relative_to_10Hz_passband_dB` 또는 `relative_to_passband_mean_dB` column을 함께 사용한다.

## 입력 source traceability

대표 NSR/CHF/ARR/AFF 입력은 `matlab_afe_validation/docs/INPUT_DATASET_MANIFEST.md`와 `matlab_afe_validation/results_dataset/input_dataset_manifest.csv`에서 source database, record ID, segment duration, traceability status를 확인할 수 있다. 현재 MATLAB repo에서는 exact segment start를 추적하지 않으며, checked-in reference input과 SHA256 hash를 기준으로 동일성을 추적한다.

## 범위와 한계

본 MATLAB repo에서는 아래 항목을 검증 완료했다고 주장하지 않는다.

- 실제 AFE 회로 검증 완료
- PCB 또는 센서 실측 검증
- CMOS/post-layout 검증
- op-amp finite GBW, offset, slew rate 검증
- CMRR/common-mode rejection 검증
- ADC offset/gain/noise/jitter robustness 검증
- MATLAB-vs-XMODEL sample-wise bit-exact equivalence 검증
- final classification accuracy 또는 board replay

위 항목은 후속 SystemVerilog XMODEL 검증, mixed-signal integration, digital RTL/Vivado/Vitis/board replay 단계에서 다룬다.
