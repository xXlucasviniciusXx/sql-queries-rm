DECLARE @ANO INT = :ANO -- Substitua pelo input do usuário

SELECT 
    PSECAO.DESCRICAO AS SETOR,
    @ANO AS ano,
    COUNT(DISTINCT CASE WHEN YEAR(PFUNC.DATAADMISSAO) = @ANO THEN PFUNC.CHAPA END) AS TOTAL_ADMISSOES,
    COUNT(DISTINCT CASE WHEN YEAR(PFUNC.DATADEMISSAO) = @ANO THEN PFUNC.CHAPA END) AS TOTAL_DESLIGAMENTOS,
    COUNT(DISTINCT CASE WHEN YEAR(PFUNC.DATAADMISSAO) = @ANO THEN PFUNC.CHAPA END) - 
    COUNT(DISTINCT CASE WHEN YEAR(PFUNC.DATADEMISSAO) = @ANO THEN PFUNC.CHAPA END) AS SALDO_LIQUIDO
FROM PFUNC (NOLOCK)
JOIN PSECAO (NOLOCK) 
    ON PSECAO.CODCOLIGADA = PFUNC.CODCOLIGADA 
    AND PSECAO.CODIGO = PFUNC.CODSECAO 
WHERE PFUNC.CODCOLIGADA = 1  
    AND (YEAR(PFUNC.DATAADMISSAO) = @ANO OR YEAR(PFUNC.DATADEMISSAO) = @ANO)
GROUP BY 
    PSECAO.DESCRICAO
ORDER BY 
    SALDO_LIQUIDO DESC;
