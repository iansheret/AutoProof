function y = bound_function(f, x, order)
%BOUND_FUNCTION Bound a function using a taylor model

% Copyright (c) 2016 Ian Sheret. This project is licensed under the terms
% of the MIT license. See the LICENSE file for details.

% Get a bound using a taylor model
x_tm       = TaylorModel.identity(lower(x), upper(x), order);
y_tm       = f(x_tm);
y_bound_tm = bound_polynomial(y_tm.P, x - median(x)) + y_tm.I;
if isnan(lower(y_bound_tm)) || isnan(upper(y_bound_tm))
    y_bound_tm = Interval(-Inf, Inf);
end

% Get a bound using interval arithmatic
y_bound_ia = f(x);
if isnan(lower(y_bound_ia)) || isnan(upper(y_bound_ia))
    y_bound_ia = Interval(-Inf, Inf);
end

% Take the intersection
y = Interval(...
    max(lower(y_bound_tm), lower(y_bound_ia)),... 
    min(upper(y_bound_tm), upper(y_bound_ia)));

end