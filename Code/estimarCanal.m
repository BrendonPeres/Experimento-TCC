function hHat = estimarCanal(dadoReal,dadoEsperado,piloto,F,tamanhoCanal)
% Estiamtiva das diferentes portadoras, retorna-se uma matriz com as
% diferentes estimativas obtidas para cada tipo de portadora

    [metodos,~,~] = unique(piloto.metodo);    
    col = 1;

    for metodo = metodos
        graus = unique(piloto.grau(piloto.metodo == metodo));
        for grau = graus
            % seleção das pilotos do mesmo método e de mesmo grau 
            pilotosSelecionadas = (piloto.metodo == metodo & piloto.grau == grau);
            quantidadePiloto = sum(pilotosSelecionadas);

            % unique: como são pilotos idênticas, terão mesma energia
            % comparado às portadoras não pilotos
            fator = unique(piloto.razaoPilotoDado(pilotosSelecionadas));
    
            g = (fator * quantidadePiloto)^-1 ...
                * ctranspose( ...
                    sqrt(fator) ...
                    * diag(dadoEsperado(pilotosSelecionadas)) ...
                    * ctranspose(F(1:tamanhoCanal,piloto.localizacao(pilotosSelecionadas))));
            
            hHat(:,col) = (g * dadoReal(pilotosSelecionadas));
            col = col + 1;
        end
    end
end