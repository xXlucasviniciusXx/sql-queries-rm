SELECT DISTINCT
    PFUNC.CODCOLIGADA AS COLIGADA,
    PFUNC.CHAPA,
    PFUNC.CODSITUACAO AS STATUS,
    PFUNC.NOME AS NOME_FUNCIONARIO,
    PFUNCAO.NOME AS FUNCAO,
    PFUNC.CODSECAO,
    PSECAO.DESCRICAO,
    CONVERT(VARCHAR, PFUNC.DATAADMISSAO, 103) AS DTADMISSAO,
    PFDEPEND.NOME AS DEPENDENTE,
    PFDEPEND.CPF,
    PFDEPEND.SEXO,
    CONVERT(VARCHAR, PFDEPEND.DTNASCIMENTO, 103) AS DTNASCIMENTO,
    DATEDIFF(year, PFDEPEND.DTNASCIMENTO, GETDATE()) AS IDADE,
    CASE PFDEPEND.GRAUPARENTESCO
        WHEN '1' THEN 'FILHO(A) VÁLIDO'
        WHEN '3' THEN 'FILHO(A) INVÁLIDO'
        WHEN '5' THEN 'CÔNJUGE'
        WHEN '6' THEN 'PAI'
        WHEN '7' THEN 'MÃE'
        WHEN '8' THEN 'SOGRO(A)'
        WHEN '9' THEN 'OUTROS'
        WHEN 'A' THEN 'AVÔ(Á)'
        WHEN 'C' THEN 'COMPANHEIRO(A)'
        WHEN 'D' THEN 'ENTEADO(A)'
        WHEN 'E' THEN 'EXCLUÍDO'
        WHEN 'G' THEN 'EX-CÔNJUGE'
        WHEN 'I' THEN 'IRMÃO VÁLIDO'
        WHEN 'N' THEN 'IRMÃO INVÁLIDO'
        WHEN 'P' THEN 'EX-COMPANHEIRO(A)'
        WHEN 'S' THEN 'EX-SOGRO(A)'
        WHEN 'T' THEN 'NETO(A)'
        WHEN 'X' THEN 'EX-ENTEADO(A)'
    END AS GRAUPARENTESCO,
    CASE PFDEPEND.INCIRRF
        WHEN '1' THEN 'SIM'
        ELSE 'NÃO'
    END AS INCID_IRRF
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
LEFT JOIN 
    PFDEPEND (NOLOCK) ON PFDEPEND.CHAPA = PFUNC.CHAPA
WHERE
    PFUNC.CODSITUACAO <> 'D'
    AND PFUNC.CODCOLIGADA = :CODCOLIGADA
    AND (
        DATEDIFF(year, PFDEPEND.DTNASCIMENTO, GETDATE()) < 13 
        OR (
            DATEDIFF(year, PFDEPEND.DTNASCIMENTO, GETDATE()) = 13 
            AND MONTH(PFDEPEND.DTNASCIMENTO) <> MONTH(GETDATE())
        )
        )
ORDER BY
    PFUNC.CHAPA;
