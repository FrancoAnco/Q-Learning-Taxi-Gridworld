function [nextStateVec, reward, done] = stepEnv(stateVec, action)

    taxiPos = stateVec(1);
    passPos = stateVec(2);
    destPos = stateVec(3);

    [taxiRow, taxiCol] = ind2sub([5 5], taxiPos);

    reward = -1;  % penalità standard per ogni step
    done = false;

    % Muri tra celle adiacenti
    walls = [
        3 2 3 3;  % muro tra (3,2) e (3,3)
        4 4 5 4;  % muro tra (4,4) e (5,4)
        1 3 2 3;  % muro tra (1,3) e (2,3)
    ];

    % Azioni di movimento
    switch action
        case 1  % Su
            tgtRow = taxiRow - 1;
            tgtCol = taxiCol;
        case 2  % Giù
            tgtRow = taxiRow + 1;
            tgtCol = taxiCol;
        case 3  % Sinistra
            tgtRow = taxiRow;
            tgtCol = taxiCol - 1;
        case 4  % Destra
            tgtRow = taxiRow;
            tgtCol = taxiCol + 1;
        case 5  % Prendi
            if passPos ~= 5 && taxiPos == fixedPosToIndex(passPos)
                passPos = 5;  % posizione passeggero = 5, allora passeggero in taxi
                reward = 20;
            else
                reward = -10;
            end
        case 6  % Lascia
            if passPos == 5 && taxiPos == fixedPosToIndex(destPos)
                passPos = destPos;  % passeggero sceso
                reward = 40;
                done = true;
            else
                reward = -10;
            end
    end

    % Se l'azione è un movimento (1–4), applica il controllo
    if action >= 1 && action <= 4
        if tgtRow < 1 || tgtRow > 5 || tgtCol < 1 || tgtCol > 5 || ...
           wallBetween(taxiRow, taxiCol, tgtRow, tgtCol, walls)
            % Movimento non valido: fuori tabella o muro
            reward = -30;
        else
            % Movimento valido
            taxiRow = tgtRow;
            taxiCol = tgtCol;
        end
    end

    taxiPos = sub2ind([5 5], taxiRow, taxiCol);
    nextStateVec = [taxiPos, passPos, destPos];
end

% Funzione ausiliaria per il controllo dei muri
function isBlocked = wallBetween(r1, c1, r2, c2, walls)
    isBlocked = any( ...
        ismember(walls, [r1 c1 r2 c2], 'rows') | ...
        ismember(walls, [r2 c2 r1 c1], 'rows') |...
        ismember(walls, [r1 c1 r2 c2], 'rows') ...
    );
end

% Funzione per convertire posizione fissa in indice
function idx = fixedPosToIndex(pos)
    fixedPositions = [1 1; 1 5; 5 1; 5 4]; % matrice 4×2
    row = fixedPositions(pos, 1);
    col = fixedPositions(pos, 2);
    idx = sub2ind([5 5], row, col);
end
