inputImage = imread('riceTest.png');
figure;

% Convert the image to grayscale 
grayImage = rgb2gray(inputImage);

% Display the original grayscale image
subplot(2, 3, 1);
imshow(grayImage);
title('Grayscale Image');

%{ 
 Calculating the mode gray level, which represents the most frequently
 occurring intensity value in the image. The use of grayImage(:) flattens 
 the 2D grayscale image into a column vector. This flattening step makes
 it easier to calculate the mode.
%}
FreqIntensityValue = mode(grayImage(:));

% Display the histogram of the grayscale image so we can visualize 
% the most frequently occurring intensity values.
subplot(2, 3, 2);
imhist(grayImage);
title('Histogram')

%{ 
 Create a binary mask excluding the range
 [FreqIntensityValue - 2, FreqIntensityValue + 2]. 
 Intensity values outside this range are marked as 1, indicating that 
 they are of interest or different from the background.
%}

mask = (grayImage<FreqIntensityValue-2) | (grayImage>FreqIntensityValue+2);

% Display the binary mask
subplot(2, 3, 3);
imshow(mask);
title('Binary Mask');

%{ 
Performing erosion to separate touching objects to make it easier to 
distinguish and label individual objects. I needed it in the rice image
since there was touching objects
%}

%{ 
 Create structuring element (kernel) in the shape of a disk with a 
 radius of 5 pixels. After experimenting with multiple shapes and 
 different sizes, it turns out that a Disk with radius of 5 is suitable.
%} 

kernel = strel('Disk', 5); 
mask = imerode(mask, kernel);


% Label the components in the mask
[~, Count] = bwlabel(mask);

subplot(2, 3, [4,5,6]);
imshow(inputImage);
title(sprintf('Number of Objects: %d', Count));


