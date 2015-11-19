CREATE OR REPLACE PACKAGE TUNING 
IS
VerPckg   varchar2(200) := '2.08.017.$Revision: 00001 $($Date:: 2015-06-08 13:10#$)';
-- $Author: gpolyakov $
FUNCTION GetVersion RETURN VARCHAR2;
FUNCTION Check_Inn(chInn VARCHAR2) RETURN NUMBER;
FUNCTION GetOPTP_From_OPNM(OPNM T11.T11OPNM%TYPE) RETURN T11.T11OPTP%TYPE;
END;
/


CREATE OR REPLACE PACKAGE BODY TUNING 
AS
FUNCTION GetVersion RETURN VARCHAR2 
AS 
  BEGIN
    RETURN VerPckg;
  END;
    
--$Author gpolyakov $
--Проверка корректности ИНН: 0 - ИНН неверный  1 - ИНН корректный NULL - Ошибка                                                             
FUNCTION Check_Inn(chInn VARCHAR2) RETURN NUMBER 
AS
  nRET NUMBER:=0;
  nLEN NUMBER:=0;
  chNum VARCHAR2(10):='0123456789';
  nSum NUMBER:=0;
  bNEXT BOOLEAN:=TRUE;
  nI NUMBER:=0;
  BEGIN
    BEGIN
      nLEN:=LENGTH(chInn);
      IF nLEN=10 OR nLEN=12 THEN
        WHILE (bNEXT AND nI<=nLEN) LOOP /*Только цифры*/
          nI:=nI+1;
          IF INSTR(chNum,SUBSTR(chInn,nI,1),1)=0 THEN
            bNEXT:=FALSE;
          END IF;
        END LOOP;
        IF bNEXT THEN
          IF nLEN=10 THEN
            nSUM:=MOD(
                        (
                          TO_NUMBER(SUBSTR(chInn,1,1))*2+
                          TO_NUMBER(SUBSTR(chInn,2,1))*4+
                          TO_NUMBER(SUBSTR(chInn,3,1))*10+
                          TO_NUMBER(SUBSTR(chInn,4,1))*3+
                          TO_NUMBER(SUBSTR(chInn,5,1))*5+
                          TO_NUMBER(SUBSTR(chInn,6,1))*9+ 
                          TO_NUMBER(SUBSTR(chInn,7,1))*4+
                          TO_NUMBER(SUBSTR(chInn,8,1))*6+
                          TO_NUMBER(SUBSTR(chInn,9,1))*8
                        ),11
                      ); 
            IF nSUM=SUBSTR(chInn,10,1) THEN --остаток от деления должен совпадать с последней цифрой
              nRet:=1;
            END IF;
          ELSE
            nSUM:=MOD(
                        (
                          TO_NUMBER(SUBSTR(chInn,1,1))*7+
                          TO_NUMBER(SUBSTR(chInn,2,1))*2+
                          TO_NUMBER(SUBSTR(chInn,3,1))*4+
                          TO_NUMBER(SUBSTR(chInn,4,1))*10+
                          TO_NUMBER(SUBSTR(chInn,5,1))*3+
                          TO_NUMBER(SUBSTR(chInn,6,1))*5+
                          TO_NUMBER(SUBSTR(chInn,7,1))*9+ 
                          TO_NUMBER(SUBSTR(chInn,8,1))*4+
                          TO_NUMBER(SUBSTR(chInn,9,1))*6+
                          TO_NUMBER(SUBSTR(chInn,10,1))*8
                        ),11
                      );
            IF nSUM=SUBSTR(chInn,11,1) THEN --остаток от деления должен совпадать с последней цифрой
              nSUM:=MOD(
                          (
                            TO_NUMBER(SUBSTR(chInn,1,1))*3+
                            TO_NUMBER(SUBSTR(chInn,2,1))*7+
                            TO_NUMBER(SUBSTR(chInn,3,1))*2+
                            TO_NUMBER(SUBSTR(chInn,4,1))*4+
                            TO_NUMBER(SUBSTR(chInn,5,1))*10+
                            TO_NUMBER(SUBSTR(chInn,6,1))*3+
                            TO_NUMBER(SUBSTR(chInn,7,1))*5+
                            TO_NUMBER(SUBSTR(chInn,8,1))*9+ 
                            TO_NUMBER(SUBSTR(chInn,9,1))*4+
                            TO_NUMBER(SUBSTR(chInn,10,1))*6+
                            TO_NUMBER(SUBSTR(chInn,11,1))*8
                          ),11
                      );
              IF nSUM=SUBSTR(chInn,12,1) THEN
                nRET:=1;
              END IF;
            END IF;
          END IF;
        END IF;     
      END IF;
    EXCEPTION
      WHEN OTHERS THEN nRET:=NULL;
    END;
    RETURN nRET;
  END;

--$Author gpolyakov $
--Поиск операции по OPNM и возврат OPTP: Return NULL операция не найдена или ошибка выполнения
FUNCTION GetOPTP_From_OPNM(OPNM T11.T11OPNM%TYPE) RETURN T11.T11OPTP%TYPE
AS
  OPTP T11.T11OPTP%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT T11.T11OPTP INTO OPTP FROM T11 WHERE T11.T11OPNM=OPNM;
    EXCEPTION 
      WHEN OTHERS THEN NULL;
  END;
  RETURN OPTP;
END;
END TUNING;
/
