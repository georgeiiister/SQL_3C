/*
developer Polyakov S.George 
�뤠� �ࠢ ����� ஫� �� ���� ������
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
      (
       SELECT
              T25EMID 
       FROM 
            T25 
       WHERE 
            T25NAME='[���_����]' 
      ),
      110,
      (
       SELECT 
             T11OPTP
       FROM 
             T11 
       WHERE 
             T11OPNM='[���_��������]'
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
                                      T25NAME='[���_����]' 
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
                                      T11OPNM='[���_��������]'         
                                )
                                AND
                        T22SBST=102
                                AND
                        T22_ARH=0         
                 );
COMMIT;