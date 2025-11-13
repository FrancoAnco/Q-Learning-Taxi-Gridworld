
% Esesue il training
[Q, initStates, episodesData] = trainTaxiQLearning(1000);

% Visualizza l'episodio 1000
plotEpisodeTaxi(Q, 1000, initStates, episodesData);

% Curva di apprendimento
plotTrainingRewards(episodesData);