/*
developer Polyakov S.George 
*/
/*
Не забыть выставить при необходимости SET NLS_LANG=RUSSIAN_CIS.RU8PC866
Так как определение значения счетчика сделано не через последовательность
Выполнение скрипта выполнять при монопольном доступе к таблицам
*/
 
/*Права на отчет*/
INSERT INTO T22(
                T22PCOD,
                T22PBST,
                T22SCOD,
                T22SBST,
                T22_ARH
               )                  
SELECT 
      (
       SELECT
              T25EMID 
       FROM 
            T25 
       WHERE 
            T25NAME='[Наименование роли]' 
      ),
      110,
      R04.R04RTCD,
      616,
      0
FROM 
	R04 LEFT JOIN (
					SELECT 
						   T22SCOD
					FROM 
						   T22
					WHERE	
						   T22PCOD IN (SELECT T25EMID FROM T25 WHERE T25NAME='[Наименование роли]')
														AND
						   T22PBST=110 
														AND 
						   T22SBST=616
					) B ON B.T22SCOD=R04.R04RTCD
	
WHERE 
	B.T22SCOD IS NULL
COMMIT;