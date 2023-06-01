data = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4];  % Example data array

hist = histogram(data, 'Normalization', 'pdf');  % Compute the histogram and normalize it
pdf_values = hist.Values;  % Get the PDF values

bin_edges = hist.BinEdges;  % Get the bin edges

bar(bin_edges(1:end-1), pdf_values, 'histc');  % Plot the PDF as a bar chart
title('Probability Density Function (PDF)');
xlabel('Data');
ylabel('PDF');
