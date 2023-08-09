function [outputArg1] = obterNomeArquivos(caminho,remover)
    arquivos = dir(caminho);
    nomeArquivos = {arquivos.name};
    nomeArquivos = nomeArquivos(~ismember(nomeArquivos,remover));
    
    outputArg1 = nomeArquivos;
end