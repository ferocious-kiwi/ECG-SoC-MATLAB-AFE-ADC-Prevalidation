%% ================================================================
%  run_all_matlab_afe_prevalidation.m
%
%  Top-level reproducibility script for MATLAB-based ECG AFE+ADC
%  nominal pre-validation and reference generation.
%
%  This script is intended to regenerate:
%    - parameter reference
%    - frequency response metrics
%    - dense 60 Hz notch sweep
%    - dynamic range / ADC headroom summary
%    - ADC code mapping convention test
%    - reference vectors and manifest
%    - figures
%
%  Note:
%  This script provides MATLAB nominal references before SystemVerilog
%  XMODEL implementation. It does not claim bit-exact XMODEL equivalence.
%% ================================================================

clear; clc; close all;

fprintf('Running MATLAB AFE+ADC nominal pre-validation...\n');

% 1) Run existing dataset validation if afe_input_dataset is available.
if exist('afe_input_dataset', 'dir')
    run_afe_dataset_validation;
else
    warning('afe_input_dataset/ not found. Existing results_dataset/ will be used if present.');
end

% 2) Generate additional reference artifacts required for XMODEL handoff.
if exist('generate_prevalidation_reference_package.m', 'file')
    generate_prevalidation_reference_package;
else
    warning('generate_prevalidation_reference_package.m not found. Use the checked-in reference package.');
end

fprintf('MATLAB AFE+ADC nominal pre-validation finished.\n');
