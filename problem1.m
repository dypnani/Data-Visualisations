%Question 1:Using the World Bank Indicators, download data for “GDP per
% capita (current US$)” and “Malnutrition prevalence, weight for age
% (% of children under 5).”

gdp = readtable("gdp.csv");
gdp_meta = readtable("gdp_metadata.csv"); 
gdp_meta.Properties.VariableNames{'x____CountryCode_'} = 'CountryCode';
malnut = readtable("malnutrition.csv");
malnut_meta =readtable("malnutrition_metadata.csv");
malnut_meta.Properties.VariableNames{'x____CountryCode_'} = 'CountryCode';

%cleaning data set to ensure meta data and actual data have same rows
[c,i] = setdiff(gdp.CountryCode,gdp_meta.CountryCode);
gdp(i,:) = [];
malnut(i,:) = [];

%joining actual data and metadata 
gdp = join(gdp,gdp_meta,'keys','CountryCode');
malnut = join(malnut,malnut_meta,'keys','CountryCode');

%extracting relevant data for all the years(from column 5 to 61) for gdp and malnutrition
gdp_array = str2double(table2array(gdp(:,5:61)));
malnut_array = str2double(table2array(malnut(:,5:61)));

%eliminate the missing values
I = ~isnan(gdp_array) & ~isnan(malnut_array); %to eliminate NAN
x = gdp_array(I);
y = malnut_array(I);

%plotting scatterplot  malnutrition against gdp
figure 
scatter(x,y);
ylabel("Malnutrition");
xlabel("GDP per capita");
title("Malnutrition against GDP");

%  plotting graph for developing regions
figure
group1 = gdp.Region;
in = find(strcmp(group1, 'North America')); %excluding the developed region  from the group
group1(in,:) = [];
Index = ~cellfun(@isempty,group1);
gscatter(x(Index),y(Index),group1(Index));
ylabel("Malnutrition");
xlabel("GDP per capita");
title("Malnutrition against GDP");

% plotting a graph for income levels
figure
group2 = gdp.IncomeGroup;
Index = ~cellfun(@isempty,group2);
gscatter(x(Index),y(Index),group2(Index));
ylabel("Malnutrition");
xlabel("GDP per capita");
title("Malnutrition against GDP");


