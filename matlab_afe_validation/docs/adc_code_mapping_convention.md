# ADC Code Mapping Convention 정리

MATLAB ADC output은 12-bit offset-binary code와 signed decimal stream 두 형태로 저장된다.

- `adc_offset_binary.mem`은 물리 ADC code convention 확인용 reference이다.
- `adc_signed.txt`는 signed stream convention 확인용 reference이다.
- 공식 XMODEL/RTL replay format은 수환 XMODEL repo와 양건 digital RTL testbench의 input convention에 맞춰 확정해야 한다.
- 최종 digital input contract가 signed 12-bit ECG stream이므로, offset-binary code를 RTL에 직접 사용할 경우 mid-code subtraction 또는 convention 정합 여부를 명확히 확인해야 한다.

MATLAB ADC는 `floor((V + 1.65)/3.3 * 4095)`를 사용한다. 따라서 0 V는 offset-binary 2047, signed -1로 매핑된다. XMODEL 및 RTL testbench는 이 convention과 맞춰야 한다.

`reference_vectors/<CLASS>/input.csv`의 `source_code_signed_est_5uV_per_code`는 원본 ECG 입력 전압 scale 추적용 estimate이며 AFE ADC output code가 아니다. XMODEL analog input은 `voltage_V`를 사용한다. AFE ADC output reference는 `adc_offset_binary.mem`과 `adc_signed.txt`이다.

| input_voltage_V | offset_binary_code_decimal | offset_binary_code_hex | signed_decimal | formula | note |
| --- | --- | --- | --- | --- | --- |
| -1.65 | 0 | 000 | -2048 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | negative full-scale |
| -1.0 | 806 | 326 | -1242 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| -0.0008058608058608 | 2046 | 7FE | -2 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 0.0 | 2047 | 7FF | -1 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | 0 V maps to offset-binary 2047 and signed -1 because floor() is used |
| 0.0008058608058608 | 2048 | 800 | 0 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 1.0 | 3288 | CD8 | 1240 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 1.65 | 4095 | FFF | 2047 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | positive full-scale |
