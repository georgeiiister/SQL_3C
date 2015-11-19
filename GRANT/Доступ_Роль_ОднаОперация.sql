/*
developer Polyakov S.George 
Выдача прав одной роли на одну операцию
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
             T11OPTP
       FROM 
             T11 
       WHERE 
             T11OPNM='[ИМЯ_ОПЕРАЦИИ]'
      ),
       102,
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
                                      T11OPTP
                                FROM 
                                      T11 
                                WHERE 
                                      T11OPNM='[ИМЯ_ОПЕРАЦИИ]'         
                                )
                                AND
                        T22SBST=102
                                AND
                        T22_ARH=0         
                 );
COMMIT;