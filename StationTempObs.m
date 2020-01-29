%% Add your names in a comment here at the beginning of the code!
%Rosa & Parker
% Instructions: Follow through this code step by step, while also referring
% to the overall instructions and questions from the lab assignment sheet.
% Everywhere you see "% -->" is a place where you will need to write in
% your own line of code to accomplish the next task.

%% 1a. Read in the file for your station as a data table
addpath(genpath('temperature-data-lab-part-1-rosaandparker'))
filename = '941200.csv'; %change this to select a different station
stationdata = readtable(filename);

%% 1b-c. Investigate the data you are working with
%Click in the workspace to open up the new table named stationdata. You
%should be able to see headers for each column in the table.

%Open up the original csv file (Excel is a good way to do this) to see how
%the imported headers match those in the original file.

%You should also be able to see the latitude and longitude of the original
%station in the csv file. Add these below:

stationlat =  - 12.4; %uncomment to run this line of code after adding the station latitude
stationlon = 130.87; %uncomment to run this line of code after adding the station longitude

%% 2. Plot the data from a single month
% Make a plot for all data from January with year on the x-axis and
% temperature on the y-axis. You will want this plot to have individual
% point markers rather than a line connecting each data point.

% --> 
figure
plot(stationdata.Year,stationdata.Jan,".")
title('January Temperature')
xlabel('Year')
ylabel('Temperature in Celsius')

% Calculate the monthly mean, minimum, maximum, and standard deviation
% note: some of these values will come out as NaN is you use the regular
% mean and std functions --> can you tell why? use the functions nanmean
% and nanstd to avoid this issue.

JanMean = nanmean(stationdata.Jan);
JanStd = nanstd(stationdata.Jan);
JanMin = min(stationdata.Jan);
JanMax = max(stationdata.Jan);

%% 3. Calculate the annual climatology
% Extract the monthly temperature data from the table and store it in an
% array, using the function table2array
tempData = table2array(stationdata(:,4:15));

%Calculate the mean, standard deviation, minimum, and maximum temperature
%for every month. This will be similar to what you did above for a single
%month, but now applied over all months simultaneously.
for i = 1:12
tempMean(1,i) = nanmean(tempData(:,i));
tempStd(1,i)  = nanstd(tempData(:,i));
tempMin(1,i)  = nanmin(tempData(:,i)); 
tempMax(1,i)  = nanmax(tempData(:,i));
end

%Use the plotting function "errorbar" to plot the monthly climatology with
%error bars representing the standard deviation. Add a title and axis
%labels. Use the commands "axis", "xlim", and/or "ylim" if you want to
%change from the automatic x or y axis limits.
% --> (note t/hat this may take multiple lines of code)

figure
errorbar([1:12]',tempMean',tempStd')
<<<<<<< HEAD
title('Annual Climatology')
xlabel('Month')
ylabel('Temp in Celsius')

=======
>>>>>>> a3d937c786a797f7fd137aba6d0cbaf75e57210d

%% 4. Fill missing values with the monthly climatological value
% Find all values of NaN in tempData and replace them with the
% corresponding climatological mean value calculated above.

% We can do this by looping over each month in the year:
for i = 1:length(tempData)
    for j = 1:12
        if isnan(tempData(i,j)) == 1
            tempData(i,j) = tempMean(1,j);
               %use the find and isnan functions to find the index location in the
    %array of data points with NaN values
    %indnan = find(isnan(tempData(:,i)) == 1); %check to make sure you understand what is happening in this line
    %now fill the corresponding values with the climatological mean
    % --> 
    end
    end
end

%% 5a. Calculate the annual mean temperature for each year
for i = 1:length(tempData)
    annTempMean(i,1) = mean(tempData(i,1:12));
end

%% 5b-c. Calculate the temperature anomaly for each year, compared to the 1981-2000 mean
% The anomaly is the difference from the mean over some baseline period. In
% this case, we will pick the baseline period as 1981-2000 for consistency
% across each station (though note that this is a choice we are making, and
% that different temperature analyses often pick different baselines!)

%Calculate the annual mean temperature over the period from 1981-2000
  %Use the find function to find rows contain data where stationdata.Year is between 1981 and 2000
    n = 1;
    stationdataArray = table2array(stationdata);
    for i = 1:length(tempData)
        for j = 1981:2000
        if stationdataArray(i,3) == j  
        meanBase(n,1) = mean(tempData(i,1:12));
        n = n +1;
        end
        end
    end
    
  %Now calculate the mean over the full time period from 1981-2000
% -->

meanBaseNum = mean(meanBase);

%Calculate the annual mean temperature anomaly as the annual mean
%temperature for each year minus the baseline mean temperature
% -->

annMeanTempAnom = annTempMean - meanBaseNum;

%% 6a. Plot the annual temperature anomaly over the full observational record
%Make a scatter plot with year on the x axis and the annual mean
%temperature anomaly on the y axis
% -->  

figure
plot(stationdataArray(:,3),annMeanTempAnom,'.')
hold on
<<<<<<< HEAD
title('Annual Temperature Anomaly')
xlabel('Year')
ylabel('Temperature Anomaly in Celsius')
=======
>>>>>>> a3d937c786a797f7fd137aba6d0cbaf75e57210d

%% 6b. Smooth the data by taking a 5-year running mean of the data to plot
%This will even out some of the variability you observe in the scatter
%plot. There are many methods for filtering data, but this is one of the
%most straightforward - use the function movmean for this. For information
%about how to use this function, type "help movmean" in the command window.
% --> 
annTempMovMean = movmean(annMeanTempAnom,5);
%Now add a line with this smoothed data to the scatter plot
% --> 
plot(stationdataArray(:,3),annTempMovMean)
<<<<<<< HEAD
title('Annual Temperature Anomaly')
xlabel('Year')
ylabel('Temperature Anomaly in Celsius')
=======
>>>>>>> a3d937c786a797f7fd137aba6d0cbaf75e57210d

%% 7. Add and plot linear trends for whole time period, and for 1960 to today
%Here we will use the function polyfit to calculate a linear fit to the data
%For more information, type "help polyfit" in the command window and/or
%read the documentation at https://www.mathworks.com/help/matlab/data_analysis/linear-regression.html
    %use polyfit to calculate the slope and intercept of a best fit line
    %over the entire observational period


    %also calculate the slope and intercept of a best fit line just from
    %1960 to the end of the observational period
    % Hint: start by finding the index for where 1960 is in the list of
    % years
% --> 

%Add lines for each of these linear trends on the annual temperature
%anomaly plot (you can do this either directly using the slope and intercept
%values calculated with polyfit, or using the polyval function).
%Plot each new line in a different color.
% -->

% Add a legend, axis labels, and a title to your temperature anomaly plot
% --> 