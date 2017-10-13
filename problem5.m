% Question5:Download the latest data for the “Happy Planet Index” from
% http://www.happyplanetindex.org and “Corruption Perceptions
% Index” from http://www.transparency.org/cpi2014/in_detail . Both
% datasets are available as excel spread-sheets

hpi = readtable("HPI.xlsx");
cpi = readtable("CPI.xlsx");

%get only data of overlapping countries in both index
[c1,icpi,ihpi] = intersect(cpi.Country,hpi.Country);
cpi = cpi(icpi,:);
hpi = hpi(ihpi,:);

% Get the rank column in each index
cpi_rank = table2array(cpi(:,3));
hpi_rank = table2array(hpi(:,1));

% scatter plot of cpi vs hpi
scatter(hpi_rank, cpi_rank,'r', 'filled');
xlabel("HPI Rank");
ylabel("CPI Rank");
%Now attach labels to scatter plot
dx = 0.5; dy = 0.5; % displacement so the text does not overlay the data points
t = text(hpi_rank+dx, cpi_rank+dy, c1);
% decrease the font size of text labels
for i = 1:132
   t(i).FontSize = 8;
end

