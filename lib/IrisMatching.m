function [Correct1,Correct2] = IrisMatching(train_feature,test_feature)
[r,c] = size(train_feature);
subtrain = zeros(r,257);
subtrain(:,1:129) = train_feature(:,1:129);
subtrain(:,130:257) = train_feature(:,770:897);
[row,col] = size(test_feature);
subtest = zeros(row,257);
subtest(:,1:129) = test_feature(:,1:129);
subtest(:,130:257) = test_feature(:,770:897);
knnmodel = fitcknn(subtrain,train_feature(:,1));
prediction = predict(knnmodel,subtest);
Correct1 = sum(prediction == test_feature(:,1));
[mappedtest, mappingtest] = lda(subtest(:,2:257),subtest(:,1),107);
[mappedtrain, mappingtrain] = lda(subtrain(:,2:257),subtrain(:,1),107);
mappedtest = real(mappedtest);
mappedtrain = real(mappedtrain);
ldamodel = fitcknn(mappedtrain,train_feature(:,1));
predicted = predict(ldamodel,mappedtest);
Correct2 = sum(predicted == test_feature(:,1));


