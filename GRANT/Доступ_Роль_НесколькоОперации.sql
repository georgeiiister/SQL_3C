/*
developer Polyakov S.George 
Выдача прав одной роли на множество операций
*/
/*
Не забыть выставить при необходимости SET NLS_LANG=RUSSIAN_CIS.RU8PC866
Так как определение значения счетчика сделано не через последовательность
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
      A.T11OPTP,
      102,
      0
FROM 
	(
		SELECT 
				T11OPTP 
		FROM 
				T11
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
							   T22SBST=102
					) B ON B.T22SCOD=A.T11OPTP			
WHERE
     B.T22SCOD IS NULL
COMMIT;