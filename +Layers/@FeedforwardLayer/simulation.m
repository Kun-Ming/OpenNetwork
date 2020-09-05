function simulation(obj)   
    % recurit all neuron in 1 ms resolution
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
        
        post_syn_cell = obj.syn_in_layer(i);
        
    end
end