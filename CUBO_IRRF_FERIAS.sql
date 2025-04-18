SELECT
    PFUNC.CHAPA,
    PFUNC.NOME,
    CONVERT(VARCHAR, PFUFERIASPER.DATAINICIO, 103) AS INICIO_FERIAS,
    CONVERT(VARCHAR, PFUFERIASPER.DATAFIM, 103) AS FIM_FERIAS,
    PFUNC.SALARIO,
    CAST((PFUNC.SALARIO + (PFUNC.SALARIO / 3)) AS DECIMAL(10,2)) AS VALOR_FERIAS,
    CASE
        WHEN (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) <= 2112.00 THEN 0        
        WHEN (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) > 2112.00 AND (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) <= 2826.65 THEN 
            CAST((((PFUNC.SALARIO + (PFUNC.SALARIO / 3)) * 0.075) - 158.40) AS DECIMAL(10,2))        
        WHEN (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) > 2826.65 AND (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) <= 3751.05 THEN 
            CAST((((PFUNC.SALARIO + (PFUNC.SALARIO / 3)) * 0.15) - 370.40) AS DECIMAL(10,2))
        WHEN (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) > 3751.05 AND (PFUNC.SALARIO + (PFUNC.SALARIO / 3)) <= 4664.68 THEN 
            CAST((((PFUNC.SALARIO + (PFUNC.SALARIO / 3)) * 0.225) - 651.73) AS DECIMAL(10,2))  
        ELSE 
            CAST((((PFUNC.SALARIO + (PFUNC.SALARIO / 3)) * 0.275) - 884.96) AS DECIMAL(10,2))
    END AS IRRF_SOBRE_FERIAS
FROM 
    PFUNC (NOLOCK)
JOIN 
    PFUFERIASPER (NOLOCK) ON PFUNC.CHAPA = PFUFERIASPER.CHAPA 
WHERE 
    PFUNC.CODSITUACAO <> 'D'
    AND PFUNC.CODCOLIGADA = :CODCOLIGADA
    AND YEAR(PFUFERIASPER.DATAINICIO) = :ANO    
ORDER BY 
    PFUNC.CHAPA;
