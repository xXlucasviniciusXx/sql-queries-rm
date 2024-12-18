SELECT
    PFUNC.CODCOLIGADA,
    PFUNC.CHAPA,
    PFUNC.NOME,
    PSECAO.DESCRICAO,
    PFUNC.SALARIO AS SALARIO_ATUAL,
    PFUNC.CODBANCOPAGTO AS [Banco de Pagamento],
    PFUNC.CONTAPAGAMENTO AS [Conta para Pagamento],
    PFUNC.CODAGENCIAPAGTO AS [Numero da Agencia],    
    PFUNCAO.NOME AS FUNCAO,    
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO AS SECAO,
    PCODSITUACAO.CODCLIENTE,
    PCODSITUACAO.DESCRICAO,    
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103) AS DTADMISSAO
FROM 
    PPESSOA (NOLOCK)
JOIN 
    PFUNC (NOLOCK) ON PPESSOA.CODIGO = PFUNC.CODPESSOA  
JOIN 
    PFUNCAO (NOLOCK) ON PFUNC.CODCOLIGADA = PFUNCAO.CODCOLIGADA AND PFUNC.CODFUNCAO = PFUNCAO.CODIGO
JOIN 
    PSECAO (NOLOCK) ON PFUNC.CODSECAO = PSECAO.CODIGO
JOIN 
    PCODSITUACAO (NOLOCK) ON PFUNC.CODSITUACAO = PCODSITUACAO.CODCLIENTE 
WHERE 
    PFUNC.CODSITUACAO NOT IN ('D', 'I')
    AND PFUNCAO.NOME  <> 'AUTONOMO'
ORDER BY
    PFUNC.NOME,
    PFUNC.CHAPA;