function localized_img = plotLocalizedImg(img, inner_circle, outer_circle)
localized_img = img;
[nrow, ncol] = size(img);
localized_img(1:outer_circle(1)-outer_circle(3),:) = 0;
localized_img(outer_circle(1)+outer_circle(3):nrow,:) = 0;
localized_img(:,1:outer_circle(2)-outer_circle(3)) = 0;
localized_img(:,outer_circle(2)+outer_circle(3):ncol) = 0;
outer_dist = zeros(nrow, ncol);
inner_dist = zeros(nrow, ncol);
outer_lower_point = outer_circle(1) - outer_circle(3);
outer_upper_point = outer_circle(1) + outer_circle(3);
if outer_lower_point <= 0
    outer_lower_point = 1;
end
if outer_upper_point >= 280
    outer_upper_point = 280;
end
outer_left_point = outer_circle(2) - outer_circle(3);
outer_right_point = outer_circle(2) + outer_circle(3);
if outer_left_point <= 0
    outer_left_point = 1;
end
if outer_right_point >= 320
    outer_right_point = 320;
end
inner_left_point = inner_circle(2) - inner_circle(3);
inner_right_point = inner_circle(2) + inner_circle(3);
if inner_left_point <= 0
    inner_left_point = 1;
end
if inner_right_point >= 320
    inner_right_point = 320;
end
for i = outer_lower_point:outer_upper_point
    outer_dist(i,:) = (i - outer_circle(1))^2;
end
for j = outer_left_point:outer_right_point
    outer_dist(:,j) = outer_dist(:,j) + (j - outer_circle(2))^2;
end
inner_squre = round(outer_circle(3)/sqrt(2)) - 1;
lower_arc = outer_circle(1) - inner_squre;
upper_arc = outer_circle(1) + inner_squre;
left_arc = outer_circle(2) - inner_squre;
right_arc = outer_circle(2) + inner_squre;
if lower_arc <= 0
    lower_arc = 1;
end
if upper_arc >= 280
    upper_arc = 280;
end
if left_arc <= 0
    left_arc = 1;
end
if right_arc >= 320
    right_arc = 320;
end
for i = outer_lower_point:lower_arc
    for j = outer_left_point:outer_right_point
        if outer_dist(i,j) > outer_circle(3)^2
            localized_img(i,j) = 0;
        end
    end
end
for i = upper_arc:outer_upper_point
    for j = outer_left_point:outer_right_point
        if outer_dist(i,j) > outer_circle(3)^2
            localized_img(i,j) = 0;
        end
    end
end
for i = lower_arc:upper_arc
    for j = outer_left_point:left_arc
        if outer_dist(i,j) > outer_circle(3)^2
            localized_img(i,j) = 0;
        end
    end
end
for i = lower_arc:upper_arc
    for j = right_arc:outer_right_point
        if outer_dist(i,j) > outer_circle(3)^2
            localized_img(i,j) = 0;
        end
    end
end
for i = outer_lower_point:outer_upper_point
    for j = inner_left_point:inner_right_point
        if (i - inner_circle(1))^2 + (j - inner_circle(2))^2 < inner_circle(3)^2
            localized_img(i,j) = 0;
        end
    end
end
