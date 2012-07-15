
%%%%%%
%%%%%%1. load an audio segment.
[data, sampleRate,nbits] = wavread('speech_dft.wav');

%print out some information about this audio segment.
fprintf('audio length = %g s\n', length(data)/sampleRate);
fprintf('sample rate = %g Hz\n', sampleRate);
fprintf('number of bits persample = %g \n', nbits);
%plot the amplitude. 
plot((1:length(data))/sampleRate, data);
xlabel('Time in seconds');
ylabel('Amplitude');
%play this audio segment.
sound(data, sampleRate);

%%%%%%
%%%%%%2. Re-quantize the original audio segment to a lower precision.
[nativedata]= wavread('speech_dft.wav','native'); %get the native sound data.
nativedata = double(nativedata);
newNBits = 4; %set new number of bits persample

newQData = (nativedata + 2^(nbits-1)) * (2^newNBits-1) / (2^(nbits-1)*2 - 1);
newQData = round(newQData);
newQData = 2*newQData / (2^newNBits-1) - 1;
%plot the amplitude after re-quantization. 
figure;
plot((1:length(newQData))/sampleRate, newQData);
xlabel('Time in seconds');
ylabel('Amplitude');
%play the re-quantized sound data.
sound(newQData, sampleRate);

%%%%%%
%%%%%%3. Re-sample the original audio segment with a lower rate.
newSampleRate = 5000; %set the new sample rate.
newData = resample(data,newSampleRate,sampleRate);
figure;
plot((1:length(newData))/newSampleRate, newData);
xlabel('Time in seconds');
ylabel('Amplitude');
sound(newData, newSampleRate);

wavwrite(newData,newSampleRate,nbits,'down-sampled-audio.wav');
