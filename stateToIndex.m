function idx = stateToIndex(taxiPos, passPos, destPos)
    % taxiPos in [1..25], passPos in [1..5], destPos in [1..4]
    % (taxiPos -1)*(tutte le combinazioni tra passPos e destPos -> 5*4)
    % + (passPos - 1)*(tutte le combinazioni di destinazione per ogni passeggero -> 4)
    idx = (taxiPos - 1)*20 + (passPos - 1)*4 + destPos;
end
