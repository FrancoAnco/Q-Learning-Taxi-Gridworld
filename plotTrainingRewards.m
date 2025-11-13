function plotTrainingRewards(episodesData)
    numEpisodes = length(episodesData);
    totalRewards = zeros(numEpisodes,1);

    for ep = 1:numEpisodes
        totalRewards(ep) = sum(episodesData(ep).rewards);
    end

    cumulativeMeanRewards = cumsum(totalRewards) ./ (1:numEpisodes)';

    figure;
    plot(1:numEpisodes, totalRewards, '-b', 'LineWidth', 1.5);
    hold on;
    plot(1:numEpisodes, cumulativeMeanRewards, '-r', 'LineWidth', 2);
    xlabel('Episodio');
    ylabel('Reward');
    legend('Reward Totale Episodio', 'Reward Media Cumulativa');
    title('Andamento ricompense durante l''allenamento');
    grid on;
    hold off;
end
