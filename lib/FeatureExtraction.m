function [fc_1,fc_2] = FeatureExtraction(roi_area)
[kernel_1,convolution_1] = gaborFilter(roi_area,3,1.5);
[kernel_2,convolution_2] = gaborFilter(roi_area,4.5,1.5);
fc_1 = zeros(1,768);
fc_2 = zeros(1,768);
i=1;
j=1;
k = 1;
while i <= 6
    while j <= 64
        sum_1 = 0;
        sum_2 = 0;
        x = 8*(i-1) + 1;
        y = 8*(j-1) + 1;
        sum_1 = sum(sum(convolution_1(x:x+7,y:y+7)));
        sum_2 = sum(sum(convolution_2(x:x+7,y:y+7)));
        fc_1(2*k-1) = sum_1 / 64;
        fc_2(2*k-1) = sum_2 / 64;
        k = k + 1;
        j = j + 1;
    end
    i = i + 1;
end
l = 1;
m = 1;
n = 1;
while m <= 6
    while n <= 64
        sum_1 = 0;
        sum_2 = 0;
        x = 8*(m-1) + 1;
        y = 8*(n-1) + 1;
        m1 = fc_1(2*l-1);
        m2 = fc_2(2*l-1);
        block_1 = convolution_1(x:x+7,y:y+7);
        block_2 = convolution_2(x:x+7,y:y+7);
        sum_1 = sum(sum(abs(block_1 - m1)));
        sum_2 = sum(sum(abs(block_2 - m2)));
        fc_1(2*l) = sum_1 / 64;
        fc_2(2*l) = sum_2 / 64;
        l = l + 1;
        n = n + 1;
    end
    m = m + 1;
end

    