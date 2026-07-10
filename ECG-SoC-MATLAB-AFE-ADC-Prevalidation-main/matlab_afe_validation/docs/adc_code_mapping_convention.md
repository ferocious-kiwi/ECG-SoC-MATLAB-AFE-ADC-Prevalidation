# ADC Code Mapping Convention 정리

MATLAB ADC output은 12-bit offset-binary code와 signed decimal stream 두 형태로 저장된다. 단, 이 repo는 downstream RTL replay format을 단독으로 확정하지 않는다. 공식 replay format은 수환 XMODEL repo와 양건 locked digital RTL testbench의 input convention을 source of truth로 확인한 뒤 확정해야 한다.

## 1. 제공하는 reference format

- `adc_offset_binary.mem`은 물리 ADC output에 해당하는 12-bit offset-binary code convention 확인용 reference이다.
- `adc_signed.txt`는 offset-binary code에서 mid-code 2048을 제거한 signed decimal stream reference이다.
- 최종 digital input contract는 signed 12-bit ECG stream이다.
- 따라서 offset-binary code를 RTL에 직접 사용할 경우 명시적인 mid-code subtraction 또는 convention matching이 필요하다.

## 2. Downstream canonical format 상태

현재 MATLAB repo는 아래 세 가지 후보 format을 reference로 구분한다. canonical downstream replay format은 아직 이 MATLAB repo에서 임의로 선택하지 않는다.

| Candidate | 의미 | 현재 상태 |
|---|---|---|
| `offset-binary 12-bit hex .mem` | physical ADC code reference | 제공됨: `adc_offset_binary.mem` |
| `signed 12-bit two's-complement hex .mem` | signed stream을 12-bit two's-complement hex로 저장한 RTL replay 후보 | downstream convention 확인 전까지 canonical로 주장하지 않음 |
| `signed decimal stream` | signed stream reference | 제공됨: `adc_signed.txt` |

공식 downstream 형식이 signed two's-complement hex `.mem`으로 확정되면 `reference_vectors/<CLASS>/adc_signed_twos_complement.mem`을 추가로 생성하고, reference-vector manifest와 SHA256을 다시 생성해야 한다.

## 3. MATLAB ADC mapping

MATLAB ADC는 `floor((V + 1.65)/3.3 * 4095)`를 사용한다. 따라서 0 V는 offset-binary 2047, signed -1로 매핑된다. XMODEL 및 RTL testbench는 이 convention과 맞춰야 한다.

`reference_vectors/<CLASS>/input.csv`의 `source_code_signed_est_5uV_per_code`는 원본 ECG 입력 전압 scale 추적용 estimate이며 AFE ADC output code가 아니다. XMODEL analog input은 `voltage_V`를 사용한다. AFE ADC output reference는 `adc_offset_binary.mem`과 `adc_signed.txt`이다.

| input_voltage_V | offset_binary_code_decimal | offset_binary_code_hex | signed_decimal | formula | note |
|---|---|---|---|---|---|
| -1.65 | 0 | 000 | -2048 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | negative full-scale |
| -1.0 | 806 | 326 | -1242 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | N/A |
| -0.0008058608058608 | 2046 | 7FE | -2 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | N/A |
| 0.0 | 2047 | 7FF | -1 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | 0 V maps to offset-binary 2047 and signed -1 because floor() is used |
| 0.0008058608058608 | 2048 | 800 | 0 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | N/A |
| 1.0 | 3288 | CD8 | 1240 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | N/A |
| 1.65 | 4095 | FFF | 2047 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | positive full-scale |
