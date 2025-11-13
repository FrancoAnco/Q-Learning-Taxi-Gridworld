function plotTaxi(state, stepInfo)
    if nargin < 2
        stepInfo = 'Ambiente Taxi';
    end

    posTaxi = state(1);
    posPass = state(2);
    posDest = state(3);

    [rowTaxi, colTaxi] = ind2sub([5,5], posTaxi);
    fixedPositions = [1 1; 1 5; 5 1; 5 4];

    if posPass == 5
        passRow = NaN;
        passCol = NaN;
    else
        passRow = fixedPositions(posPass, 1);
        passCol = fixedPositions(posPass, 2);
    end

    destRow = fixedPositions(posDest, 1);
    destCol = fixedPositions(posDest, 2);

    clf;

    % Subplot: griglia e elementi
    hold on;
    axis([0.5 5.5 0.5 5.5]);
    set(gca, 'YDir', 'reverse'); % Imposta l’origine in alto a sinistra
    axis square;
    xticks(1:5);
    yticks(1:5);
    grid on;

    % Muri
    walls = [
        3 2 3 3;
        4 4 5 4;
        1 3 2 3;
    ];
    for i = 1:size(walls, 1)
        r1 = walls(i, 1); c1 = walls(i, 2);
        r2 = walls(i, 3); c2 = walls(i, 4);
        plot([c1 c2], [r1 r2], 'k-', 'LineWidth', 4);
    end

    % Taxi, passeggero, destinazione
    h = [];
    labels = {};

    h(end+1) = plot(colTaxi, rowTaxi, 'bo', 'MarkerSize', 20, 'LineWidth', 3);
    labels{end+1} = 'Taxi';

    if ~isnan(passRow)
        h(end+1) = plot(passCol, passRow, 'g^', 'MarkerSize', 15, 'LineWidth', 2);
        labels{end+1} = 'Passeggero';
    end

    h(end+1) = plot(destCol, destRow, 'rs', 'MarkerSize', 15, 'LineWidth', 2);
    labels{end+1} = 'Destinazione';

    legend(h, labels, 'Location', 'northeastoutside');
    title(stepInfo, 'FontSize', 12, 'FontWeight', 'bold');
    hold off;

    drawnow;
end
