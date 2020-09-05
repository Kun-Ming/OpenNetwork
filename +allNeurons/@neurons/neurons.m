classdef neurons < handle
    properties
        v_th = -10
        v_leaky = -60
        v 
        v_ref = -65
    end
    
    methods
        function obj = neurons(x)
            obj.v = x;% (obj.v_th - obj.v_leaky)*rand + obj.v_leaky;     % generate a random # between v_leaky and v_th
        end
        
        function set.v(obj, x)
            if x < obj.v_lb - obj.v
                obj.v = obj.v_lb - obj.v;
            else
                obj.v = x;
            end
        end
    end
end