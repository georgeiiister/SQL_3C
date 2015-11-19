/*
developer Polyakov S.George 
*/
/*
Не забыть выставить при необходимости SET NLS_LANG=RUSSIAN_CIS.RU8PC866
Так как определение значения счетчика сделано не через последовательность
Выполнение скрипта выполнять при монопольном доступе к таблицам
*/
INSERT INTO T22(
                T22PCOD,
                T22PBST,
                T22SCOD,
                T22SBST,
                T22_ARH
               )                  
SELECT 
      (SELECT T25EMID FROM T25 WHERE T25NAME ='[Наименование роли]'),
      110,
      A.T13PHTP,
      103,
      0
FROM 
	(
		SELECT 	
			DISTINCT 
					T13PHTP 
		FROM 
				T11 INNER JOIN T13 ON T13.T13OPTP=T11.T11OPTP
		WHERE 
				T11OPNM IN (
							'[Наименование операции 1]',
							'[Наименование операции 2]',
							...,
							'[Наименование операции N]'
						   )	
	) A
		LEFT JOIN 
					(
						SELECT 
							   T22SCOD
						FROM 
							   T22
						WHERE	
							   T22PCOD IN (SELECT T25EMID FROM T25 WHERE T25NAME='[Наименование роли]')
															AND
							   T22PBST=110 
															AND 
							   T22SBST=103
					) B ON B.T22SCOD=A.T13PHTP			
WHERE
     B.T22SCOD IS NULL
COMMIT;