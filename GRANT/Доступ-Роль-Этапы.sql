/*
developer Polyakov S.George 
*/
/*
�� ������ ���⠢��� �� ����室����� SET NLS_LANG=RUSSIAN_CIS.RU8PC866
��� ��� ��।������ ���祭�� ���稪� ᤥ���� �� �१ ��᫥����⥫쭮���
�믮������ �ਯ� �믮����� �� �������쭮� ����㯥 � ⠡��栬
*/
INSERT INTO T22(
                T22PCOD,
                T22PBST,
                T22SCOD,
                T22SBST,
                T22_ARH
               )                  
SELECT 
      (SELECT T25EMID FROM T25 WHERE T25NAME ='[������������ ஫�]'),
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
							'[������������ ����樨 1]',
							'[������������ ����樨 2]',
							...,
							'[������������ ����樨 N]'
						   )	
	) A
		LEFT JOIN 
					(
						SELECT 
							   T22SCOD
						FROM 
							   T22
						WHERE	
							   T22PCOD IN (SELECT T25EMID FROM T25 WHERE T25NAME='[������������ ஫�]')
															AND
							   T22PBST=110 
															AND 
							   T22SBST=103
					) B ON B.T22SCOD=A.T13PHTP			
WHERE
     B.T22SCOD IS NULL
COMMIT;