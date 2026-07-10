# Reference Vector Manifest 정리

이 문서는 MATLAB reference input/output vector의 SHA256 hash를 정리한다. 이 vector는 후속 MATLAB-vs-XMODEL equivalence verification의 기준으로 사용된다.

> `source_code_signed_est_5uV_per_code`는 원본 ECG 입력 전압 scale 추적용 estimate이며 AFE ADC output code가 아니다. XMODEL analog input은 `voltage_V`를 사용한다.

| Class | File role | Relative path | Bytes | SHA256 |
|---|---|---|---:|---|
| AFF | adc_offset_binary.mem | `reference_vectors/AFF/adc_offset_binary.mem` | 240000 | `0f03e0e2c8f50e9c188a1c859c5c0e914a80877dbd73d5624993e1f8f96e93d8` |
| AFF | adc_signed.txt | `reference_vectors/AFF/adc_signed.txt` | 266825 | `7275d11062dea6b456618234dd4f8eaba1951125bf7c59c35745dd13de192b19` |
| AFF | input.csv | `reference_vectors/AFF/input.csv` | 1646151 | `365ea2e8729fb998a0821f74a1ac25e920e73bcb34b36ab33bcb74e51a1a9891` |
| AFF | matlab_stage_outputs.csv | `reference_vectors/AFF/matlab_stage_outputs.csv` | 7510549 | `d9ca33eded4b2da07dd351efd5cc03483d5b7f3d0db41dcc5970423c36f9e54f` |
| ARR | adc_offset_binary.mem | `reference_vectors/ARR/adc_offset_binary.mem` | 240000 | `1c218ac363c580317d7acd18a7a869c58ef0c11c7420f12d4b0191083c5bb6ca` |
| ARR | adc_signed.txt | `reference_vectors/ARR/adc_signed.txt` | 279589 | `958affc2f2584d005a6aecaeea0019d144659b1b08d03e35add0231265a09589` |
| ARR | input.csv | `reference_vectors/ARR/input.csv` | 1658629 | `f9bf8633850bb0287c086c51d4c2bd2c7b7c40b896a4a7541ef0d5ac5aace754` |
| ARR | matlab_stage_outputs.csv | `reference_vectors/ARR/matlab_stage_outputs.csv` | 7574905 | `5a4f2b10f6adab17e00d8bd5f9b8b076f0d6ed5611b7a3ff281f2c83ec3e6866` |
| CHF | adc_offset_binary.mem | `reference_vectors/CHF/adc_offset_binary.mem` | 240000 | `ae7ec806059809121fd5524bb634fa8d2ceaaeaa158f38ce833f771fe085a42c` |
| CHF | adc_signed.txt | `reference_vectors/CHF/adc_signed.txt` | 281866 | `9dcba06b6bd876ad6cd00a9041fdc650e3005c1478fa03a95c1b0a8d9bff8dbf` |
| CHF | input.csv | `reference_vectors/CHF/input.csv` | 1678856 | `5cee3b218d53e6c78589bd592071ce220e584351276213e16fc2f01dd19dacc7` |
| CHF | matlab_stage_outputs.csv | `reference_vectors/CHF/matlab_stage_outputs.csv` | 7567531 | `da55644378298c76f43e1d9106f754040ce94d06308c345b5dfb74b7f40effdd` |
| NSR | adc_offset_binary.mem | `reference_vectors/NSR/adc_offset_binary.mem` | 240000 | `a9da5909aa345e89bd9a0357f33a7e92bdf8263e6d916e617dd4de26114cb1ba` |
| NSR | adc_signed.txt | `reference_vectors/NSR/adc_signed.txt` | 276136 | `c34aaea1b6e33c12f2245736299f34e308a4f34a2566bf21534d4c68e7f5855c` |
| NSR | input.csv | `reference_vectors/NSR/input.csv` | 1511440 | `262a0629170b85a54887501a2064c147684ea15b0ad839786f82ca05d8ccfc1c` |
| NSR | matlab_stage_outputs.csv | `reference_vectors/NSR/matlab_stage_outputs.csv` | 7562568 | `1459b72b8101bce81f11ced6692b8c2858ff98202fe274e0ea0fe11a438e89b0` |
