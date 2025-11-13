function plotEpisodeTaxi(Q, episodio, initStates, episodesData)
    maxSteps = size(episodesData(episodio).actions, 1); % numero passi per episodio

    fprintf("Episodio %d - Stato iniziale: Taxi=%d, Passeggero=%d, Destinazione=%d\n", ...
        episodio, initStates(episodio,1), initStates(episodio,2), initStates(episodio,3));

    for step = 1:maxSteps
        stateVec = episodesData(episodio).states(step, :);
        action = episodesData(episodio).actions(step);
        reward = episodesData(episodio).rewards(step);

        fprintf("Step %3d | Azione: %-8s | Reward: %+3d | Stato Taxi=%d, Passeggero=%d, Dest=%d\n", ...
            step, actionName(action), reward, stateVec(1), stateVec(2), stateVec(3));

        plotTaxi(stateVec, sprintf("Episodio %d - Step %d | Azione: %s", episodio, step, actionName(action)));
        pause(0.4);
    end
    fprintf("Episodio terminato in %d passi\n", maxSteps);
end
