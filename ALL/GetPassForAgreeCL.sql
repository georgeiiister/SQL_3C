/*
Скрипт по маппингу поле за отчетами 
Скрипт не содержит COMMIT транзакции, необходимо в рамках сессии выполнить в ручную
developer Polyakov S.George 
v. 0.01
*/
/*Переносим переходы из одного отчета в другой*/
SET SERVEROUTPUT ON;
DECLARE
  NSEQR11_B R11.R11TRID%TYPE;
  RTCD R04.R04RTCD%TYPE;
  RNSM1 R04.R04RNSM%TYPE:='tblAgreeClientList'; /*таблица источник*/
  RNSM2 R04.R04RNSM%TYPE:='+eg_etalon_004'; /*таблица приёмник*/
  BYES NUMBER(1);
  CNT R11.R11TRID%TYPE:=0;
  CURSOR CR11 IS
                SELECT 
                      R11.*
                FROM
                    R04
                        INNER JOIN R11 ON R04.R04RTCD=R11.R11PTID
                WHERE 
                    R04.R04RNSM=RNSM1
                    AND
                    EXISTS (SELECT 1 FROM R04 WHERE R04.R04RNSM=RNSM1);
  RN11 CR11%ROWTYPE;
BEGIN
  SELECT R04RTCD INTO RTCD FROM R04 WHERE R04.R04RNSM=RNSM2;
  OPEN CR11;
    LOOP
          EXIT WHEN CR11%NOTFOUND;
          FETCH CR11 INTO RN11;
          BEGIN
              SELECT 
                    0 INTO BYES
              FROM DUAL
              WHERE EXISTS (
                            SELECT 
                                    1 
                            FROM 
                                    R11 
                            WHERE 
                                    NVL(R11.R11NAME,'0')=NVL(RN11.R11NAME,'0')
                                    AND
                                    NVL(R11.R11FLAG,0)=NVL(RN11.R11FLAG,0)
                                    AND
                                    R11.R11_ARH=RN11.R11_ARH
                                    AND
                                    R11.R11PTID=RTCD
                                    AND
                                    NVL(R11.R11PICT,'0')=NVL(RN11.R11PICT,'0')
                                    AND
                                    R11.R11TYPE=RN11.R11TYPE
                                    AND
                                    R11.R11TARG=RN11.R11TARG
                                    AND
                                    NVL(R11.R11TRCN,'0')=NVL(RN11.R11TRCN,'0')
                            ); --может такой переход уже есть?
          EXCEPTION
            WHEN NO_DATA_FOUND THEN BYES:=1;
          END;
          IF BYES=1 THEN
            CNT:=CNT+1;
            NSEQR11_B:=SEQ_REPORT.NEXTVAL;
            INSERT INTO R03 (
                              R03TYPE,
                              R03TOKN,
                              R03_ARH,
                              R03FLAG,
                              R03PRID,
                              R03PTID,
                              R03RLID,
                              R03COND,
                              R03TRID,
                              R03CFLD
                            )
            SELECT
                    R03.R03TYPE,
                    R03.R03TOKN,
                    R03.R03_ARH,
                    R03.R03FLAG,
                    R03.R03PRID,
                    RTCD,
                    SEQ_REPORT.NEXTVAL,
                    CASE /*если не нужна перекодировка, то убираем*/
                        WHEN UPPER(R03.R03COND)='N30AGID' THEN 'AGID'
                        WHEN UPPER(R03.R03COND) IN ('AGREETYPEID','101') THEN 'MBST'
                        WHEN UPPER(R03.R03COND)='N30CLID' THEN 'CLID'
                    ELSE    
                        R03.R03COND
                    END,
                    NSEQR11_B,
                    R03.R03CFLD
            FROM 
                    R03
            WHERE
                    R03.R03TRID=RN11.R11TRID;
            INSERT INTO R11
                            (
                              R11TRID,
                              R11NAME,
                              R11FLAG,
                              R11_ARH,
                              R11PTID,
                              R11PICT,
                              R11TYPE,
                              R11TARG,
                              R11TRCN,
                              R11ORDN
                            )
            SELECT
                  NSEQR11_B,
                  RN11.R11NAME,
                  RN11.R11FLAG,
                  RN11.R11_ARH,
                  RTCD,
                  RN11.R11PICT,
                  RN11.R11TYPE,
                  RN11.R11TARG,
                  RN11.R11TRCN,
                  RN11.R11ORDN
            FROM
                  DUAL;     
          END IF;
    END LOOP;
  CLOSE CR11;
  SYS.DBMS_OUTPUT.PUT_LINE('Добавлено переходов: '||CNT);
  EXCEPTION 
    WHEN OTHERS THEN ROLLBACK; --!! может стоит сделать более информативно, так как откат в случае ошибки
END;