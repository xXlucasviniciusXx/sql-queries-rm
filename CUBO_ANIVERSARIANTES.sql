SELECT
    PFUNC.CHAPA,
    PFUNC.NOME,
    PFUNC.CODSECAO,
    PFUNC.CODSITUACAO,
    PSECAO.DESCRICAO,
    CONVERT(VARCHAR, PPESSOA.DTNASCIMENTO, 103) AS DTNASCIMENTO,
    DAY(PPESSOA.DTNASCIMENTO) AS DIA_NASCIMENTO, 
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103) AS DTADMISSAO,
    PFUNC.CODCOLIGADA
FROM 
    PPESSOA (NOLOCK) 
JOIN 
    PFUNC (NOLOCK) ON PPESSOA.CODIGO = PFUNC.CODPESSOA 
JOIN 
    PSECAO (NOLOCK) ON PFUNC.CODSECAO = PSECAO.CODIGO
WHERE 
    MONTH(PPESSOA.DTNASCIMENTO) = :MESDOANIVERSARIO
    AND PFUNC.CODSITUACAO = IN ('A','F')
    ORDER BY PFUNC.CHAPA;
   
