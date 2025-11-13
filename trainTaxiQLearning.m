function [Q, initStates, episodesData] = trainTaxiQLearning(numEpisodes)
    if nargin < 1
        numEpisodes = 1000;  % default
    end

    numStates = 25 * 5 * 4; % posizione del taxi (25 posizioni in una griglia 5x5),dalla posizione del passeggero (5 possibili, 4 posizioni più “a bordo”) e dalla destinazione (4 possibili). Quindi, 25 * 5 * 4 = 500 stati
    numActions = 6; % su, giù, sinistra, destra, prendi, lascia         

    alpha = 0.1; % velocità di apprendimento     
    gamma = 0.9; % fattore di sconto     
    epsilon = 0.1; % probabilità di esplorazione casuale (epsilon geedy)    

    Q = zeros(numStates, numActions); % Q(s,a)
    maxSteps = 50;    

    initStates = zeros(numEpisodes, 3); % [taxiPos, passPos, destPos]  
    episodesData = struct('states', cell(numEpisodes,1), 'actions', cell(numEpisodes,1), 'rewards', cell(numEpisodes,1));

    for ep = 1:numEpisodes
        rng('shuffle'); % per variare ogni esecuzione
        %rng("default"); % per non variare ad ogni esecuzione

        stateVec = resetEnv();
        initStates(ep, :) = stateVec; % salva lo stato iniziale dell’episodio corrente
        state = stateToIndex(stateVec(1), stateVec(2), stateVec(3));
        done = false;

        statesSeq = zeros(maxSteps, 3);
        actionsSeq = zeros(maxSteps, 1);
        rewardsSeq = zeros(maxSteps, 1);

        for step = 1:maxSteps

            % Politica epsilon-greedy:
            % Se rand < epsilon, azione casuale (exploration)
            % Altrimenti, azione con valore Q max (exploitation)

            if rand < epsilon
                action = randi(numActions);
            else
                [~, action] = max(Q(state, :)); % Si ignora il valore massimo. Si prende l’indice della posizione del massimo → corrisponde all'azione migliore
            end

            [nextStateVec, reward, done] = stepEnv(stateVec, action);
            nextState = stateToIndex(nextStateVec(1), nextStateVec(2), nextStateVec(3));

            Q(state, action) = Q(state, action) + alpha * (reward + gamma * max(Q(nextState, :)) - Q(state, action));

            % Salva dati passo
            statesSeq(step, :) = stateVec;
            actionsSeq(step) = action;
            rewardsSeq(step) = reward;

            stateVec = nextStateVec;
            state = nextState;

            if done
                break;
            end
        end

        % Troncamento delle sequenze a lunghezza effettiva
        episodesData(ep).states = statesSeq(1:step, :);
        episodesData(ep).actions = actionsSeq(1:step);
        episodesData(ep).rewards = rewardsSeq(1:step);

        fprintf("Episodio %d terminato a passo %d (done=%d)\n", ep, step, done);
    end
end
