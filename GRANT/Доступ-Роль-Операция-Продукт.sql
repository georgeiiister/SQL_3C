/*
developer Polyakov S.George 
*/
/*
�� ������ ���⠢��� �� ����室����� SET NLS_LANG=RUSSIAN_CIS.RU8PC866
��� ��� ��।������ ���祭�� ���稪� ᤥ���� �� �१ ��᫥����⥫쭮���
�믮������ �ਯ� �믮����� �� �������쭮� ����㯥 � ⠡��栬
*/
 
/*����蠥� ������ ��� ����� �த�⮢,
�᫨ ��� ������ ࠧ�襭��
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
														  T11OPNM='[���_��������]'     
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
																					  T11OPNM='[���_��������]' 
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
/*�᫨ ᮢᥬ ��� ࠧ�襭��, ࠧ�蠥� ��*/
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
              T11OPNM='[���_��������]'     
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
                                          T11OPNM='[���_��������]' 
                                   )
                                       AND
                            T35CMIF IS NULL
                       )  
                   ) A ON B.T31AGRC=A.T35AGRC 
WHERE
      A.T35AGRC IS NULL; 
COMMIT;	