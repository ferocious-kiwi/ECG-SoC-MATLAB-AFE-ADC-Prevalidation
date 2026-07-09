# Frequency Response Numerical Reference\n\nCSV: `results_dataset/afe_frequency_response_metrics.csv`\n\n본 결과는 XMODEL 구현 전 MATLAB reference frequency response이다. MATLAB time-domain chain의 60 Hz digital notch approximation은 정확히 60 Hz에서 ideal zero를 만들 수 있다. 따라서 60 Hz의 numerical dB 값은 physical analog attenuation claim이 아니며, CSV에서는 `< -120 dB` reporting cap으로 해석한다. 최종 논문에서 사용할 analog-style notch attenuation claim은 active Twin-T dense sweep 결과를 사용한다.\n\n| frequency_Hz | purpose | magnitude_V_per_V | magnitude_dB | phase_deg | group_delay_samples | group_delay_ms | model_note | interpretation_note |
|---|---|---|---|---|---|---|---|---|
| 0.05 | baseline drift region | 20.727092953 | 26.330767901 | 84.0523148345 | 328.092106396 | 328.092106396 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 0.1 | low-frequency drift | 40.8083709308 | 32.2149851619 | 78.2283268843 | 317.998777779 | 317.998777779 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 0.482287706339 | HPF cutoff | 142.12750278 | 43.0535625086 | 44.7218860294 | 166.602127823 | 166.602127823 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 1 | ECG low-frequency passband | 181.038800313 | 45.1554332605 | 25.1707210807 | 63.8759378388 | 63.8759378388 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 5 | ECG main band | 199.917677231 | 46.0170239448 | 2.62009234389 | 4.6540488017 | 4.6540488017 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 10 | ECG main band | 200.14423204 | 46.0268615736 | -3.05503692174 | 2.40963160317 | 2.40963160317 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 40 | ECG morphology band | 187.235805548 | 45.4477780702 | -27.9026613361 | 3.3818941192 | 3.3818941192 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 50 | 50 Hz mains reference | 163.981435435 | 44.295893675 | -46.3966449677 | 8.1782268916 | 8.1782268916 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 60 | 60 Hz notch target | 0 | -120 | 0 | NaN | NaN | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF | ideal digital notch zero; numerical dB value capped as < -120 dB; not a physical analog attenuation claim |
| 100 | high-frequency ECG/noise | 165.205257693 | 44.3604772944 | -23.6445417514 | 1.44174840012 | 1.44174840012 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 150 | LPF cutoff | 137.589387664 | 42.7716987569 | -41.8352699815 | 0.768304488779 | 0.768304488779 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 250 | pre-ADC high-frequency reference | 86.5780291445 | 38.7481539069 | -62.2927282351 | 0.431782471699 | 0.431782471699 | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
| 500 | 1 kSPS Nyquist | 5.86432415737e-15 | -284.635640631 | -90 | NaN | NaN | digital MATLAB nominal chain: HPF*IA*digital Q≈5 notch*LPF |  |
