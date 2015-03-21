%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Audio Degradation Toolbox
%
% Centre for Digital Music, Queen Mary University of London.
% This file copyright 2013 Sebastian Ewert, Matthias Mauch and QMUL.
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License as
% published by the Free Software Foundation; either version 2 of the
% License, or (at your option) any later version.  See the file
% COPYING included with this distribution for more information.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Note: Some degradations impose a delay/temporal distortion on the input
% data. The last example shows, given time positions before the
% degradation, how the corresponding time positions after the degradation
% can be retrieved

%%

clear

addpath(genpath(fullfile(pwd,'AudioDegradationToolbox')));

dataDir = '../dataset/genre';
dirlist = dir(dataDir);
filenames = {};

for i = 1:length(dirlist)
    if dirlist(i).isdir && ~strcmp(dirlist(i).name, '.') && ...
            ~strcmp(dirlist(i).name, '..')
        filelist = dir(fullfile(dataDir, dirlist(i).name));
        for j = 1:length(filelist)
            [pathstr,name,ext] = fileparts(filelist(j).name);
            if strcmp(ext, '.wav')
                filename = fullfile(dataDir, dirlist(i).name, filelist(j).name); 
                filenames = [filenames, filename];
            end
        end
    end
end


pathOutputDemo = 'demoOutput/';
if ~exist(pathOutputDemo,'dir'), mkdir(pathOutputDemo); end

%filenames = {
%    'testdata/RWC_G39.wav';
%    'testdata/RWC_G72.wav';
%    'testdata/RWC_G84.wav';
%    'testdata/RWC_P009m_drum.wav';
%    'testdata/RWC-C08.wav';
%    'testdata/session5-faure_elegie2c-001-0.wav';
%    'testdata/175234__kenders2000__nonsense-sentence.wav';
%    };

createSpectrograms = 0;

%%
% just copying original files to the demo folder
%maxValueRangeVis = zeros(length(filenames));
%for k=1:length(filenames)
%    copyfile(filenames{k}, fullfile(pathOutputDemo,sprintf('00_Original_file%d.wav',k)))
%    if createSpectrograms
%        [f_audio,samplingFreq]=wavread(filenames{k});
%        [s,f,t] = spectrogram(f_audio,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
%        figure; imagesc(t,f,log10(abs(s)+1)); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputDemo,sprintf('00_Original_file%d.png',k)))
%        maxValueRangeVis(k) = max(max(log10(abs(s)+1)));
%    end
%end

%%

% liveRecoding
fprintf('Generating LiveRecorsing...\n');

pathOutputLiveRecording = [pathOutputDemo, 'liveRecording/'];
if ~exist(pathOutputLiveRecording,'dir'), mkdir(pathOutputLiveRecording); end

for k=1:length(filenames)
    [f_audio,samplingFreq]=wavread(filenames{k});
    
    f_audio_out = applyDegradation('liveRecording', f_audio, ...
                                   samplingFreq);
    [pathstr,name,ext] = fileparts(filenames{k});
        
    wavwrite(f_audio_out,samplingFreq,16,fullfile(pathOutputLiveRecording,sprintf('Degr_01_liveRecording_%s.wav',name)));
    if createSpectrograms
        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputLiveRecording,sprintf('Degr_01_liveRecording_file%d.png',k)))
    end
end

%%
%for k=1:length(filenames)
%    [f_audio,samplingFreq]=wavread(filenames{k});
%    
%    f_audio_out = applyDegradation('strongMp3Compression', f_audio, samplingFreq);
%    
%    wavwrite(f_audio_out,samplingFreq,16,fullfile(pathOutputDemo,sprintf('Degr_02_strongMp3Compression_file%d.wav',k)));
%    if createSpectrograms
%        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
%        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputDemo,sprintf('Degr_02_strongMp3Compression_file%d.png',k)))
%    end
%end

%%

% Vinyl
fprintf('Generating VinylRecording...\n');

pathOutputVinyl = [pathOutputDemo, 'VinylRecording/'];
if ~exist(pathOutputVinyl,'dir'), mkdir(pathOutputVinyl); end

