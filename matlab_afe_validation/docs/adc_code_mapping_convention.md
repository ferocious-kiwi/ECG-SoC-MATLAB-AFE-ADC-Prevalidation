# ADC Code Mapping Convention

이 문서는 MATLAB nominal ADC output convention을 정의한다.
디지털 RTL 및 XMODEL testbench와 convention이 충돌하지 않도록 아래 mapping을 기준으로 사용한다.

## Formula

```text
adc_offset_binary = floor((Vadc + 1.65) / 3.3 * 4095)
adc_offset_binary = clip(adc_offset_binary, 0, 4095)
adc_signed = adc_offset_binary - 2048
```

## Mapping Test

|   input_voltage_V |   offset_binary_code_decimal | offset_binary_code_hex   |   signed_decimal | formula                                           |
|------------------:|-----------------------------:|:-------------------------|-----------------:|:--------------------------------------------------|
|      -1.65        |                            0 | 000                      |            -2048 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|      -1           |                          806 | 326                      |            -1242 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|      -0.000805861 |                         2046 | 7FE                      |               -2 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|       0           |                         2047 | 7FF                      |               -1 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|       0.000805861 |                         2048 | 800                      |                0 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|       1           |                         3288 | CD8                      |             1240 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |
|       1.65        |                         4095 | FFF                      |             2047 | floor((V + 1.65)/3.3 * 4095), clipped to [0,4095] |

## File Formats

| File | Format | Intended usage |
|---|---|---|
| `adc_offset_binary.mem` | one 12-bit hex code per line, `%03X` | Recommended for XMODEL/RTL `$readmemh` replay |
| `adc_signed.txt` | signed decimal integer per line | Recommended for digital/SNN signed stream check |
| `matlab_stage_outputs.csv` | time-domain stage outputs and ADC codes | MATLAB-vs-XMODEL waveform and code comparison |

## 0 V Convention

With the current `floor` convention, 0 V maps to offset-binary code `2047` and signed decimal `-1`.
This is not an error; XMODEL and RTL testbenches should use the same convention or explicitly document any offset difference.
