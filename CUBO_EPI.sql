select distinct
       pfunc.codcoligada as COLIGADA,
	   PFUNC.chapa as CHAPA,
	   pfunc.NOME as Nome,
	   PFUNC.codfuncao as FUNÇÃO,
	   pfuncao.nome as DESC_FUNÇÃO,
       pfunc.codsecao as SEÇÃO,
	   psecao.descricao as desc_secao,
	   Convert(VARCHAR(12),( PFUNC.DATAADMISSAO),103) as DT_ADMISSAO,
	   Convert(VARCHAR(12),( PFUNC.DATADEMISSAO),103) as DT_DEMISSAO,
	   vemprestimoepi.codepi as CODEPI,
	   (select vcatalogoepi.nome from vcatalogoepi
	   where vcatalogoepi.codepi = vemprestimoepi.CODEPI
	   and vcatalogoepi.codcoligada=vemprestimoepi.codcoligada
	  ) AS NOME_EPI,
	 /* vcatalogoepi.NOME as Nome_EPI,
	    vloteepi.IDLOTE as IDLOTE,
	   vloteepi.CA AS CA,*/
	   vemprestimoepi.DATAVALIDADE as Validade_EPI,
	  vemprestimoepi.DATAEMPRESTIMO  AS Data_emprestimo,
	   
	   CASE pfunc.codsituacao
			WHEN  'D' THEN 'DEMITIDO'
			WHEN  'A' THEN 'ATIVO'
			WHEN  'F' THEN 'FERIAS'
			WHEN  'P' THEN 'AF. PREVIDENCIA'
			WHEN  'W' THEN 'LICEN MATERN 180d'
			WHEN  'C' THEN 'CONTRATO SUSPENSO'
			WHEN  'E' THEN 'LICEN MATERNIDADE'
			WHEN  'I' THEN 'APOSENTADO INVALIDEZ'
			WHEN  'M' THEN 'SERVIÇO MILITAR'
			WHEN  'R' THEN 'LICEN REMUNERADA'
			WHEN  'T' THEN 'AFASTADO AC. TRABALHO'
			WHEN  'V' THEN 'AVISO PREVIO'
			WHEN  'O' THEN 'DOENÇA OCUPACIONAL'
	ELSE 'OUTRO_CONSULTAR_CADASTRO'
	END as SITUACAO

from pfunc (nolock)
join  pfuncao (nolock) on pfuncao.CODIGO = pfunc.CODFUNCAO
								and pfuncao.codcoligada = pfunc.codcoligada -- Nome da funcao
join psecao (nolock) on PFUNC.CODSECAO = psecao.codigo
								and psecao.codcoligada = pfunc.codcoligada -- Nome da seção
join vemprestimoepi (nolock) on pfunc.codcoligada = vemprestimoepi.codcoligada 
								and pfunc.CODPESSOA = vemprestimoepi.CODPESSOA

/*right join vcatalogoepi (nolock) on pfunc.codcoligada = vcatalogoepi.CODCOLIGADA
								--and vcatalogoepi.codepi = vloteepi.CODEPI
join vloteepi (nolock) on pfunc.codcoligada = vloteepi.codcoligada
								and vcatalogoepi.codepi = vloteepi.codepi
*/



WHERE pfunc.codcoligada = :CODCOLIGADA 
and VEMPRESTIMOEPI.DATAEMPRESTIMO  BETWEEN :INICAL AND :SECAFINAL
--and pfunc.CHAPA = '07040'

group by pfunc.codcoligada, 
		pfunc.chapa, 
		pfunc.NOME, 
		PFUNC.codfuncao, 
		pfuncao.nome, 
		pfunc.codsecao, 
		psecao.descricao, 
		PFUNC.DATAADMISSAO,
		PFUNC.DATADEMISSAO,
		pfunc.codsituacao,
		/*vcatalogoepi.NOME,
		vloteepi.codepi,		
		vloteepi.IDLOTE,
		vloteepi.CA,
		vloteepi.dtvalidade,*/
		vemprestimoepi.CODCOLIGADA, 
		vemprestimoepi.DATAEMPRESTIMO,
		vemprestimoepi.DATAVALIDADE,
		vemprestimoepi.codepi
		

order by PFUNC.codfuncao, PFUNC.CODSECAO


