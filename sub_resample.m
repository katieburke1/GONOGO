function [ fo ]= sub_resample( fi, n1, n_sample );
%
% Version 1.00
% resampling of data
%   - fft filter
%   - moving average
%
% Input - fi      : input function
%         n1      : number of data of fi
%         n_sampe : resampling frequency
%        
%
% Output- fo      : output data
%         n2      : number of resampled data
%
%  By Nobuhito Mori
%  Update 2001/04/10
%

%
% --- init setup
%


n2 = n1/n_sample;

%
% --- di-trend
%



% moving average

fo = zeros(n2,1);
for i=1:n2
   fo(i) = sum( fi( (i-1)*n_sample+1:i*n_sample ) )/n_sample;
end
%fo = fo';

