function [kernel,convolution] = gaborFilter(roi_img,sigma_x, sigma_y)
[row, col] = size(roi_img);
f = 1/sigma_y;
roi_img = double(roi_img);
height = 4;
width = 4;
kernel = zeros(8,8);
for x = -width:width-1
    for y = -height:height-1
        kernel(width+x+1,height+y+1) = 1/(2*pi*sigma_x*sigma_y)*exp(-0.5*((x/sigma_x)^2+(y/sigma_y)^2))*cos(2*pi*f*sqrt(x^2+y^2));
    end
end
gabor_imag = conv2(roi_img,double(imag(kernel)),'same'); %calculate convolution
gabor_real = conv2(roi_img,double(real(kernel)),'same');
convolution = sqrt(gabor_imag.*gabor_imag + gabor_real.*gabor_real);
end

