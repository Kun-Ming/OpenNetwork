classdef neurons < handle
    properties
        v_th
        v
        v_re
        neuron_type    %excitory or inhibitory
    end
    
    methods
        function obj = neurons(v_th, v, v_re, neuron_type)
            obj.v_th = v_th;
            obj.v = v;
            obj.v_re = v_re;
            obj.neuron_type = neuron_type;
        end
    end
end