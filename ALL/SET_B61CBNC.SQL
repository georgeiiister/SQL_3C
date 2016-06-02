create or replace PROCEDURE SET_B61CBNC(P_SS IN OUT RMON.fcScriptState)
IS

  v_nCMPC B61.B61CMPC%TYPE;
  v_nCBNC B61.B61CBNC%TYPE;
  v_rB61ROW B61%ROWTYPE;
  v_nJPID T84.T84JPID%TYPE;
  v_rT84ROW T84%ROWTYPE;
  P_ERROR VARCHAR2(255):=NULL;     
  P_ERROR_PARAM VARCHAR2(255):=NULL;
  
  BEGIN 
       v_nCMPC:=RPARAM.GETPARAMN(P_SS.m_nOPID,'CMPC');
       v_rB61ROW:=RCARD.GETORGCARD(v_nCMPC);
       IF v_rB61ROW.B61CMPC IS NULL THEN
          BEGIN
            p_SS.m_sError := 'L1220'; --не нашли B61
            p_SS.m_sErrorParams := v_nCMPC;
          END;
       END IF; 
      IF p_SS.m_bRollback = 0 THEN --накат
          BEGIN 
            IF v_rB61ROW.B61CMPC IS NOT NULL THEN      
              BEGIN
                IF v_rB61ROW.B61CBNC IS NOT NULL THEN 
                  BEGIN
                    RPARAM.SETPARAMPHASE(P_SS,'OLD_CBNC',v_rB61ROW.B61CBNC);
                  END;
                END IF;
                v_nJPID:=RPARAM.GETPARAMN(P_SS.m_nOPID,'JPID');
                v_rT84ROW:=LEGAL.GetLegal(v_nJPID);
                IF v_rT84ROW.T84JPID IS NOT NULL THEN
                  BEGIN
                    --обновляем 
                    LEGAL.SAVELEGALUNIT(
                                        v_nCMPC,              -- B61CMPC Уникальный номер, идентифицирующий группу договоров
                                        v_rB61ROW.B61CMPN,    -- B61CMPN Название группы договоров
                                        v_rB61ROW.B61CMEN,    -- B61CMEN Название организации при эмбосировании
                                        v_nJPID,              -- B61CBNC Код группы договоров в кодировке банка
                                        v_rB61ROW.B61OPRI,    -- B61OPRI Идентификатор сотрудника, создавшего группу договоров
                                        v_rB61ROW.B61TAGO,    -- B61TAGO Тэг доступа к группе договоров
                                        v_rB61ROW.B61JPID,    -- B61JPID Идентификатор юридического лица в системе. Ссылка на T84JPID.
                                        0,
                                        0,
                                        P_ERROR,     
                                        P_ERROR_PARAM
                                        );
                    IF P_ERROR IS NOT NULL OR P_ERROR_PARAM IS NOT NULL THEN
                        BEGIN
                          p_SS.m_sError := P_ERROR;
                          p_SS.m_sErrorParams := P_ERROR_PARAM;
                        END;  
                    END IF;  
                  END;
                ELSE
                  BEGIN
                    p_SS.m_sError := 'R0088'; --не нашли ЮЛ
                    p_SS.m_sErrorParams := v_nJPID;
                  END;  
                END IF;
              END;
            END IF;
          END;
      ELSE
        --откат
        v_nCBNC:=RPARAM.GETPARAMS(P_SS.m_nOPID,'OLD_CBNC');
        IF v_nCBNC IS NOT NULL THEN
          --возвращаем старое значение CBNC
          BEGIN
            --обновляем 
            LEGAL.SAVELEGALUNIT(
                                v_nCMPC,              -- B61CMPC Уникальный номер, идентифицирующий группу договоров
                                v_rB61ROW.B61CMPN,    -- B61CMPN Название группы договоров
                                v_rB61ROW.B61CMEN,    -- B61CMEN Название организации при эмбосировании
                                v_nCBNC,              -- B61CBNC Код группы договоров в кодировке банка
                                v_rB61ROW.B61OPRI,    -- B61OPRI Идентификатор сотрудника, создавшего группу договоров
                                v_rB61ROW.B61TAGO,    -- B61TAGO Тэг доступа к группе договоров
                                v_rB61ROW.B61JPID,    -- B61JPID Идентификатор юридического лица в системе. Ссылка на T84JPID.
                                0,
                                0,
                                P_ERROR,     
                                P_ERROR_PARAM
                                );
            IF P_ERROR IS NOT NULL OR P_ERROR_PARAM IS NOT NULL THEN
                BEGIN
                  p_SS.m_sError := P_ERROR;
                  p_SS.m_sErrorParams := P_ERROR_PARAM;
                END;  
            END IF;
          END;  
        END IF;
      END IF;
  EXCEPTION
    WHEN OTHERS THEN 
      p_SS.m_sError := 'SM008';
      p_SS.m_sErrorParams := NULL;    
  END SET_B61CBNC;