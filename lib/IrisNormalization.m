function normalized_iris = IrisNormalization(localized_img, outer_circle, inner_circle)
normalized_iris = zeros(64,512);
[row, col] = size(normalized_iris);
centroid_x = inner_circle(1);
centroid_y = inner_circle(2);
angle = 2*pi / col;
upper_boundary_x = zeros(1,col);
upper_boundary_y = zeros(1,col);
lower_boundary_x = zeros(1,col);
lower_boundary_y = zeros(1,col);
for j = 1:col
    lower_boundary_x(1,j) = centroid_x + inner_circle(3)*cos(angle*j);
    lower_boundary_y(1,j) = centroid_y + inner_circle(3)*sin(angle*j);
    upper_boundary_x(1,j) = centroid_x + outer_circle(3)*cos(angle*j);
    upper_boundary_y(1,j) = centroid_y + outer_circle(3)*sin(angle*j);
end
x = zeros(row,col);
y = zeros(row,col);
for i = 1:row 
    x(i,:) = round(lower_boundary_x(1,:) + (upper_boundary_x(1,:) - lower_boundary_x(1,:))*i/row);   
    y(i,:) = round(lower_boundary_y(1,:) + (upper_boundary_y(1,:) - lower_boundary_y(1,:))*i/row);
end 
for i = 1:row
    for j = 1:col
        if x(i,j) < 1
            x(i,j) = 1;
        end
        if x(i,j) > 280
            x(i,j) = 280;
        end
        if y(i,j) < 1
            y(i,j) = 1;
        end
        if y(i,j) > 280
            y(i,j) = 280;
        end
        normalized_iris(i,j) = localized_img(x(i,j),y(i,j));
    end
end
normalized_iris = uint8(normalized_iris);

