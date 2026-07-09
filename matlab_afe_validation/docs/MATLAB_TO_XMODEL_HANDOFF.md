# MATLAB-to-XMODEL 인계 문서

이 문서는 MATLAB reference output을 MATLAB-vs-XMODEL 등가성 검증에서 어떻게 사용할지 정의한다.  
단, 이 문서는 MATLAB과 XMODEL이 이미 bit-exact하게 일치한다는 의미가 아니다.

## 1. MATLAB AFE 체인 순서

```text
input ECG voltage [V]
→ HPF 0.482 Hz
→ IA ×201
→ 60 Hz notch, Q≈5.0
→ LPF 150.1 Hz
→ ADC ±1.65 V
→ 12-bit offset-binary ADC code
→ signed decimal stream
```

## 2. 시간 영역 stream 등가성 기준

XMODEL의 time-domain output은 아래 MATLAB reference와 비교한다.

- `reference_vectors/<CLASS>/matlab_stage_outputs.csv`
- `reference_vectors/<CLASS>/adc_offset_binary.mem`
- `reference_vectors/<CLASS>/adc_signed.txt`

| Metric | 목표 / 설명 |
|---|---|
| sample alignment | lag = 0 sample |
| RMS LSB error | convention을 맞춘 뒤 가능하면 2–3 LSB 이하 |
| max abs LSB error | outlier 확인 |
| correlation | 0.99 이상 권장 |
| ADC code convention | MATLAB과 동일한 offset-binary convention |
| signed stream convention | MATLAB과 동일한 signed decimal convention |

## 3. Active Twin-T notch 주파수 응답 기준

60 Hz notch의 parameter-level / frequency-domain reference는 아래 결과와 비교한다.

- `docs/notch_60hz_reference.md`
- `results_dataset/notch_dense_sweep.csv`
- `results_dataset/notch_dense_sweep_metrics.csv`

MATLAB time-domain stream은 digital Q≈5 notch approximation을 사용한다.  
반면 dense notch sweep은 active Twin-T 구조의 frequency-domain reference를 제공한다.  
두 결과는 서로 관련되어 있지만, 동일한 비교 대상은 아니다.  
따라서 XMODEL 검증에서는 time-domain stream equivalence와 notch frequency-response validation을 분리해서 확인해야 한다.

## 4. Input convention

- XMODEL analog input은 `reference_vectors/<CLASS>/input.csv`의 `voltage_V`를 사용한다.
- `source_code_signed_est_5uV_per_code`는 source ECG scale 추적용 estimate이며, AFE ADC output code가 아니다.

## 5. ADC output format / RTL replay convention

- `adc_offset_binary.mem`은 물리 ADC code convention 확인용 reference이다.
- `adc_signed.txt`는 signed stream convention 확인용 reference이다.
- 공식 XMODEL/RTL replay format은 수환 XMODEL repo와 양건 digital RTL testbench의 input convention에 맞춰 확정해야 한다.
- 최종 digital input contract가 signed 12-bit ECG stream이므로, offset-binary code를 RTL에 직접 사용할 경우 mid-code subtraction 또는 convention 정합 여부를 명확히 확인해야 한다.
