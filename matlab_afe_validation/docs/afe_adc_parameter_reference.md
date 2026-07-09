# AFE+ADC Parameter Reference

이 문서는 SystemVerilog XMODEL 구현 전에 사용할 MATLAB nominal pre-validation 기준 파라미터를 정리한다.
본 문서는 실제 transistor-level/PCB/silicon 검증 완료를 의미하지 않고, XMODEL 구현자가 동일한 nominal parameter를 따라갈 수 있도록 만든 reference이다.

## Signal Chain

```text
ECG input → HPF → IA → 60 Hz notch → LPF → 12-bit ADC → signed stream
```

## Parameter Table

| block                     | parameter          | value                    | unit    | note                                                      |
|:--------------------------|:-------------------|:-------------------------|:--------|:----------------------------------------------------------|
| Sampling                  | fs                 | 1000                     | Hz      | ADC/system sample rate used for nominal MATLAB validation |
| HPF                       | R_hpf              | 10e6                     | Ohm     | Schematic-derived high-pass resistor                      |
| HPF                       | C_hpf              | 33e-9                    | F       | Schematic-derived high-pass capacitor                     |
| HPF                       | fc_hpf             | 0.482287706              | Hz      | 1/(2*pi*R*C), baseline drift removal reference            |
| Instrumentation Amplifier | Rfb                | 100e3                    | Ohm     | IA feedback resistor                                      |
| Instrumentation Amplifier | Rg                 | 1e3                      | Ohm     | IA gain-setting resistor                                  |
| Instrumentation Amplifier | Av_ia              | 201.000000000            | V/V     | 1 + 2*Rfb/Rg                                              |
| Differential Amplifier    | Av_diff            | 1                        | V/V     | Unity differential stage in nominal model                 |
| Notch                     | f_notch            | 60                       | Hz      | 60 Hz mains target                                        |
| Notch                     | R_twin             | 26.526e3                 | Ohm     | Active Twin-T nominal resistor                            |
| Notch                     | C_twin             | 100e-9                   | F       | Active Twin-T nominal capacitor                           |
| Notch                     | Rk1                | 5e3                      | Ohm     | Bootstrap feedback resistor                               |
| Notch                     | Rk2                | 95e3                     | Ohm     | Bootstrap feedback resistor                               |
| Notch                     | k_boot             | 0.950000000              | V/V     | Rk2/(Rk1+Rk2)                                             |
| Notch                     | Q_notch            | 5.000000000              | -       | Approximate Q = 1/(4*(1-k))                               |
| LPF                       | R_lpf              | 1e3                      | Ohm     | Schematic-derived low-pass resistor                       |
| LPF                       | C_lpf              | 1.06e-6                  | F       | Schematic-derived low-pass capacitor                      |
| LPF                       | fc_lpf             | 150.146172728            | Hz      | 1/(2*pi*R*C), anti-aliasing reference                     |
| ADC                       | adc_bits           | 12                       | bit     | Nominal ADC output width                                  |
| ADC                       | vref_n             | -1.65                    | V       | Negative ADC input reference                              |
| ADC                       | vref_p             | 1.65                     | V       | Positive ADC input reference                              |
| ADC                       | adc_max            | 4095                     | code    | 2^12 - 1                                                  |
| ADC                       | lsb                | 0.000805860806           | V/LSB   | 3.3/4095                                                  |
| Output stream             | offset_binary_mem  | %03X per line            | hex     | Recommended XMODEL/RTL replay memory format               |
| Output stream             | signed_decimal_txt | adc_offset_binary - 2048 | decimal | Recommended digital/SNN signed stream convention          |

## ADC Code Mapping

MATLAB nominal ADC는 다음 식을 사용한다.

```text
adc_offset_binary = floor((Vadc - (-1.65)) / 3.3 * 4095)
adc_offset_binary = clip(adc_offset_binary, 0, 4095)
adc_signed = adc_offset_binary - 2048
```

자세한 convention은 `docs/adc_code_mapping_convention.md`와 `results_dataset/adc_code_mapping_test.csv`를 참고한다.
