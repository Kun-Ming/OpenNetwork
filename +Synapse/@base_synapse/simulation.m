function simulation(obj, time_now, keOutDegree, kiOutDegree)
% base_synapse simulation
    if nargin > 1
        spike_time = find(obj.presyn_neuron.spike_train); % spike train of pre synpatic neuron
        if max(size(spike_time)) > time_now
            spike_time = spike_time(1 : time_now);
        end

        presyn_I = @() (1 / (obj.taud - obj.taur)...
                    * ( exp((time_now - spike_time) / obj.taud) - ...
                    exp((time_now - spike_time) / obj.taur) ) );    

        switch obj.pre_ei_type
            case 'exc'

                recurrent_I = ( obj.conn_strength / sqrt(keOutDegree) )...
                    * sum(presyn_I());

            case 'inh'

                recurrent_I = ( obj.conn_strength / sqrt(kiOutDegree) )...
                    * sum(presyn_I());

        end

        %simulation in single neuron
                obj.postsyn_neuron.simulation(recurrent_I, time_now);
    else
        disp('synapse simulation');
    end
end