function tests = test_polynomials
%TEST_POLYNOMIALS Unit tests for polynomial functions.

% Copyright (c) 2016 Ian Sheret. This project is licensed under the terms
% of the MIT license. See the LICENSE file for details.

tests = functiontests(localfunctions);

end

% Polynomial bounding
function TestBoundPolynomialGiveCorrectAnswer(testCase)
I = bound_polynomial([1,-2,0], Interval(0, 3));
verifyEqual(testCase, I.lower, -1);
verifyEqual(testCase, I.upper, 3);
end

function TestBoundPolynomialHandlesNonfiniteCoeffs(testCase)
I = bound_polynomial([1,-2,Inf], Interval(0, 3));
verifyEqual(testCase, I.lower, -Inf);
verifyEqual(testCase, I.upper, Inf);
end

% Polynomial splitting
function TestSplitPolynomialGiveCorrectAnswer(testCase)
[high,low] = split_polynomial(1:10, 3);
verifyEqual(testCase, low, 7:10);
verifyEqual(testCase, high, [1:6, 0, 0, 0, 0]);
end
