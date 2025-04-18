SELECT distinct
PFUNC.CODCOLIGADA as COLIGADA,
PFUNC.CHAPA,
PFUNC.CODSITUACAO STATUS,
PFUNC.NOME NOME_FUNCIONARIO,
PFUNCAO.NOME FUNCAO,
PFUNC.CODSECAO,
PSECAO.DESCRICAO,
CONVERT (VARCHAR,  pfunc.dataadmissao, 103) AS DTADMISSAO,
PFDEPEND.NOME DEPENDENTE,
PFDEPEND.CPF,
PFDEPEND.SEXO,
CONVERT (VARCHAR,  PFDEPEND.DTNASCIMENTO, 103) AS DTNASCIMENTO,
DATEDIFF(hour, PFDEPEND.DTNASCIMENTO, getdate()) / 8766 IDADE,


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
WHEN 'G' THEN 'EX-CONJUGE' 
WHEN 'I' THEN 'IMRÃO VÁLIDO' 
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

/*
CASE PFDEPEND.INCIRRF WHEN 1 THEN 'SIM' ELSE 'NAO' END AS IRRF,
CASE PFDEPEND.INCINSS WHEN 1 THEN 'SIM' ELSE 'NAO' END AS INSS,
CASE PFDEPEND.INCASSISTMEDICA WHEN 1 THEN 'SIM' ELSE 'NAO' END AS ASSIST_MEDICA,
CASE PFDEPEND.INCPENSAO WHEN 1 THEN 'SIM' ELSE 'NAO' END AS PENSAO,
CASE PFDEPEND.INCSALFAM WHEN 1 THEN 'SIM' ELSE 'NAO' END AS SALARIO_FAMILIA */


FROM PPESSOA (NOLOCK) 
JOIN PFUNC (NOLOCK) ON PPESSOA.CODIGO = PFUNC.CODPESSOA  --AND PFUNC.CODSITUACAO NOT IN ('D','U') 
JOIN PFUNCAO (NOLOCK) ON PFUNC.CODCOLIGADA = PFUNCAO.CODCOLIGADA AND PFUNC.CODFUNCAO = PFUNCAO.CODIGO
JOIN PSECAO (NOLOCK) ON PFUNC.CODSECAO = PSECAO.CODIGO
JOIN GCOLIGADA (NOLOCK) ON GCOLIGADA.CODCOLIGADA = PFUNC.CODCOLIGADA AND GCOLIGADA.CODCOLIGADA = PFUNCAO.CODCOLIGADA
LEFT JOIN PFDEPEND (NOLOCK) ON PFDEPEND.CHAPA = PFUNC.CHAPA /* AND PFDEPEND.GRAUPARENTESCO in ('1','5','c') */
  
WHERE
	PFUNC.CODSITUACAO <> 'D'
	AND PFUNC.CODCOLIGADA =  :CODCOLIGADA
	--AND PFUNC.CODSECAO BETWEEN :INICAL AND :SECAFINAL
	
		
	
ORDER BY
PFUNC.CHAPA


