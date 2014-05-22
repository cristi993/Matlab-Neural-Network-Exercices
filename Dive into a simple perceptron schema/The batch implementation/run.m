clear;
load x.mat;
load t.mat;

[w, y, err] = batchPerceptron(x, t, 1000, 0.5);
clf;
plotSet(x, t, w);