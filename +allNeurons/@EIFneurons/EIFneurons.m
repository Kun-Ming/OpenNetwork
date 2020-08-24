classdef EIFneurons < neurons
    properties
        tau_m = 15
        Delta_T = 2
        vT = -50
        v_lb = -100
        type    % exc or inh
        state   % ref or not
        spike_time
    end
    
    methods
        function obj = EIFneurons(type)
            obj.type = type;
        end
        
        function spike_time = EIF_Integrate(I_input)    %I_input: time * # of neuron
            t = len(I_input);   % total time
            spike_time = zeros(t);
            
            
        end
    end
    
    methods (Access = private)
        [v] = limit_neuron_v(obj);
    end
end
