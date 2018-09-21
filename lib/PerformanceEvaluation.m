function [CRR1,CRR2] = PerformanceEvaluation(Correct1, Correct2, test_feature)
[row,col] = size(test_feature);
CRR1 = Correct1 / row;
CRR2 = Correct2 / row;