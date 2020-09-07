function simulation(obj, time_now, keOutDegree, kiOutDegree)
    
    spike_time = find(obj.presyn_neuron.spike_train); % spike train of pre synpatic neuron

    presyn_I = @() (1 / (obj.taud - obj.taur)...
                * ( exp((time_now - spike_time) / taud) - ...
                exp((time_now - spike_time) / taur) ) );    
    
    switch obj.ei_type
        case 'exc'
            
            recurrent_I = ( obj.conn_strength / sqrt(keOutDegree) )...
                * sum(presyn_I());

            %simulation in single neuron
            obj.postsyn_neuron.simulation(recurrent_I, time_now);

        case 'inh'
            
            recurrent_I = ( obj.conn_strength / sqrt(kiOutDegree) )...
                * sum(presyn_I());

            %simulation in single neuron
            obj.postsyn_neuron.simulation(-recurrent_I, time_now);
    end
end