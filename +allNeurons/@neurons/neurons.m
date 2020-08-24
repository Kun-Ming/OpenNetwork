classdef neurons < handle
    properties
        v_th = -10
        v_leaky = -60
        v = (v_th - v_leaky)*rand + v_leaky     % generate a random # between v_leaky and b_th
        v_ref = -65
    end
    
end