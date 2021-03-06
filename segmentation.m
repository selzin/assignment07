clear all
close all
clc

[audioIn,fs] = audioread('TestSegment.wav'); %read the audio files

%sound(audioIn,fs); %play the audio signal

figure1 = figure;

plot(audioIn); %plotting the graph
saveas(figure1, 'audioSignal.jpg'); %saving the  graph of audio signal of testSegment.wav


%do framing
fd = 0.020;%define the frame duration i.e 20 msec

f_size = round(fs * fd);

n = length(audioIn);

n_f = floor(n/f_size);
temp = 0;

for i = 1 : n_f    
   frames(i,:) = audioIn(temp + 1 : temp + f_size);
   temp = temp + f_size;
end

figure2 = figure;
%plot the frame
plot(frames(11,:));
saveas(figure2, 'SpeechSignal.jpg');%saving the speech signal amplitude

%silence removal based on max amplitude
m_amp = abs(max(frames,[],2)); %find the maximum of each frame

id = find(m_amp > 0.05); %finding ID of frames with max amp > 0.05

fr_ws = frames(id,:); % frames without silence

figure3 = figure;
% reconstruct signal
data_r = reshape(fr_ws',1,[]);
plot(data_r); title('speech without silence');
hold on;
plot(audioIn,'r');
legend('After Silence Removal','Original Signal');

saveas(figure3,'both.jpg');



