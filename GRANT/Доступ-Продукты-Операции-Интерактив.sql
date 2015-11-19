/*
ДОБАВЛЕНИЕ ВСЕХ ПРАВ C ИНТЕРАКТИВОМ ОТ ПОЛЬЗОВАТЕЛЯ
Оператор вводит коды операций через запятую, коды продуктов через запятую
если ПРАВА ЛЮБОЙ ОБПЕРАЦИИ ИЗ ВВЕДЕННОЙ НА ЛЮБОЙ ПРОДУКТ отсутствуют полностью
произойдет добавление прав
*/
SET DEFINE ON;
INSERT INTO T35
              (
                T35AGRC,
                T35OPTP,
                T35_ARH,
                T35TCOD,
                T35CMIF
              )
SELECT
      T31AGRC,
      T11OPTP,
      0,
      0,
      15
FROM 
    (
      (
        SELECT 
              T11OPTP 
        FROM 
              T11 
        WHERE 
              T11OPTP IN (&INSERT_OPTP_SPLIT)
      ) A
      CROSS JOIN (
                  SELECT 
                        T31AGRC 
                  FROM 
                        T31 
                  WHERE 
                        T31AGRC IN (&INSERT_AGRC_SPLIT)
                 ) B 
    ) LEFT JOIN (
                  SELECT 
                        T35AGRC,
                        T35OPTP 
                  FROM T35
                ) C ON A.T11OPTP=C.T35OPTP AND B.T31AGRC=C.T35AGRC
WHERE 
      C.T35AGRC IS NULL;
COMMIT;