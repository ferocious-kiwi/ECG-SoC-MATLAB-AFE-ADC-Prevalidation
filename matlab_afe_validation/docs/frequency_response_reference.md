# Frequency Response Numerical Reference

이 문서는 MATLAB nominal AFE chain의 frequency response reference를 정리한다.
단순 plot만으로는 XMODEL과 비교하기 어렵기 때문에, 주요 주파수 지점에서 magnitude, phase, group delay를 CSV로 저장하였다.

- CSV: `results_dataset/afe_frequency_response_metrics.csv`
- Figure: `figures/fig_total_frequency_response.png`
- PDF: `figures/fig_total_frequency_response.pdf`

## Metric Table

|   frequency_Hz | purpose                          |   magnitude_V_per_V |   magnitude_dB |   phase_deg |   group_delay_samples |   group_delay_ms | model_note                                     |
|---------------:|:---------------------------------|--------------------:|---------------:|------------:|----------------------:|-----------------:|:-----------------------------------------------|
|       0.05     | baseline drift region            |        20.7271      |        26.3308 |    84.0523  |            328.09     |       328.09     | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|       0.1      | low-frequency drift              |        40.8084      |        32.215  |    78.2283  |            317.997    |       317.997    | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|       0.482288 | HPF cutoff                       |       142.128       |        43.0536 |    44.7219  |            166.603    |       166.603    | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|       1        | ECG low-frequency passband       |       181.039       |        45.1554 |    25.1707  |             63.8761   |        63.8761   | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|       5        | ECG main band                    |       199.918       |        46.017  |     2.62009 |              4.65405  |         4.65405  | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|      10        | ECG main band                    |       200.144       |        46.0269 |    -3.05504 |              2.40963  |         2.40963  | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|      40        | ECG morphology band              |       187.236       |        45.4478 |   -27.9027  |              3.38189  |         3.38189  | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|      50        | 50 Hz mains reference            |       163.981       |        44.2959 |   -46.3966  |              8.17823  |         8.17823  | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|      60        | 60 Hz notch target               |         0           |     -6000      |     0       |            nan        |       nan        | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|     100        | high-frequency ECG/noise         |       165.205       |        44.3605 |   -23.6445  |              1.44175  |         1.44175  | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|     150        | LPF cutoff                       |       137.589       |        42.7717 |   -41.8353  |              0.768304 |         0.768304 | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|     250        | pre-ADC high-frequency reference |        86.578       |        38.7482 |   -62.2927  |              0.431782 |         0.431782 | digital MATLAB nominal chain: HPF*IA*notch*LPF |
|     500        | 1 kSPS Nyquist                   |         5.86432e-15 |      -284.636  |   -90       |            nan        |       nan        | digital MATLAB nominal chain: HPF*IA*notch*LPF |

## Notes

- 이 frequency response는 MATLAB nominal chain의 기준값이다.
- Time-domain notch는 Q≈5 2nd-order notch approximation을 사용한다.
- Active Twin-T의 dense 60 Hz response는 `docs/notch_60hz_reference.md`에서 별도로 정리한다.
- 본 결과는 XMODEL 구현 전 reference frequency response이며, MATLAB과 XMODEL의 bit-exact equivalence를 이미 검증했다는 의미는 아니다.
