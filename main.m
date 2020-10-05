import Layers.*
import allNeurons.*
import Synapse.*
%%
%     syn_param
%             ├──exc
%             |    ├──fast: taud, taur, conn_strength
%             |    |                                ├──exc2exc  
%             |    |                                └──exc2inh
%             |    |
%             |    └──slow: taud, taur, conn_strength
%             |                                     ├──exc2exc  
%             |                                     └──exc2inh
%             |
%             ├──inh
%                  ├──fast: taud, taur, conn_strength(minus)
%                  |                                      ├──inh2exc  
%                  |                                      └──inh2inh
%                  └──slow: taud, taur, conn_strength(minus)
%                                                         ├──inh2exc  
%                                                         └──inh2inh

syn_param.exc.fast.taud = 100;
syn_param.exc.fast.taur = 2;
syn_param.exc.fast.conn_strength.exc2exc = 80;
syn_param.exc.fast.conn_strength.exc2inh = -240;

syn_param.exc.slow.taud = 5;
syn_param.exc.slow.taur = 1;
syn_param.exc.slow.conn_strength.exc2exc = 80;
syn_param.exc.slow.conn_strength.exc2inh = -240;

syn_param.inh.fast.taud = 100;
syn_param.inh.fast.taur = 2;
syn_param.inh.fast.conn_strength.inh2exc = 40;
syn_param.inh.fast.conn_strength.inh2inh = -300;

syn_param.inh.slow.taud = 8;
syn_param.inh.slow.taur = 2;
syn_param.inh.slow.conn_strength.inh2exc = 40;
syn_param.inh.slow.conn_strength.inh2inh = -300;

ff_param.slow.taud = 5;
ff_param.slow.taur = 1;
ff_param.slow.conn_strength.exc = 0.6261;
ff_param.slow.conn_strength.inh = 0.4772;
%%
total_time = 100; % resulotion: .1ms, totally 200 time bin
layer_size = [200,200];
% FeedforwardLayer(N_neurons_in_dim, N_exc_neuron, N_inh_neuron, syn_type, simulationTime, ke, ki)
fprintf('generating layer1...');
layer1 = Layers.FeedforwardLayer(layer_size, 30000, 10000, .2, total_time, 18, 32);
fprintf('\n\ngenerating layer2...');
layer2 = Layers.FeedforwardLayer(layer_size, 30000, 10000, .2, total_time, 18, 32);
% connectionLayer(exc_out, inh_out, Nx, syn_type)
fprintf('\n\ngenerating layer1_2...\n\n');
layer1_2 = Layers.connectionLayer(45, 15, 2500, 1);

layer1.generate_synapse(syn_param);
layer2.generate_synapse(syn_param);
layer1_2.generate_synapse(layer1, layer2, ff_param);

spike_X = arrayfun(@(x) binornd(x+1, .8), [layer1.neuron_in_layer(:).spike_train]);
spike_X = mat2cell(spike_X, total_time, ones(1, prod(layer_size)));
[layer1.neuron_in_layer(:).spike_train] = spike_X{:};

for time = 1 : 1 : total_time 
    fprintf('simulating: %3d / %4d\n', time, total_time);
    layer1.simulation(time);
    layer1_2.simulation(time, layer1, layer2);
    layer2.simulation(time);
end














