function [ zcr ] = ZCR( input_audio, frames, n_frames, Fs )
%ZCR computes the Zero-Crossing Rate know as the rate of sign-changes along
%a audio signal. The rate at which the signal changes from positive to
%negative or back.
%
% INPUT VARIABLES: 
%       'audio_input': Audio input signal with format .wav, .ogg, .flac,
%       .mp3 or .mp4
%
% OUTPUT VARIABLES:
%       'zcr': Zero-crossing rate
%
% Written by: Adrià Romero López
% Date: April 18th, 2016
% Institution: Politechincal University of Catalonia (UPC) - Barcelona Tech

%% --------------------------ZRC COMPUTATION-------------------------------
% Objective: in order to compute the ZRC we must first do a mean justifica-
% tion and then the summatory of signal-changing sign.

for i=1:n_frames
	frames(:,i)=frames(:,i)-mean(frames(:,i));	% mean justification
end

zcr = sum(frames(1:end-1, :).*frames(2:end, :)<0);

%% --------------------------PLOTING---------------------------------------
% Objective: to plot the comparative of the audio input file vs ZCR signal 
figure;
sampleTime=(1:length(input_audio))/Fs;
subplot(2,1,1); plot(sampleTime, input_audio); ylabel('Amplitude'); title('Audio input');
subplot(2,1,2); plot(zcr, '.-');
xlabel('sample'); ylabel('Count'); title('ZCR');

end

