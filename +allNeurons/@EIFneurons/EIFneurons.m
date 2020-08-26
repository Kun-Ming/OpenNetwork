classdef EIFneurons < allNeurons.neurons
    properties
        tau_m = 15
        Delta_T = 2
        vT = -50
        v_lb = -100
        state   % ref or not
        spike_train
        ID
    end
    
    methods
%         function obj = EIFneurons(type)
%             obj.type = type;
%         end
        [v] = limit_neuron_v(obj, v_calcuted);
    end
end