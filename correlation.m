
s1 = zeros(2, layer1.total_neurons*time);
s2 = zeros(2, layer2.total_neurons*time);

for i = 1 : layer1.total_neurons
    for j = 1 : time
        if layer1.neuron_in_layer(i).spike_train(j) == 1
            s1(1, i*time + j) = j;
            s1(2, i*time + j) = i;
        end
    end
end

for i = 1 : layer2.total_neurons
    for j = 1 : time
        if layer2.neuron_in_layer(i).spike_train(j) == 1
            s2(1, i*time + j) = j;
            s2(2, i*time + j) = i;
        end
    end
end

[~, s1_ind, ~] = find(s1);
s1 = s1(:, s1_ind);
[~, s2_ind, ~] = find(s2);
s2 = s2(:, s2_ind);

[C_d,COV_d,Cbar,COVbar,daxis,rate1,rate2,var1,var2] = corr_d(s1,s2,layer1_2.Nx, ...
                                                            layer2.total_neurons, '2D', [10, 10]);
                                                        
fprintf('\naverage Cee=%.4f, Cex=%.4f,Cxx=%.4f\n\n', Cbar(1,1),Cbar(1,2),Cbar(1,3))
    FanoFactor=mean(var2./rate2)/5                                    