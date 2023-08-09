function hHat = estimarCanal(dadoReal,dadoEsperado,configSubportadoraPiloto,F,tamanhoCanal)
% Estiamtiva das diferentes portadoras, retorna-se uma matriz com as
% diferentes estimativas obtidas para cada tipo de portadora

    [metodos,~,~] = unique(configSubportadoraPiloto.metodo_v);    
    col = 1;

    for metodo = metodos
        graus = unique(configSubportadoraPiloto.grau_v(configSubportadoraPiloto.metodo_v == metodo));
        for grau = graus
            % seleção das configSubportadoraPilotos do mesmo método e de mesmo grau 
            configSubportadoraPilotosSelecionadas = (configSubportadoraPiloto.metodo_v == metodo & configSubportadoraPiloto.grau_v == grau);
            quantidadePiloto = sum(configSubportadoraPilotosSelecionadas);

            % unique: como são configSubportadoraPilotos idênticas, terão mesma energia
            % comparado às portadoras não configSubportadoraPilotos
            fator = unique(configSubportadoraPiloto.razaoPilotoDado_v(configSubportadoraPilotosSelecionadas));
    
            g = (fator * quantidadePiloto)^-1 ...
                * ctranspose(sqrt(fator) ...
                    * diag(dadoEsperado(configSubportadoraPilotosSelecionadas)) ...
                    * ctranspose(F(1:tamanhoCanal,configSubportadoraPiloto.localizacao_v(configSubportadoraPilotosSelecionadas))));
            
            hHat(:,col) = (g * dadoReal(configSubportadoraPilotosSelecionadas));
            col = col + 1;
        end
    end
end