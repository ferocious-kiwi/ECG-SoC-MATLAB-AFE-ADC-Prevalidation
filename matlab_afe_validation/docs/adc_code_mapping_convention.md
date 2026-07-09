# ADC Code Mapping Convention

MATLAB ADC output은 12-bit offset-binary code와 signed decimal stream 두 형태로 저장된다. `adc_offset_binary.mem`은 3-digit hex per line이며 XMODEL/RTL replay에 권장된다. `adc_signed.txt`는 `adc_offset_binary - 2048`로 계산한 signed decimal stream이다.

MATLAB ADC는 `floor((V + 1.65)/3.3 * 4095)`를 사용한다. 따라서 0 V는 offset-binary 2047, signed -1로 매핑된다. XMODEL 및 RTL testbench는 이 convention과 맞춰야 한다.

`reference_vectors/<CLASS>/input.csv`의 `source_code_signed_est_5uV_per_code`는 원본 ECG 입력 전압 scale 추적용 estimate이며 AFE ADC output code가 아니다. XMODEL analog input은 `voltage_V`를 사용한다. AFE ADC output reference는 `adc_offset_binary.mem`과 `adc_signed.txt`이다.

| input_voltage_V | offset_binary_code_decimal | offset_binary_code_hex | signed_decimal | formula | note |
|---|---|---|---|---|---|
| -1.65 | 0 | 000 | -2048 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | negative full-scale |
| -1 | 806 | 326 | -1242 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| -0.000805860805861 | 2046 | 7FE | -2 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 0 | 2047 | 7FF | -1 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | 0 V maps to offset-binary 2047 and signed -1 because floor() is used |
| 0.000805860805861 | 2048 | 800 | 0 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 1 | 3288 | CD8 | 1240 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |  |
| 1.65 | 4095 | FFF | 2047 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] | positive full-scale |
