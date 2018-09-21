function plot_circle(img, inner_circle, outer_circle)
    inner_centroid_x = inner_circle(2);
    inner_centroid_y = inner_circle(1);
    inner_radius = inner_circle(3);
    angle = [0:pi/50:2*pi];
    inner_x = inner_centroid_x + inner_radius*cos(angle);
    inner_y = inner_centroid_y + inner_radius*sin(angle);
    outer_centroid_x = outer_circle(2);
    outer_centroid_y = outer_circle(1);
    outer_radius = outer_circle(3);
    angl = [0:pi/50:2*pi];
    outer_x = outer_centroid_x + outer_radius*cos(angl);
    outer_y = outer_centroid_y + outer_radius*sin(angl);
    figure(1);
    imshow(img);
    hold on, plot(inner_x, inner_y, 'red');
    hold on, plot(outer_x, outer_y, 'red');
end