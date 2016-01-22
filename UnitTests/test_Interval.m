function tests = test_Interval
%TEST_INTERVAL Unit tests for the Interval class.

% Copyright (c) 2016 Ian Sheret. This project is licensed under the terms
% of the MIT license. See the LICENSE file for details.

tests = functiontests(localfunctions);

end

% Constructor
function TestConstructorGeneratesValidObject(testCase)
in = Interval(3, 7);
verifyEqual(testCase, in.lower, 3);
verifyEqual(testCase, in.upper, 7);
end

% Arithmetic opperators
function TestPlusGivesCorrectAnswer(testCase)
in = Interval(2,5) + Interval(3,7);
verifyEqual(testCase, in.lower, 5);
verifyEqual(testCase, in.upper, 12);
end

function TestMinusGivesCorrectAnswer(testCase)
in = Interval(2,5) - Interval(3,7);
verifyEqual(testCase, in.lower,-5);
verifyEqual(testCase, in.upper, 2);
end

function TestTimesGivesCorrectAnswer(testCase)
table = [...
     2,5,    3, 7,    6,35;...
    -2,5,    3, 7,  -14,35;...
    -2,5,    3,-7,  -35,15];
for i=1:size(table,1)
    a = Interval(table(i,1), table(i,2));
    b = Interval(table(i,3), table(i,4));
    in = a .* b;
    verifyEqual(testCase, in.lower, table(i,5));
    verifyEqual(testCase, in.upper, table(i,6));
end
end

function TestDivideGivesCorrectAnswerForNonNaNCases(testCase)
table = [...
     2,5,    3, 7,    2/7,5/3;...
     2,5,    0, 7,    2/7,Inf;...
     2,5,   -3, 0,   -Inf,Inf];
for i=1:size(table,1)
    a = Interval(table(i,1), table(i,2));
    b = Interval(table(i,3), table(i,4));
    in = a ./ b;
    verifyEqual(testCase, in.lower, table(i,5));
    verifyEqual(testCase, in.upper, table(i,6));
end
end

function TestDivideGivesCorrectAnswerWhenNaN(testCase)
a = Interval(-3, 4);
b = Interval(-2, 5);
in = a ./ b;
import matlab.unittest.constraints.HasNaN;
verifyThat(testCase, in.upper, HasNaN);
verifyThat(testCase, in.lower, HasNaN);
end

function TestPowerGivesCorrectAnswer(testCase)
table = [...
      2,5,    0,    1,1;...
      2,5,    1,    2,5;...
      2,5,    2,    4,25;...
     -2,5,    2,    0,25;...
     -2,5,    3,   -8,125];
for i=1:size(table,1)
    a = Interval(table(i,1), table(i,2));
    b = table(i,3);
    in = a .^ b;
    verifyEqual(testCase, in.lower, table(i,4));
    verifyEqual(testCase, in.upper, table(i,5));
end
end

function TestSinGivesCorrectAnswer(testCase)
table = [...
      0.1,0.2,    sin(0.1),sin(0.2);...
      1.7,1.8,    sin(1.8),sin(1.7);...
      1.5,1.6,    sin(1.5),1;...
      4.7,4.8,    -1,sin(4.8);...
      1.5,4.8,    -1,1];
  
for i=1:size(table,1)
    a = Interval(table(i,1), table(i,2));
    in = sin(a);
    verifyEqual(testCase, in.lower, table(i,3));
    verifyEqual(testCase, in.upper, table(i,4));
end
end

function TestCosGivesCorrectAnswer(testCase)
table = [...
      0.1,0.2,    cos(0.2),cos(0.1);...
      3.2,3.3,    cos(3.2),cos(3.3);...
     -0.1,0.2,    cos(0.2),1;...
      3.0,3.5,    -1,cos(3.5);...
     -0.1,3.5,    -1,1];
  
for i=1:size(table,1)
    a = Interval(table(i,1), table(i,2));
    in = cos(a);
    verifyEqual(testCase, in.lower, table(i,3));
    verifyEqual(testCase, in.upper, table(i,4));
end
end
