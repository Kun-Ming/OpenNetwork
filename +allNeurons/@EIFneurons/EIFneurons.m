classdef EIFneurons < allNeurons.neurons
    properties
        ID
        tau_m = 15
        delta_t = 2
        v_t = -50
        v_lb = -100
        dt = .01
        ref_time = -NaN   % ref time begin
        ref_long = 1.5
        spike_train
    end
    
    methods
        function obj = EIFneurons(x, simulationTime)
            obj = obj@allNeurons.neurons(x);
            obj.spike_train = false(simulationTime, 1);
            obj.ref_time = 0;
        end  
        
        simulation(obj, input, dt);
    end
end