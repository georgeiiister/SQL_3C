/*
developer Polyakov S.George 
*/
/*
�� ������ ���⠢��� �� ����室����� SET NLS_LANG=RUSSIAN_CIS.RU8PC866
��� ��� ��।������ ���祭�� ���稪� ᤥ���� �� �१ ��᫥����⥫쭮���
�믮������ �ਯ� �믮����� �� �������쭮� ����㯥 � ⠡��栬
*/
 
/*�ࠢ� �� ����*/
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
             R04RTCD
       FROM 
             R04 
       WHERE 
             R04RNSM='[��������_���_������]'
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
                                      T25NAME='[���_����]' 
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
                                      R04RNSM='[��������_���_������]'         
                                )
                                AND
                        T22SBST=616
                                AND
                        T22_ARH=0         
                 );
COMMIT;