for k=1:length(filenames)
    [f_audio,samplingFreq]=wavread(filenames{k});
    
    f_audio_out = applyDegradation('vinylRecording', f_audio, samplingFreq);
    
    [pathstr,name,ext] = fileparts(filenames{k});
        
    wavwrite(f_audio_out,samplingFreq,16,fullfile(pathOutputVinyl,sprintf('Degr_03_vinylRecording_%s.wav',name)));
    if createSpectrograms
        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputVinyl,sprintf('Degr_03_vinylRecording_file%d.png',k)))
    end
end

%%
%for k=1:length(filenames)
%    [f_audio,samplingFreq]=wavread(filenames{k});
%    
%    f_audio_out = applyDegradation('radioBroadcast', f_audio, samplingFreq);
%    
%    wavwrite(f_audio_out,samplingFreq,16,fullfile(pathOutputDemo,sprintf('Degr_04_radioBroadcast_file%d.wav',k)));
%    if createSpectrograms
%        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
%        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputDemo,sprintf('Degr_04_radioBroadcast_file%d.png',k)))
%    end
%end
%
%%

% smartPhoneRecording
fprintf('Generating SmartPhoneRecording...\n');

pathOutputsmartPhoneRecording = [pathOutputDemo, 'smartPhoneRecording/'];
if ~exist(pathOutputsmartPhoneRecording,'dir'), mkdir(pathOutputsmartPhoneRecording); end

for k=1:length(filenames)
    [f_audio,samplingFreq]=wavread(filenames{k});
    
    f_audio_out = applyDegradation('smartPhoneRecording', f_audio, samplingFreq);

    [pathstr,name,ext] = fileparts(filenames{k});
    
    wavwrite(f_audio_out,samplingFreq,16,fullfile(pathOutputsmartPhoneRecording,sprintf('Degr_05_smartPhoneRecording_%s.wav',name)));
    if createSpectrograms
        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(pathOutputsmartPhoneRecording,sprintf('Degr_05_smartPhoneRecording_file%d.png',k)))
    end
end

%%

% smartPhonePlayback
%fprintf('Generating SmartPhonePlayback...\n');
%
%pathOutputsmartPhonePlayback = [pathOutputDemo, 'smartPhonePlayback/'];
%if ~exist(pathOutputsmartPhonePlayback,'dir'), mkdir(pathOutputsmartPhonePlayback); end
%
%for k=1:length(filenames)
%    [f_audio,samplingFreq]=wavread(filenames{k});
%    
%    f_audio_out = applyDegradation('smartPhonePlayback', f_audio, samplingFreq);
%
%    [pathstr,name,ext] = fileparts(filenames{k});
%    
%    wavwrite(f_audio_out,samplingFreq,16,fullfile(smartPhonePlayback,sprintf('Degr_06_smartPhonePlayback_%s.wav',name)));
%    if createSpectrograms
%        [s,f,t] = spectrogram(f_audio_out,hamming(round(samplingFreq*0.093)),round(samplingFreq*0.093/2),[],samplingFreq);
%        figure; imagesc(t,f,log10(abs(s)+1),[0 maxValueRangeVis(k)]); axis xy; colormap(hot); ylim([0,8000]); colorbar; print('-dpng', fullfile(smartPhonePlayback,sprintf('Degr_06_smartPhonePlayback_file%d.png',k)))
%    end
%end
%
%%
% Some degradations delay the input signal. If some timepositions are given
% via timepositions_beforeDegr, the corresponding positions will be returned
% in timepositions_afterDegr. In this case, there is no need for f_audio
% and samplingFreq as above but they could be specified too.
%timepositions_beforeDegr = [5, 60];
%[~,timepositions_afterDegr] = applyDegradation('radioBroadcast', [], [], timepositions_beforeDegr);
%fprintf('radioBroadcast: corresponding positions:\n');
%for k=1:length(timepositions_beforeDegr) fprintf('%g -> %g\n',timepositions_beforeDegr(k),timepositions_afterDegr(k)); end
