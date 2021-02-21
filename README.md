# seismic_denoise_and_demultiple

## F-K Filter
F-K filter is when seismic data, which is in time-offset domain, is converted to frequency-wave number domain.
Then in the f-k domain, we con remove unwanted frequencies, that are different from the signal band. The first
step of f-k filtering is to do 2D Fourier transform of the seismic trace. Then we can select the frequencies which
are to be removed, then we can replace those region with zero (mute). Then to get our output trace in time-offset
domain, we do 2D inverse Fourier transform. F-K filter is usually used to remove ground roll. Ground roll is a
type of dispersive waveform that propagates along the surface and is low-frequency, large-amplitude in character.

## Predictive Deconvolution
In predictive deconvolution, a time-advanced form of input signal is taken and it is cross-correlated with the
input signal. If we consider our input as i(t), we want to predict its value at some future time (t + α), where α
is the prediction lag. The desired output will be d(t) = i(t + α), time-advanced form of i(t).
