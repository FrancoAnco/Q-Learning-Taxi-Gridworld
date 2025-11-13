function stateVec = resetEnv()

    taxiPos = randi(25); % Posizione taxi su tutta la griglia

    % Passeggero in posizioni da 1 a 4
    passPos = randi(4);

    % Destinazione in posizioni da 1 a 4
    destPos = randi(4);

    % Verifica destinazione diversa da posizione passeggero
    while destPos == passPos
        destPos = randi(4);
    end

    stateVec = [taxiPos, passPos, destPos];
end
