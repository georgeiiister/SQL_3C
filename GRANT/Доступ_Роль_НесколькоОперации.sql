/*
developer Polyakov S.George 
�뤠� �ࠢ ����� ஫� �� ������⢮ ����権
*/
/*
�� ������ ���⠢��� �� ����室����� SET NLS_LANG=RUSSIAN_CIS.RU8PC866
��� ��� ��।������ ���祭�� ���稪� ᤥ���� �� �१ ��᫥����⥫쭮���
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
							   T22SBST=102
					) B ON B.T22SCOD=A.T11OPTP			
WHERE
     B.T22SCOD IS NULL
COMMIT;