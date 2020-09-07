function simulation(obj, time_now)   
    % recurit all neuron in 1 ms resolution
%     keOutDegree = sum(1 : 1 : obj.ke-2) * 4 + (obj.ke - 1) * 4; % a diamond shape of projection range    
%     kiOutDegree = sum(1 : 1 : obj.ki-2) * 4 + (obj.ki - 1) * 4;
    for i = 1 : obj.total_neurons
        % 时刻t只与时刻 1...t-1 有关
        %---
        %main中simulation的顺序：
        % layer1 recurrent
        % layer1 feedforward
        % layer2 recurrent
        % ...
        %---
        % 遍历的是pre synaptic neuron, 产生t时刻spike和refactory period,
        % 并更新post synaptic neuron membrane potential.
        
        syn = obj.syn_in_layer(i);
        syn.simulation();
%         size_post_syn_cell = size(syn);
%         length = max(size_post_syn_cell);   % # of post synaptic neuron
        
%         for j = 1 : length
%             switch syn(j).ei_type
%                 case 'exc'
%                     spike_time = find(obj.neuron_in_layer(i).spike_train); %spike train of pre synpatic neuron
%                     
%                     presyn_I = @() (1 / (syn(j).taud - syn(j).taur)...
%                         * ( exp((time_now - spike_time) / taud) - ...
%                         exp((time_now - spike_time) / taur) ) );
%                     
%                     recurrent_I = ( syn(j).conn_strength / sqrt(keOutDegree) )...
%                         * sum(presyn_I());
%                     
%                     %simulation in single neuron
%                     syn(j).postsyn_neuron.simulation(recurrent_I, time_now);
%                     
%                 case 'inh'
%                     spike_time = find(obj.neuron_in_layer(i).spike_train); %spike train of pre synpatic neuron
%                     
%                     presyn_I = @() (1 / (syn(j).taud - syn(j).taur)...
%                         * ( exp((time_now - spike_time) / taud) - ...
%                         exp((time_now - spike_time) / taur) ) );
%                     
%                     recurrent_I = ( syn(j).conn_strength / sqrt(kiOutDegree) )...
%                         * sum(presyn_I());
%                     
%                     %simulation in single neuron
%                     syn(j).postsyn_neuron.simulation(-recurrent_I, time_now);
%             end
%         end
    end
end












