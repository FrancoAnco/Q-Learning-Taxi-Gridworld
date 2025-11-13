function name = actionName(a)
    switch a
        case 1, name = 'Su';
        case 2, name = 'Giu';
        case 3, name = 'Sinistra';
        case 4, name = 'Destra';
        case 5, name = 'Prendi';
        case 6, name = 'Lascia';
        otherwise, name = 'Sconosciuta';
    end
end
