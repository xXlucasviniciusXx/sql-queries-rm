SELECT 
    PFUNC.CODCOLIGADA AS COLIGADA,
    PFUNC.CHAPA,
    PFUNC.CODSITUACAO AS STATUS,
    PFUNC.NOME AS NOME_FUNCIONARIO,
    PFUNCAO.NOME AS FUNCAO,
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO,
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103) AS DTADMISSAO,
    CONVERT(VARCHAR, PFUNC.DATADEMISSAO , 103) AS DTDEMISSAO,
    COUNT(1) AS quantidade
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
    PFUNC.CODSITUACAO <> 'D'
    AND PFUNC.CODCOLIGADA = :CODCOLIGADA
    AND YEAR(PFUNC.DATAADMISSAO) = :ANO
GROUP BY  
    PFUNC.CODCOLIGADA,
    PFUNC.CHAPA,
    PFUNC.CODSITUACAO,
    PFUNC.NOME,
    PFUNCAO.NOME,
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO,
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103),
    CONVERT(VARCHAR, PFUNC.DATADEMISSAO , 103)
ORDER BY
    PFUNC.CHAPA;
