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
layer1 = Layers.FeedforwardLayer([40,40], 1200, 400, .2, 20, 3, 2);
layer2 = Layers.FeedforwardLayer([40,40], 1200, 400, .2, 20, 3, 2);
layer1_2 = Layers.connectionLayer(800, 600, 500, layer1.total_neurons, 1);

layer1.generate_synapse(syn_param);
layer2.generate_synapse(syn_param);
layer1_2.generate_synapse(layer1, layer2, ff_param);

layer1.neuron_in_layer(4  ).spike_train = [0 1 1 1 0 1 1 0 1 1 0 0 1 0 1 1 1 1 0 0];
layer1.neuron_in_layer(100).spike_train = [0 1 1 1 1 0 1 0 1 1 0 0 1 0 1 0 1 0 1 0];
layer1.neuron_in_layer(429).spike_train = [0 0 0 1 1 1 1 0 1 0 0 0 1 0 1 0 1 1 0 0];
layer1.neuron_in_layer(876).spike_train = [1 1 0 0 1 0 1 0 1 1 0 1 1 0 1 1 1 0 1 0];


for time = 1 : .1 : 20
    layer1.simulation(time);
    layer1_2.simulation(time);
    layer2.simulation(time);
end














