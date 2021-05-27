

[nameimage, pathimage, FilterIndexL] = uigetfile({'*.txt;*.asc','Text Files (*.txt;*.asc)'},...
        'First PL Data','MultiSelect','on');

number_of_graphs = str2double(inputdlg({'How many graphs you have:'},'Input',[1 35],{'1'}));    
    
    

name = [];
for i = 1:(number_of_graphs)
    
    file_name = char(nameimage(i));
    [peak_start, t, power] = deal(file_name(end-17:end-15),file_name(end-9:end-8), file_name(end-6:end-4));
    
    
   
    loaded_cell = dlmread([pathimage nameimage{i}]);
    loaded_second_cell = dlmread([pathimage nameimage{i+number_of_graphs}]);
    s = size(loaded_second_cell);
    
    x_values = [loaded_cell(1:1375) loaded_second_cell(1:s)]';
    y_values = [loaded_cell(1:1375,2)' loaded_second_cell(1:s,2)']';
    
    
    
    eV_x_values = [];
    for j = 1:length(x_values)
  
        k = x_values(j) *10^-9; %convert from nm to m
        h = (6.6261*10^-34); %plancks constant
        c = (2.9979*10^8); %speed of light
        eV = 1.602*10^-19; % 1 eV in Joules
        energy = (1/k) * (h*c)/(eV); %find value in eV
        eV_x_values = [eV_x_values; energy];
    end

    
    
    plot(eV_x_values, y_values, 'LineWidth', 2);
    xlabel( 'Wavelength(nm)', 'Interpreter', 'none' );
    ylabel( 'PL Count(a.u)', 'Interpreter', 'none' );
    name = [name string(power)];
    legend(name);
    title("Low Twist Angle HS PL w/ Varying Power")
    hold on
    
    
end




