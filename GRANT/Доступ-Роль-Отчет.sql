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
            T25NAME='[ИМЯ_РОЛИ]' 
      ),
      110,
      (
       SELECT 
             R04RTCD
       FROM 
             R04 
       WHERE 
             R04RNSM='[КОРОТКОЕ_ИМЯ_ОТЧЕТА]'
      ),
       616,
       0
FROM 
     dual
WHERE
     NOT EXISTS (
                 SELECT 
                        * 
                 FROM 
                      T22 
                 WHERE
                      T22PCOD=(
                               SELECT
                                     T25EMID 
                               FROM 
                                      T25 
                               WHERE 
                                      T25NAME='[ИМЯ_РОЛИ]' 
                               )
                                AND
                       T22PBST=110
                                AND
                       T22SCOD=(
                                SELECT 
                                      R04RTCD
                                FROM 
                                      R04 
                                WHERE 
                                      R04RNSM='[КОРОТКОЕ_ИМЯ_ОТЧЕТА]'         
                                )
                                AND
                        T22SBST=616
                                AND
                        T22_ARH=0         
                 );
COMMIT;