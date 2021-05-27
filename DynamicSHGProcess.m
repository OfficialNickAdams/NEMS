clear
close all

% read raw data
[nameimage, pathimage, FilterIndexL] = uigetfile({'*.txt;*.asc','Text Files (*.txt;*.asc)'},...
        'CCD image to be processed','MultiSelect','on');
if isa(nameimage,'char')
    hold = nameimage;
    clear nameimage
    nameimage = {};
    nameimage(1) = {hold};
end

number_plot = str2double(inputdlg({'How many plot you have:'},'Input',[1 35],{'1'}));
SHG =[];


%we want to first scan to check where the peak is appearing


oldmaxpeak = 0;
peaklocation = 0;


for i = 1:number_plot
    rawdata = dlmread([pathimage nameimage{i}]);
    for j = 970:1000
        if rawdata(j,2) > oldmaxpeak
            oldmaxpeak = rawdata(j,2);
            peaklocation = j;
        end
    end

    oldmaxpeak = 0;
    % get 532 wavelength
    shg = rawdata(peaklocation,2);
    SHG(i,:) = shg;
end


%save processed data
saveO = menu('save processed rawdata?', 'Yes', 'No');
processed_data = SHG(:,1);

if saveO==1
    savepath=[pathimage nameimage{1}(1:end-4) ' processed_dynamic.txt'];
    save(savepath, 'processed_data' ,'-ASCII')
end
     

   

