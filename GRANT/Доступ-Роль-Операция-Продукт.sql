/*
developer Polyakov S.George 
*/
/*
Не забыть выставить при необходимости SET NLS_LANG=RUSSIAN_CIS.RU8PC866
Так как определение значения счетчика сделано не через последовательность
Выполнение скрипта выполнять при монопольном доступе к таблицам
*/
 
/*Разрешаем операцию для перечня продуктов,
если нет ПОЛНЫХ разрешений
*/
UPDATE T35
		SET T35CMIF=15
WHERE
		T35AGRC||'**'||T35OPTP IN 
								(
									SELECT
										T31AGRC||'**'||T1
									FROM	
										( 
											SELECT
												   T31AGRC,
												   (
													SELECT
														  T11OPTP 
													FROM
														  T11
													WHERE 
														  T11OPNM='[ИМЯ_ОПЕРАЦИИ]'     
												   ) T1
											FROM 
												  (
												   SELECT
														  *
												   FROM 
														T31
												   WHERE
														T31MBST=101 
																	   AND
														T31BACP IN (12,14,15,17,18,19,24)
												   ) B
												   LEFT JOIN 
														  (
															 SELECT 
																	T35AGRC
															 FROM 
																 (
																  SELECT
																		 T35AGRC
																  FROM 
																	   T35
																  WHERE
																	   T35AGRC IN (
																					SELECT
																						  T31AGRC 
																					FROM 
																						  T31 
																					WHERE
																						  T31MBST=101 
																									AND 
																						  T31BACP IN (12,14,15,17,18,19,24)
																				   )
																				   AND 
																	   T35OPTP=(
																				SELECT
																					  T11OPTP 
																				FROM
																					  T11
																				WHERE 
																					  T11OPNM='[ИМЯ_ОПЕРАЦИИ]' 
																			   )
																				   AND
																		T35CMIF!=15
																   )  
															   ) A ON B.T31AGRC=A.T35AGRC 
											WHERE
												  A.T35AGRC IS NULL
										)
								);
COMMIT;
/*Если совсем нет разрешений, разрешаем все*/
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
       (
        SELECT
              T11OPTP 
        FROM
              T11
        WHERE 
              T11OPNM='[ИМЯ_ОПЕРАЦИИ]'     
       ),
       0,
       0,
       15
FROM 
      (
       SELECT
              *
       FROM 
            T31
       WHERE
            T31MBST=101 
                           AND
            T31BACP IN (12,14,15,17,18,19,24)
       ) B
       LEFT JOIN 
              (
                 SELECT 
                        T35AGRC
                 FROM 
                     (
                      SELECT
                             T35AGRC
                      FROM 
                           T35
                      WHERE
                           T35AGRC IN (
                                        SELECT
                                              T31AGRC 
                                        FROM 
                                              T31 
                                        WHERE
                                              T31MBST=101 
                                                        AND 
                                              T31BACP IN (12,14,15,17,18,19,24)
                                       )
                                       AND 
                           T35OPTP=(
                                    SELECT
                                          T11OPTP 
                                    FROM
                                          T11
                                    WHERE 
                                          T11OPNM='[ИМЯ_ОПЕРАЦИИ]' 
                                   )
                                       AND
                            T35CMIF IS NULL
                       )  
                   ) A ON B.T31AGRC=A.T35AGRC 
WHERE
      A.T35AGRC IS NULL; 
COMMIT;	