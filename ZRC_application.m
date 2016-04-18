% APPLICATION of Zero-Crossing Rate descriptor
% Written by: Adrià Romero López
% Date: April 18th, 2016
% Institution: Politechincal University of Catalonia (UPC) - Barcelona Tech

%% ---------------------------READING INPUT FILE----------------------------
% 'y': Audio data in the file, returned as an m-by-n matrix, where m is 
% the number of audio samples read and n is the number of audio channels in 
% the file.
% 'Fs': Sample rate, in Hz, of audio data 'y', returned as a positive scalar.
%'n_samples': Number of total samples of audio data
input_audio = 'sample.wav';
[y,Fs] = audioread(input_audio);
y = y * 2.^15;  % original values into integer
n_samples = length(y);

%% --------------------------FRAMING---------------------------------------
% Objective: to segment the audio_input data into frames of fixed length 
% 'frame_length': fixed length of the audio frame
% 'n_frames': Number of frames
% 'frames': Array that contains all frames data
%           Dimension = (frame_length, n_frames)
%           i.e. frames(67,3) : sample 67 of frame 3

frame_length = Fs/40;    % Assuming Fs is integer. 
                         % Frame length of 400 ms (for Fs = 16 kHz) 
trailing_samples = mod(n_samples, frame_length);
frames = reshape( y(1:end-trailing_samples), frame_length, []);
n_frames = length(frames(1,:));

%% -------------------------Zero-Crossing Rate-----------------------------
[ zcr ] = ZCR( y, frames, n_frames, Fs );

%% -----------------------Hamming Windowing--------------------------------
h = hamming(frame_length);
h = repmat(h,1,n_frames);

w = frames.*h;
w_reshaped = reshape(w, 1, frame_length*n_frames);

%% --------------------------PLOTING---------------------------------------
% Objective: to plot the comparative of the audio input file vs windowed
% signal
figure;
subplot(2,1,1); plot(y); ylabel('Amplitude'); title('Audio input');
subplot(2,1,2); plot(w_reshaped, '.-');
xlabel('time'); ylabel('Amplitude'); title('Windowed signal');

%% -----------------------Energy computation-------------------------------
energy = sum(w.^2);

%% --------------------------PLOTING---------------------------------------
% Objective: to plot the comparative of the audio input file vs signal energy
figure;
subplot(2,1,1); plot(y); ylabel('Amplitude'); title('Audio input');
subplot(2,1,2); plot(energy, '.-');
xlabel('time'); ylabel('Energy (J)'); title('Signal energy');
