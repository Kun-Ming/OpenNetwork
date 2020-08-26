classdef neurons
    properties
        v_th = -10
        v_leaky = -60
        v 
        v_ref = -65
    end
    
    methods
        function obj = neurons()
            obj.v = (obj.v_th - obj.v_leaky)*rand + obj.v_leaky;     % generate a random # between v_leaky and v_th
        end
    end
end