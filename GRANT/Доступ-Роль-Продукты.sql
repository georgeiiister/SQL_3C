/*
developer Polyakov S.George 
*/
/*
Не забыть выставить при необходимости SET NLS_LANG=RUSSIAN_CIS.RU8PC866
Так как определение значения счетчика сделано не через последовательность
Выполнение скрипта выполнять при монопольном доступе к таблицам
*/
 
/*Разрешаем операцию для перечня продуктов*/
INSERT INTO T22
               (
                T22PCOD,
                T22PBST,
                T22SCOD,
                T22SBST,
                T22_ARH
               )
SELECT
       (SELECT T25EMID FROM T25 WHERE T25NAME ='[Наименование роли]'), 
       110,
       B.T31AGRC,
       101,
       0
FROM 
      (
       SELECT
              T31AGRC
       FROM 
            T31
       WHERE
            T31MBST IN (101,109) 
       ) B
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
						   T22SBST=101
                   
				) A ON B.T31AGRC=A.T22SCOD 
WHERE
      A.T22SCOD IS NULL; 
COMMIT;	