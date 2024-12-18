SELECT DISTINCT
    pfunc.codcoligada AS COLIGADA,
    PFUNC.chapa AS CHAPA,
    pfunc.NOME AS NOME,
    PFUNC.codfuncao AS FUNÇÃO,
    pfuncao.nome AS DESC_FUNÇÃO,
    pfunc.SALARIO AS SALARIO,
    pfunc.codsecao AS SEÇÃO,
    psecao.descricao AS DESC_SEÇÃO,
    PEVENTO.CODRUBRICA AS CODRUBRICA,
    PEVENTO.CODIGO  AS CODEVENTO,
    PEVENTO.DESCRICAO AS DESCRICAO,
    PFCODFIX.VALOR AS VALOR, 
    CONVERT(VARCHAR(12), PFUNC.DATAADMISSAO, 103) AS DT_ADMISSAO,
    CONVERT(VARCHAR(12), PFUNC.DATADEMISSAO, 103) AS DT_DEMISSAO,
    ppessoa.CIDADE AS CIDADE,
    ppessoa.ESTADO AS ESTADO,
    ppessoa.BAIRRO AS BAIRRO,
    ppessoa.RUA AS RUA,
    CASE pfunc.codsituacao
        WHEN 'D' THEN 'DEMITIDO'
        WHEN 'A' THEN 'ATIVO'
        WHEN 'F' THEN 'FERIAS'
        WHEN 'P' THEN 'AF. PREVIDENCIA'
        WHEN 'W' THEN 'LICEN MATERN 180d'
        WHEN 'C' THEN 'CONTRATO SUSPENSO'
        WHEN 'E' THEN 'LICEN MATERNIDADE'
        WHEN 'I' THEN 'APOSENTADO INVALIDEZ'
        WHEN 'M' THEN 'SERVIÇO MILITAR'
        WHEN 'R' THEN 'LICEN REMUNERADA'
        WHEN 'T' THEN 'AFASTADO AC. TRABALHO'
        WHEN 'V' THEN 'AVISO PREVIO'
        WHEN 'O' THEN 'DOENÇA OCUPACIONAL'
        ELSE 'OUTRO_CONSULTAR_CADASTRO'
    END AS SITUACAO
FROM pfunc (NOLOCK)
JOIN pfuncao (NOLOCK) ON pfuncao.CODIGO = pfunc.CODFUNCAO
    AND pfuncao.codcoligada = pfunc.codcoligada -- Nome da funcao
JOIN psecao (NOLOCK) ON PFUNC.CODSECAO = psecao.codigo
    AND psecao.codcoligada = pfunc.codcoligada -- Nome da seção
JOIN PPESSOA (NOLOCK) ON PFUNC.CODPESSOA  = ppessoa.CODIGO
JOIN 
    PFCODFIX (NOLOCK) ON PFUNC.CHAPA = PFCODFIX.CHAPA 
JOIN 
     PEVENTO (NOLOCK) ON  PEVENTO.CODIGO  = PFCODFIX.CODEVENTO    
WHERE 
    pfunc.codcoligada = 1
    --AND pfunc.CODFUNCAO = '120'
    AND pfuncao.nome LIKE 'PROM%'
    AND PEVENTO.CODIGO = 0247
    AND pfunc.codsituacao <>  'D'
ORDER BY PFUNC.codfuncao, pfunc.chapa;
