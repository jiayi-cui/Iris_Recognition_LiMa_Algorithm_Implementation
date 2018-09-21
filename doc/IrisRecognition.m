fold = 'CASIA Iris Image Database (version 1.0)';
train_feature = zeros(324,1537);
for i = 1:108
    if i < 10
        subfold = '00';
    elseif i < 100
        subfold = '0';
    else
        subfold = '';
    end
    for j = 1
        for k = 1:3
            filename1 = strcat(fold,'/',subfold,num2str(i),'/',num2str(j),'/',subfold,num2str(i),'_',num2str(j),'_',num2str(k),'.bmp');
            img = imread(filename1);
            [inner_circle, outer_circle] = IrisLocalization(img);
            localized_img = plotLocalizedImg(img, inner_circle, outer_circle);
            normalized_iris = IrisNormalization(img, outer_circle, inner_circle); % 64*512
            enhanced_img = ImageEnhancement(normalized_iris);
            roi_area = enhanced_img(1:48,:);
            [fc_1,fc_2] = FeatureExtraction(roi_area);
            feature_vec = [fc_1,fc_2];
            train_feature(3*(i-1)+k,1) = i;
            train_feature(3*(i-1)+k,2:1537) = feature_vec;
        end
    end
end
       

test_feature = zeros(432,1537);
for i = 1:108
    if i < 10
        subfold = '00';
    elseif i < 100
        subfold = '0';
    else
        subfold = '';
    end
    for j = 2
        for k = 1:4
            filename2 = strcat(fold,'/',subfold,num2str(i),'/',num2str(j),'/',subfold,num2str(i),'_',num2str(j),'_',num2str(k),'.bmp');
            img = imread(filename2);
            [inner_circle, outer_circle] = IrisLocalization(img);
            localized_img = plotLocalizedImg(img, inner_circle, outer_circle);
            normalized_iris = IrisNormalization(img, outer_circle, inner_circle); % 64*512
            enhanced_img = ImageEnhancement(normalized_iris);
            roi_area = enhanced_img(1:48,:);
            [fc_1,fc_2] = FeatureExtraction(roi_area);
            feature_vec = [fc_1,fc_2];
            test_feature(4*(i-1)+k,1) = i;
            test_feature(4*(i-1)+k,2:1537) = feature_vec;
        end
    end
end

[Correct1,Correct2] = IrisMatching(train_feature,test_feature);
[CRR_whole_feature, CRR_lda] = PerformanceEvaluation(Correct1,Correct2,test_feature);
