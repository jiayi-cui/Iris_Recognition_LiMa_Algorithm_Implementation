
function [inner_circle, outer_circle] = IrisLocation(img)
    inner_circle = PupilDetection(img);
    outer_circle = iris_boundary(img, inner_circle);
    function inner_circle = PupilDetection(img)
        pupil = img < 40;
        pupilEdge = edge(pupil, 'canny');
        [r,c] = size(pupil);
        [edRow, edCol] = find(pupilEdge);
        edgePoints = size(edRow); % number of pixals of the edge
        hough_space = zeros(r, c, 25);
        for i = 1:edgePoints
            for rad = 36:60 % the range of radius to detect
                for ang = 1:round(2*pi/0.05) % for given r detect every 0.02 degree
                    x = round(edRow(i)-rad*cos(0.05*ang));
                    y = round(edCol(i)-rad*sin(0.05*ang));
                    if (x>0&x<=r&y>0&y<=c)
                        hough_space(x, y, rad-35) = hough_space(x, y, rad-35) + 1;
                    end
                end
            end
        end
        max_para = max(max(max(hough_space)));  
        index = find(hough_space>=max_para*0.9);
        length = size(index); 
        sumpara = [0,0,0];
        for k=1:length  
            par3 = floor(index(k)/(r*c))+1;  
            par2 = floor((index(k)-(par3-1)*(r*c))/r)+1;  
            par1 = index(k)-(par3-1)*(r*c)-(par2-1)*r;
            par3 = 35+(par3-1)*1;
            sumpara = sumpara + [par1,par2,par3];
        end
        inner_circle = round(sumpara/length(1)); 
  
    
    function outer_circle = iris_boundary(img, inner_circle)
        iris_edge = edge(img, 'canny');
        inner_left = inner_circle(2)-inner_circle(3)-20;
        inner_right = inner_circle(2)+inner_circle(3)+20;
        if inner_left <=0
            inner_left = 1;
        end
        if inner_right > 320
            inner_right = 320;
        end
        inner_upper = inner_circle(1)+inner_circle(3)+15;
        if inner_upper > 280
            inner_upper = 280;
        end
        if inner_upper <= 0
            inner_upper = 1;
        end
        for i = inner_left : inner_right
            for j = 1 : inner_upper
                iris_edge(j,i) = 0;
            end
        end
        [row,col] = size(iris_edge);
        iris_edge(1:inner_circle(1)-60,:) = 0;
        iris_edge(inner_circle(1)+100:row,:) = 0;
        iris_edge(:,1:inner_circle(2)-120) = 0;
        iris_edge(:,inner_circle(2)+120:col) = 0;
        [edger, edgec] = find(iris_edge);
        edge_points = size(edger);
        houghSpace = zeros(row, col, 15);
        for i = 1:edge_points
            for rad = 81:95 
                for ang = 1:round(2*pi/0.05) 
                    x = round(edger(i)-rad*cos(0.05*ang));
                    y = round(edgec(i)-rad*sin(0.05*ang));
                    if (x>0&x<=row&y>0&y<=col)
                        houghSpace(x, y, rad-80) = houghSpace(x, y, rad-80) + 1;
                    end
                end
            end
        end
        maxi_para = max(max(max(houghSpace)));
        ind = find(houghSpace>=0.8*maxi_para);
        len = size(ind);
        sumpar = [0,0,0];
        for k=1:len(1)  
            para3 = floor(ind(k)/(row*col))+1;  
            para2 = floor((ind(k)-(para3-1)*(row*col))/row)+1;  
            para1 = ind(k)-(para3-1)*(row*col)-(para2-1)*row;
            para3 = 80+(para3-1)*1;
            sumpar = sumpar + [para1,para2,para3];
        end
        outer_circle = round(sumpar/len(1));
  
    