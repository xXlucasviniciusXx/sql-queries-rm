SELECT DISTINCT
    PFUNC.CODCOLIGADA AS COLIGADA,
    PFUNC.CHAPA,
    PFUNC.CODSITUACAO AS STATUS,
    PFUNC.NOME AS NOME_FUNCIONARIO,
    PFUNCAO.NOME AS FUNCAO,
    PFUNC.CODSECAO,
    PPESSOA.SEXO,
    PSECAO.DESCRICAO,
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103) AS DTADMISSAO,
    CONVERT(VARCHAR, PPESSOA.DTNASCIMENTO, 103) AS DTNASCIMENTO,
    DATEDIFF(year, PPESSOA.DTNASCIMENTO, GETDATE()) AS IDADE
    
FROM 
    PPESSOA (NOLOCK) 
JOIN 
    PFUNC (NOLOCK) ON PPESSOA.CODIGO = PFUNC.CODPESSOA  
JOIN 
    PFUNCAO (NOLOCK) ON PFUNC.CODCOLIGADA = PFUNCAO.CODCOLIGADA AND PFUNC.CODFUNCAO = PFUNCAO.CODIGO
JOIN 
    PSECAO (NOLOCK) ON PFUNC.CODSECAO = PSECAO.CODIGO
JOIN 
    GCOLIGADA (NOLOCK) ON GCOLIGADA.CODCOLIGADA = PFUNC.CODCOLIGADA AND GCOLIGADA.CODCOLIGADA = PFUNCAO.CODCOLIGADA

WHERE
    PFUNC.CODSITUACAO = 'A'
    AND PFUNC.CODCOLIGADA = :COLIGADA
    AND PPESSOA.SEXO ='M'
    AND DATEDIFF(year, PPESSOA.DTNASCIMENTO, GETDATE()) >= 40 
    AND PFUNCAO.NOME <> 'AUTONOMO'
    AND PSECAO.DESCRICAO NOT LIKE 'VENDAS%'
        
ORDER BY
   IDADE;
