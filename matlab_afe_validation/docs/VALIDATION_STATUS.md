# 검증 상태 정리

이 문서는 MATLAB repo가 주장할 수 있는 범위와 후속 XMODEL/digital 파트로 넘겨야 하는 범위를 정리한다.

| Item | Status | Artifact | Note |
|---|---|---|---|
| Parameter reference | PASS | `docs/afe_adc_parameter_reference.md` | XMODEL nominal 기준 |
| Frequency response reference | PASS | `docs/frequency_response_reference.md` | 60 Hz ideal digital zero caveat 포함 |
| Dense 60 Hz notch reference | PASS/PARTIAL | `docs/notch_60hz_reference.md` | bandwidth/Q는 nominal estimate, physical Q 아님 |
| Dynamic range / headroom | PASS | `docs/dynamic_range_headroom_reference.md` | representative inputs 기준 clipping 0% |
| ADC code mapping | PASS | `docs/adc_code_mapping_convention.md` | 0 V convention 명시 |
| Reference vectors | PASS | `reference_vectors/reference_vector_manifest.md` | NSR/CHF/ARR/AFF SHA256 tracked |
| MATLAB-vs-XMODEL equivalence | NOT DONE | XMODEL 담당 | claim 금지 |
| CMRR / op-amp / ADC nonideal | NOT DONE | XMODEL 또는 analog stress 검증 | claim 금지 |
| PCB / silicon / clinical validation | NOT DONE | scope 밖 | claim 금지 |
