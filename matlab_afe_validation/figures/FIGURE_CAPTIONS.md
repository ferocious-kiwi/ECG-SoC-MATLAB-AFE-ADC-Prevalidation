# Figure Captions

모든 figure는 논문/보고서 삽입 시 MATLAB nominal reference 범위를 명확히 표시해야 한다.

| Figure | Caption / Note |
|---|---|
| `fig_total_frequency_response` | MATLAB nominal frequency response reference before SystemVerilog XMODEL implementation. 60 Hz digital notch zero is a model artifact; use active Twin-T dense sweep for analog-style notch claim. 본 figure는 SystemVerilog XMODEL 구현 전 MATLAB nominal reference 결과이며, transistor-level, PCB-level, silicon-level 검증 또는 MATLAB-vs-XMODEL 등가성 검증을 의미하지 않는다. |
| `fig_notch_dense_sweep` | Dense active Twin-T 60 Hz notch frequency-domain reference. 50 Hz complete rejection is not claimed. 본 figure는 SystemVerilog XMODEL 구현 전 MATLAB nominal reference 결과이며, transistor-level, PCB-level, silicon-level 검증 또는 MATLAB-vs-XMODEL 등가성 검증을 의미하지 않는다. |
| `fig_dynamic_range_headroom` | ADC rail headroom reference for representative ECG inputs. 본 figure는 SystemVerilog XMODEL 구현 전 MATLAB nominal reference 결과이며, transistor-level, PCB-level, silicon-level 검증 또는 MATLAB-vs-XMODEL 등가성 검증을 의미하지 않는다. |
| `fig_adc_code_distribution` | ADC code distribution reference showing codes do not saturate at rails for representative inputs. 본 figure는 SystemVerilog XMODEL 구현 전 MATLAB nominal reference 결과이며, transistor-level, PCB-level, silicon-level 검증 또는 MATLAB-vs-XMODEL 등가성 검증을 의미하지 않는다. |
| `fig_reference_vector_handoff` | MATLAB reference vector handoff flow for subsequent XMODEL equivalence verification. 본 figure는 SystemVerilog XMODEL 구현 전 MATLAB nominal reference 결과이며, transistor-level, PCB-level, silicon-level 검증 또는 MATLAB-vs-XMODEL 등가성 검증을 의미하지 않는다. |
