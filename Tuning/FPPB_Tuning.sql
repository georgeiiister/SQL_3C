create or replace PACKAGE TUNING
IS
VerPckg   varchar2(200) := '2.08.021.$Revision: 00002 $($Date:: 2015-08-21 16:00#$)';
TL_POT CONSTANT NUMBER := 148;    -- �������� ���������� ����������
TREE_POT CONSTANT NUMBER := 206; -- ������ ������ ��������� ���������� ����������
-- $Author: gpolyakov $
FUNCTION GetVersion RETURN VARCHAR2;
FUNCTION Check_Inn(chInn VARCHAR2) RETURN NUMBER;
FUNCTION GetOPTP_From_OPNM(OPNM T11.T11OPNM%TYPE) RETURN T11.T11OPTP%TYPE;
--������� ���������� ��� ������� �������� �� ����� ���������������� � ��������������� ����������
FUNCTION GET_OPTP_BY_FNAME (vFUNC VARCHAR2,vFUNCAIM VARCHAR2) RETURN NUMBER;
--������� ���������� ��� ������� �������� �� ���� ���������������� � ��������������� ����������
FUNCTION GET_OPTP_BY_FNAME_ (vFUNC NUMBER,vFUNCAIM VARCHAR2) RETURN NUMBER;
FUNCTION GET_OPTP_BY_FNAME (vFUNC NUMBER,vFUNCAIM VARCHAR2) RETURN NUMBER;
/*���������� �� ��������� ����� ��������-������������� �������*/
FUNCTION GET_INCD_BY_SHORTNAME (nOTYPE NUMBER,vSHORTNAME VARCHAR2) RETURN NUMBER;
/*������� ���������� ������ �������������� ���������� ��� �������� � ��������� ���������������*/
FUNCTION get_list_of_faim (vFUNC NUMBER) RETURN LIST_T;
FUNCTION get_list_of_faim_ (vFUNC NUMBER)RETURN LIST_T;
/*������� ���������� ��� ���������������� ��� ��������������� ���������� ��������*/
FUNCTION GET_FUNCNAME_BY_OPTP (nOPTP NUMBER,nVAR NUMBER) RETURN NUMBER;
/*������� �� ����� ������ � �������� ������ ���������� ���������� ��������� ���������� ������*/
FUNCTION RET_CODE_FR(vREPNAME VARCHAR2,vPARAM VARCHAR2) RETURN VARCHAR2;
/*������� ������������ ������������� �� ���� ������� � ��� ����, ���������� 1 ��� ���������, 0-�� ��������, -1 �� ����������*/
FUNCTION RETREZOBJECT(idob varchar2,obtype number) RETURN NUMBER;
/*����� ������ ����� � ������*/
FUNCTION ACC_DESC(xDESC VARCHAR2)RETURN VARCHAR2;
/*����� ���� ������� ������������ �������� �� �������������� ��������*/
FUNCTION GET_OPTP_BY_OPID(xINOPID number,xP number default 0) return number;
/*������������� �� ���-��*/
PROCEDURE CREATELINK_FOR_POT(SS IN out fcscriptstate);
/*����� ������� �� ���� �������� �� ����� � acgn=PACGN, ������������ � �������� �������� PMBID */
FUNCTION GETSUMREZ(PMBID NUMBER ,POPID NUMBER,PACGN NUMBER ) RETURN NUMBER;
FUNCTION GetLnkN20(LTYP N20.N20LTYP%TYPE, OWNR N20.N20OWNR%TYPE, OWST N20.N20OWST%TYPE,MBST N20.N20MBST%TYPE) RETURN N20.N20MBID%TYPE;
FUNCTION GetLnkN20TM(
                    LTYP C01.C01LTYP%TYPE, --������������� ������� �����
                    MBRL N20.N20MBRL%TYPE, --���� ������� ������� � ���� ����������
                    CLID N30.N30CLID%TYPE, --�������� �������� ������� �������
                    CURC N30.N30CURC%TYPE, --������ �������� ������� �������
                    OWST N30.N30MBST%TYPE, --��� ������� �������
                    MBST N30.N30MBST%TYPE, --��� ������� �������
                    OWID N30.N30OWID%TYPE  --�������������
                   ) RETURN N20.N20OWNR%TYPE;
PROCEDURE SETOBJECTATTR(OBID NUMBER,MBST NUMBER,VAL VARCHAR2);
/*��������� ������ ��� �������� ������ � ����� */
FUNCTION GET_RATE_STR (AGID number, RATE number,RATE_NUM number, desc1 varchar2 default '��������' ) return varchar2;
/*��������� ��� �� ���� BNCD �� T70*/
FUNCTION fncGetBIK_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BBIK%TYPE;
/*������� ��������� ���� ������� �� id ����� � ���� �������*/
FUNCTION GetMbidByAcnc (nACNC n67.n67acnc%TYPE, nMBST n67.n67mbst%TYPE) RETURN NUMBER;
/*������� ��������� ������������ ����� �� ���� BNCD �� T70*/
FUNCTION fncGetBNNM_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BNNM%TYPE;
/*������� ��������� �������� ����� �� ���� BNCD �� T70*/
FUNCTION fncGetBKAC_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BKAC%TYPE;
/*��������� ������� ���� N30APNX ����� ���������� �� ��������� ����� ��������, �� ������ ������������� ������.*/
PROCEDURE plsql_upd_apnx(p_SS IN OUT fcScriptState,
    nTREE_ID  IN NUMBER,
    sREPORT_NAME IN VARCHAR2,
    nMODE in NUMBER default 0
    );
/*����� ��������� plsql_upd_apnx*/
PROCEDURE plsql_rolb_upd_apnx(p_SS IN OUT fcScriptState);
/*������� ������ ���� �������� ���������� �����*/
FUNCTION GetLinkAgid (nAGID n67.n67mbid%TYPE, nACGN n67.n67acgn%TYPE) RETURN NUMBER;
/*������� ��� ������������� � ���������������� ������������� ��������� ��� ���������� ��������������� ������
������������� ��������.*/
FUNCTION GET_MF_ACNC
(
nSEID N02.N02SEID%TYPE, --��� ������������� ���������
nCURC N30.N30CURC%TYPE, --��� ������ ��������
sACCT VARCHAR2,         --�������� ����������� ����� ��� ����� ��������. ����� ������� �� ��������� �� �������������
                        --����������� ��������� sACCT
                        --������ �������� ������ ��������� ����� ���� ��������  2- 30302 - �������� ����
                        --                                                      1- 30301 - ��������� ����
                        --������ ������ ��������� ������ ��� �������� ����������� F - ������
                        --                                                        G - ������
                        --������ ������ ��������� �� �������� ���� ��� ������    D - �� ��������� �������
                        --                                                       S - ���. ������
nPACGN NUMBER DEFAULT 178,--��� ���������� ����� ���������� �����
nAACGN NUMBER DEFAULT 179 --��� ���������� ����� ��������� �����

)
 RETURN NUMBER;
/*������� ����������� ������� � ������� ��������� � ������ ��������� �������� ����
  ����� ������� ����� ������������ � �������� ��������� 1 - ����� ����; 0 - ������ ���*/
FUNCTION EXIST_FREE_LINK_AGID (
  nAGID N30.N30AGID%TYPE, --��� �������� ��� �������� ���������� ������� ��������� ��������� ������
  nPAGT T31.T31PAGT%TYPE  --��� �������� �������� � ������ �������� ��������� ���������� ������� ��������� ��������� ������
                              ) RETURN NUMBER;

PROCEDURE update_n38tssd(p_SS IN OUT fcScriptState);
/*������� ���������� ������������ ����������� �������� �� ���� ��������*/
FUNCTION GET_T31BPRN(nAGRC T31.T31AGRC%TYPE) RETURN VARCHAR2;
/*������� ���������� ��� �������� �������� ���� ���� �� ���� ��������*/
FUNCTION GET_T31PAGT(nAGRC T31.T31AGRC%TYPE) RETURN NUMBER;
/*������� ������������� ��� ������������� � ���������� ��������� �������� � ��������� ��� �������� �� ���������
���������� ���������� ������ �� �������� � ��������� ����*/
FUNCTION GET_RATE_DESC
(
 P_AGTP N30.N30AGTP%TYPE,                 -- ������������� ����������� ��������
 P_ACGN N67.N67ACGN%TYPE,                 -- ������������� ���������� ����� �ר��
 P_CURC N67.N67ACRC%TYPE DEFAULT NULL,    -- ��� ������ �ר��
 P_DTEF IN DATE DEFAULT NULL,             -- ���� ������ �������� ��������
 P_DTEX IN DATE DEFAULT NULL,             -- ���� ��������� �������� ��������
 P_FOR_DATE DATE DEFAULT DIVISION.OperDate+1,  -- ���� �� ������� ����� ���������� ������
 P_AGREE_SUM NUMBER DEFAULT 0,            -- ����� ��������������� ������
 P_EARL_TEREM NUMBER DEFAULT 0,           -- ������� ���������� ����������� ��������
 P_EARL_TEREM_DATE DATE DEFAULT DIVISION.OperDate+1, --���� � ������� �������������� ����������� �������
 P_SPEC_RATE_FLAG NUMBER DEFAULT 0,       -- ������� ���������� ������ ��� ��������� ����������� ����� - SpecialReducedInterestRate
 P_SPEC_RATE_TREE NUMBER DEFAULT 0,       -- ��� ������ � ������� ������ ���������� ������ ��� ��������� �����������
 P_OPTIONS VARCHAR2 DEFAULT NULL          -- ����� ����������� �������� � ��������������� ���� <BANKPRODUCT_OPTIONS><��� �����1>�������� �����1</��� �����1><��� �����2>�������� �����2</��� �����2>...</BANKPRODUCT_OPTIONS>
) RETURN VARCHAR2;
/*������� ������������� ��� ������������� � ���������� ��������� �������� � ��������� ��� �������� �� ���������
���������� ���������� ������ �� ��������*/
FUNCTION GET_RATE
(
 P_AGTP N30.N30AGTP%TYPE,                 -- ������������� ����������� ��������
 P_ACGN N67.N67ACGN%TYPE,                 -- ������������� ���������� ����� �ר��
 P_CURC N67.N67ACRC%TYPE DEFAULT NULL,    -- ��� ������ �ר��
 P_DTEF IN DATE DEFAULT NULL,             -- ���� ������ �������� ��������
 P_DTEX IN DATE DEFAULT NULL,             -- ���� ��������� �������� ��������
 P_FOR_DATE DATE DEFAULT DIVISION.OperDate+1,  -- ���� �� ������� ����� ���������� ������
 P_AGREE_SUM NUMBER DEFAULT 0,            -- ����� ��������������� ������
 P_EARL_TEREM NUMBER DEFAULT 0,           -- ������� ���������� ����������� ��������
 P_EARL_TEREM_DATE DATE DEFAULT DIVISION.OperDate+1, --���� � ������� �������������� ����������� �������
 P_SPEC_RATE_FLAG NUMBER DEFAULT 0,       -- ������� ���������� ������ ��� ��������� ����������� ����� - SpecialReducedInterestRate
 P_SPEC_RATE_TREE NUMBER DEFAULT 0,       -- ��� ������ � ������� ������ ���������� ������ ��� ��������� �����������
 P_FLAG NUMBER DEFAULT 0,                 -- 0 - ������� ���������� ������, 1 - ������� ����������� �����, 2 - ������� ���������� ������, ��� ��������� �������, 3 - ������� ��������
 P_OPTIONS VARCHAR2 DEFAULT NULL          -- ����� ����������� �������� � ��������������� ���� <BANKPRODUCT_OPTIONS><��� �����1>�������� �����1</��� �����1><��� �����2>�������� �����2</��� �����2>...</BANKPRODUCT_OPTIONS>
) RETURN NUMBER;
/*������� ������������ ���� ������� � �������� ������ �����*/
FUNCTION IS_OPTIONS (nAGID N30.N30AGID%TYPE) RETURN NUMBER;
FUNCTION GetN44agid(CMPC N30.N30CMPC%TYPE) RETURN N44.N44AGID%TYPE;
/*������� ���������� �������� ������� �� ������������� (PCODE), ��� �������� (PAGID), �� ���� (ADT)*/
FUNCTION GetRezForDebt(PAGID NUMBER,POPID NUMBER,ADT DATE,PCODE NUMBER) RETURN NUMBER;
/*������� ��� ��������� ������ � �������� ���������� �������� ���.�������������� ����� MIND � ������ �� ����� ��������*/
FUNCTION DESC_PROD_PARAM
(
nAGRC T31.T31AGRC%TYPE,--��� ����������� ��������
nTERM NUMBER, -- ���� ��������
FOR_DATE DATE DEFAULT DIVISION.OPERDATE+1 --���� �� ������� ���������� �������� ������
)RETURN VARCHAR2;
/*������� ���������� ������������ ����� �� �������� ����� ������ �� ��������� �������
����������� ����� ���������� ������ ��������� �� ������� ������ ��������*/
FUNCTION CLIENT_MAX_BALANCE
(nAGID N30.N30AGID%TYPE, --��� �������� �� �������� ���� ������ �������� �������
sBPGI VARCHAR2 DEFAULT NULL, --������ �� ������� ����� ���������� ��������� ����� ������� ����� ������� ���� ��������
sPAGT VARCHAR2 DEFAULT NULL, --������ �� ������� ������� ���������� ��������� ����� ������� ����� ������� ���� ��������
sAGRC VARCHAR2 DEFAULT NULL --������ �� ������� ���������� ��������� ����� ������� ����� ������� ���� ��������
)RETURN NUMBER;

/*���������� ����� ������� �������� �� �������*/
FUNCTION RETCOUNTOPERSTART
(nOBJ NUMBER, --������������� �������
 nTYPE NUMBER,--������������� ���� �������
 nOPT NUMBER --������������� ��������
) RETURN NUMBER;

/*���������� �������� ��������� CURC �� ��������*/
 FUNCTION Get200_CURC(SEID NUMBER) RETURN NUMBER;
 FUNCTION my_to_num(val   IN  varchar)RETURN NUMBER;
 function Get_interest(Agid NUMBER) RETURN number;

 /* ��������� �����-��� ������������� ������� � ������ ���*/
 FUNCTION DecodeKRKCBarcode(
    p_sOriginalCode IN  VARCHAR2
)
RETURN VARCHAR2;

/*������� ���������� ������������ ���������������� �� ���� ����������������*/
/*����� ���� ������������ ���������� � registr.get_info, ������� ���������� ���*/
/*nOTYP - ��� �������*/
/*nCODE - ��� ����������������*/
FUNCTION GET_FUNCNAME_BY_OTYPE (nOTYP NUMBER,nCODE NUMBER) RETURN VARCHAR2;
PROCEDURE AUTOCREATEACCEPT(SS IN out fcscriptstate);--�������������� �������� ��������
FUNCTION get_comiss_za_otkr_Main_num(agid n30.n30agid%TYPE)
--���������� ����� �������� �� �������� �������� ����� �� ��������
RETURN number;

/*������� ��� ������ ��������� ������*/
FUNCTION FIND_ACNC_BY_ACGN(AGID N32.n32agid%TYPE,ACGN N32.n32acgn%TYPE,ACRC N32.n32acrc%TYPE) RETURN N32.N32ACNC%TYPE;
--FUNCTION Get200_CURC(SEID NUMBER) RETURN NUMBER;
FUNCTION GetLnkN20SE(
                      LTYP C01.C01LTYP%TYPE, --������������� ������� �����
                      OWNR N20.N20OWNR%TYPE, --������������� ������� ���������
                      OWST N20.N20OWST%TYPE, --������������� ������� ���������
                      OWRL N20.N20OWRL%TYPE, --�� ���� ������� ��������� �����
                      MBST N20.N20MBST%TYPE, --��� ������� ���������
                      MBRL N20.N20MBRL%TYPE  --�� ���� ������� ���������
                    ) RETURN N20.N20MBID%TYPE;
/*������� ��� �������������� �������� ����� � ������*/
FUNCTION tostring0(pSum in number) return varchar2;
FUNCTION get_distantion_agid(param number)  RETURN VARCHAR2;
/*������� ������ �������������� ������� ����� �� ������������ �����*/
FUNCTION GET_LTYP_NAME(LNAME C01.C01NAME%TYPE) RETURN C01.C01LTYP%TYPE;
/*������� ������ �������������� ���� �� ������������ ����*/
FUNCTION GET_ROBID_NAME(LNAME C07.C07NAME%TYPE,LTYP C01.C01LTYP%TYPE) RETURN C01.C01LTYP%TYPE;
/*������� ��� ��������� ����������� �������� �� ����������*/
FUNCTION get_agid_by_clid_bacp_curc(pCLID in number, pBACP in number, pCURC in number)RETURN number;
FUNCTION Get_INSC (ACCOUNT in NUMBER, OPENDATE in DATE default NULL)RETURN NUMBER;
END;
/
create or replace PACKAGE BODY TUNING
AS
FUNCTION GetVersion RETURN VARCHAR2
AS
  BEGIN
    RETURN VerPckg;
  END;

--$Author gpolyakov $
--�������� ������������ ���: 0 - ��� ��������  1 - ��� ���������� NULL - ������
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
        WHILE (bNEXT AND nI<=nLEN) LOOP /*������ �����*/
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
            IF nSUM=SUBSTR(chInn,10,1) THEN --������� �� ������� ������ ��������� � ��������� ������
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
            IF nSUM=SUBSTR(chInn,11,1) THEN --������� �� ������� ������ ��������� � ��������� ������
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
--����� �������� �� OPNM � ������� OPTP: Return NULL �������� �� ������� ��� ������ ����������
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

FUNCTION GET_OPTP_BY_FNAME (vFUNC VARCHAR2,vFUNCAIM VARCHAR2)
RETURN NUMBER
IS
/*������� ���������� ��� ������� �������� � ������� �������������� ��������� */
/*���������������� � �������������� ����������*/
/*����������� � �������� vFUNC � vFUNCAIM ��������������*/

nOPTP NUMBER;--������� �������� � ����������� ���������������� vFUNC � �������������� ����������� vFUNCAIM
vREPNAME VARCHAR2(256);--������� ����� �� ������� �����������������
vPARAMSTR VARCHAR2(256);--��������� ������ � ���� '����������������=��� ����������������'
nFUNCODE NUMBER;--��� ����������������
nCODE NUMBER;--��� � b88
BEGIN
    BEGIN
    vREPNAME:='+eg_ListOfFuncName';
            --�������� ��� ���������������� �� �������������
            select CODE into nFUNCODE
                  from table(addinfo.GetB94List(
                                                102,
                                                100,
                                                null,
                                                null
                                                )
                             ) T
                  WHERE  T.TEXT=upper(vFUNC);
                             vPARAMSTR:='����������������='||nFUNCODE;

            --�������� ��� ������ � ������� ���. ���������� �� ���� ���������������� � ��������������� ����������
            select T2.VS INTO nCODE
                  from
                     table (
                             REPORT_MANAGER.GenerateReport
                                                         (
                                                        vREPNAME,   -- ������� ������������ ������
                                                        vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                        )
                           ) T1,
                     table (
                            REPORT_MANAGER.GenerateReport
                                                     (
                                                    vREPNAME,   -- ������� ������������ ������
                                                    vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                    )
                        ) T2
             where T1.SNAME='TEXT' and
             --substr(T1.VS,0,instr( T1.VS,'(')-1)=upper(vFUNCAIM) and
                   T1.VS=upper(vFUNCAIM) and
                   T1.SN=T2.SN  and
                   T2.SNAME='CODE';
                        --��������� ���� ��������
                         select A_B88.B88MBID INTO nOPTP
                         from b88 A_B88,b88 B_B88
                            where
                            A_B88.b88mbst=102 and B_B88.b88mbst=102 AND
                            A_B88.b88mbid=B_B88.b88mbid and
                            A_B88.b88incd=100 and
                            A_B88.b88info=nFUNCODE and
                            B_B88.b88incd=101 and
                            B_B88.b88info=nCODE;

    EXCEPTION  WHEN OTHERS THEN nOPTP:=0;

    END;

    RETURN nOPTP;
END;

FUNCTION GET_OPTP_BY_FNAME_ (vFUNC NUMBER,vFUNCAIM VARCHAR2)
RETURN NUMBER
IS
/*������� ���������� ��� ������� �������� � ������� �������������� ��������� */
/*���������������� � �������������� ����������*/
/*����������� � �������� vFUNC � vFUNCAIM ��������������*/
/*�����: ������ �.�*/
/*v. 1.0 �� (01.09.2014)*/

nOPTP NUMBER;--������� �������� � ����������� ���������������� vFUNC � �������������� ����������� vFUNCAIM
vREPNAME VARCHAR2(256);--������� ����� �� ������� �����������������
vPARAMSTR VARCHAR2(256);--��������� ������ � ���� '����������������=��� ����������������'
nFUNCODE NUMBER;--��� ����������������
nCODE NUMBER;--�������� b98info, �� �������� ����� ������������� �����
nPAR1 NUMBER;--��������� ���.���� � ����������� ������� FunctionName (����������������)
nPAR2 NUMBER;--��������� ���.���� � ����������� ������� FunctionAim (�������������� ����������)
BEGIN
    BEGIN
    vREPNAME:='+eg_ListOfFuncName';
    vPARAMSTR:='����������������='||vFUNC;
    --�������� ��������� ��� ����������, ��������� � ���������
    nPAR1:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONNAME');
    nPAR2:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONAIM');

            --�������� ��� ������ � ������� ���. ���������� �� ���� ���������������� � ��������������� ����������
            select T2.VS INTO nCODE
                  from
                     table (
                             REPORT_MANAGER.GenerateReport
                                                         (
                                                        vREPNAME,   -- ������� ������������ ������
                                                        vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                        )
                           ) T1,
                     table (
                            REPORT_MANAGER.GenerateReport
                                                     (
                                                    vREPNAME,   -- ������� ������������ ������
                                                    vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                    )
                        ) T2
             where T1.SNAME='TEXT' and
             --substr(T1.VS,0,instr( T1.VS,'(')-1)=upper(vFUNCAIM) and
                   T1.VS=upper(vFUNCAIM) and
                   T1.SN=T2.SN  and
                   T2.SNAME='CODE';
            --��������� ���� ��������
                         select A_B88.B88MBID INTO nOPTP
                         from b88 A_B88,b88 B_B88
                            where
                            A_B88.b88mbst=102 and B_B88.b88mbst=102 AND
                            A_B88.b88mbid=B_B88.b88mbid and
                            A_B88.b88incd=nPAR1 and
                            A_B88.b88info=vFUNC and
                            B_B88.b88incd=nPAR2 and
                            B_B88.b88info=nCODE;

    EXCEPTION  WHEN OTHERS THEN nOPTP:=0;

    END;

    RETURN nOPTP;
END;

FUNCTION GET_OPTP_BY_FNAME (vFUNC NUMBER,vFUNCAIM VARCHAR2)
RETURN NUMBER
IS
/*������� ���������� ��� ������� �������� � ������� �������������� ��������� */
/*���������������� � �������������� ����������*/
/*����������� � �������� vFUNC � vFUNCAIM ��������������*/
/*�����: ������ �.�*/
/*v. 2.0 �� (17.12.2015)*/

nOPTP NUMBER;--������� �������� � ����������� ���������������� vFUNC � �������������� ����������� vFUNCAIM
vREPNAME VARCHAR2(256);--������� ����� �� ������� �����������������
vPARAMSTR VARCHAR2(256);--��������� ������ � ���� '����������������=��� ����������������'
nFUNCODE NUMBER;--��� ����������������
nCODE NUMBER;--�������� b98info, �� �������� ����� ������������� �����
nPAR1 NUMBER;--��������� ���.���� � ����������� ������� FunctionName (����������������)
nPAR2 NUMBER;--��������� ���.���� � ����������� ������� FunctionAim (�������������� ����������)
nSTR NUMBER:=0;
nSignForRetValue NUMBER:=0;--������� �������� ��������
BEGIN
    BEGIN
    vREPNAME:='+eg_ListOfFuncName';
    vPARAMSTR:='����������������='||vFUNC;
    --�������� ��������� ��� ����������, ��������� � ���������
    nPAR1:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONNAME');
    nPAR2:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONAIM');


            --�������� ��� ������ � ������� ���. ���������� �� ���� ���������������� � ��������������� ����������
    /*
           --���������������� ������ �.� 17.12.2015
           --������� ������� ����� ��������� ������
           select T2.VS INTO nCODE
                  from
                     table (
                             REPORT_MANAGER.GenerateReport
                                                         (
                                                        vREPNAME,   -- ������� ������������ ������
                                                        vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                        )
                           ) T1,
                     table (
                            REPORT_MANAGER.GenerateReport
                                                     (
                                                    vREPNAME,   -- ������� ������������ ������
                                                    vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                    )
                        ) T2
             where T1.SNAME='TEXT' and
             --substr(T1.VS,0,instr( T1.VS,'(')-1)=upper(vFUNCAIM) and
                   T1.VS=upper(vFUNCAIM) and
                   T1.SN=T2.SN  and
                   T2.SNAME='CODE';
                   */

     for RETREP in (select *
                           from
                                 table (
                                         REPORT_MANAGER.GenerateReport
                                                                     (
                                                                    vREPNAME,   -- ������� ������������ ������
                                                                    vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                                    )
                                       ) T1
                   )
       loop
            if RETREP.SNAME ='TEXT' then nSTR:=RETREP.SN; end if;

            if nSTR=RETREP.SN and RETREP.SNAME ='TEXT' and RETREP.VS=vFUNCAIM
               then nSignForRetValue:=1;
            end if;

            if nSTR=RETREP.SN and RETREP.SNAME ='CODE' and nSignForRetValue=1
            then nCODE:=RETREP.VS;exit;
            end if;

       end loop;

            --��������� ���� ��������
                         select A_B88.B88MBID INTO nOPTP
                         from b88 A_B88,b88 B_B88
                            where
                            A_B88.b88mbst=102 and B_B88.b88mbst=102 AND
                            A_B88.b88mbid=B_B88.b88mbid and
                            A_B88.b88incd=nPAR1 and
                            A_B88.b88info=vFUNC and
                            B_B88.b88incd=nPAR2 and
                            B_B88.b88info=nCODE;

    EXCEPTION  WHEN OTHERS THEN nOPTP:=0;

    END;

    RETURN nOPTP;
END;
FUNCTION GET_INCD_BY_SHORTNAME (nOTYPE NUMBER,vSHORTNAME VARCHAR2)
RETURN NUMBER
IS
/*���������� �� ��������� ����� (vSHORTNAME)��������-������������� ������� (nOTYPE)*/
/*��� ��������������� ��������� ��� ���������� (b87incd,b88incd)*/
/*�����: ������ �.�*/
/*v. 1.0 �� (01.09.2014)*/

nRET NUMBER:=0;
BEGIN
    BEGIN
        SELECT P14TBID INTO nRET
        FROM P02,P14
        WHERE P02TPID=nOTYPE AND
             UPPER(P02SHNM)=UPPER(vSHORTNAME) AND
             P14APID=P02APID AND
             P14TYPE=-7;
    EXCEPTION WHEN others THEN nRET:=0;
    END;
RETURN nRET;
END;

FUNCTION get_list_of_faim_ (vFUNC NUMBER)
RETURN LIST_T
IS
/*������� ��������� ������ �������������� ���������� ��� �������� � ��������� ���������������*/
/*�����: ������ �.�*/
/*v. 1.0 �� (01.09.2014)*/

vREPNAME VARCHAR2(256);--������� ����� �� ������� �����������������
vPARAMSTR VARCHAR2(256);--��������� ������ � ���� '����������������=��� ����������������'

RET LIST_T:=LIST_T();
R LIST_REC;

BEGIN
    BEGIN
    vREPNAME:='+eg_ListOfFuncName';
    vPARAMSTR:='����������������='||vFUNC;

            --�������� ��� ������ � ������� ���. ���������� �� ���� ���������������� � ��������������� ����������
     FOR  REZ in  (select T2.VS as CODE,T1.VS as TEXT
                      from
                         table (
                                 REPORT_MANAGER.GenerateReport
                                                             (
                                                            vREPNAME,   -- ������� ������������ ������
                                                            vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                            )
                               ) T1,
                         table (
                                REPORT_MANAGER.GenerateReport
                                                         (
                                                        vREPNAME,   -- ������� ������������ ������
                                                        vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                        )
                            ) T2
                         where T1.SNAME='TEXT' and
                               T1.SN=T2.SN  and
                               T2.SNAME='CODE'
                    )
     LOOP
        RET.EXTEND(1);--��������� ��������� �� 1 �������
        R:=LIST_REC(REZ.CODE,REZ.TEXT,0);--�������� ���������� �������, ����� ������������ � �����������
        RET(RET.LAST):=R;--�������� ������� � ���������
     END LOOP;

    EXCEPTION  WHEN OTHERS THEN NULL;

    END;

    RETURN RET;
END;

FUNCTION get_list_of_faim (vFUNC NUMBER)
RETURN LIST_T
IS
/*������� ��������� ������ �������������� ���������� ��� �������� � ��������� ���������������*/
/*�����: ������ �.�*/
/*v. 2.0 �� (17.12.2015)*/

vREPNAME VARCHAR2(256);--������� ����� �� ������� �����������������
vPARAMSTR VARCHAR2(256);--��������� ������ � ���� '����������������=��� ����������������'

RET LIST_T:=LIST_T();
R LIST_REC;

BEGIN
    BEGIN
    --vREPNAME:='+eg_ListOfFuncName';
    --vPARAMSTR:='����������������='||vFUNC;
    vPARAMSTR:='FunctionName='||vFUNC;
            --�������� ��� ������ � ������� ���. ���������� �� ���� ���������������� � ��������������� ����������
/*
--���������������� ������ �.�. 17.12.2015 � ����� � ���������� ����������� �������
     FOR  REZ in  (select T2.VS as CODE,T1.VS as TEXT
                      from
                         table (
                                 REPORT_MANAGER.GenerateReport
                                                             (
                                                            vREPNAME,   -- ������� ������������ ������
                                                            vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                            )
                               ) T1,
                         table (
                                REPORT_MANAGER.GenerateReport
                                                         (
                                                        vREPNAME,   -- ������� ������������ ������
                                                        vPARAMSTR   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                                        )
                            ) T2
                         where T1.SNAME='TEXT' and
                               T1.SN=T2.SN  and
                               T2.SNAME='CODE'
                    )
                    */
      FOR  REZ in  (select T1.CODE as CODE,T1.TEXT as TEXT
                      from
                         table(TYPE_MANAGER. Attribute_GetPossibleValues(102,
                                                                         'FunctionAim',
                                                                         vPARAMSTR
                                                                           )
                               ) T1
                      )
     LOOP
        RET.EXTEND(1);--��������� ��������� �� 1 �������
        R:=LIST_REC(REZ.CODE,REZ.TEXT,0);--�������� ���������� �������, ����� ������������ � �����������
        RET(RET.LAST):=R;--�������� ������� � ���������
     END LOOP;

    EXCEPTION  WHEN OTHERS THEN NULL;

    END;

    RETURN RET;
END;
FUNCTION GET_FUNCNAME_BY_OPTP (nOPTP NUMBER,nVAR NUMBER)
RETURN NUMBER
IS
/*������� ���������� ��� ���������������� ��� ��������������� ���������� ������� �������� */
/*� ����������� �� �������� ��������� nVAR*/
/*nVAR=1 ����������������*/
/*nVAR=2 �������������� ����������*/
nPAR1 NUMBER;--��������� ���.���� � ����������� ������� FunctionName (����������������)
nPAR2 NUMBER;--��������� ���.���� � ����������� ������� FunctionAim (�������������� ����������)
nFUNCODE NUMBER;
nFUNAIM NUMBER;
nREZ NUMBER;
BEGIN
    BEGIN
    --�������� ��������� ��� ����������, ��������� � ���������
    nPAR1:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONNAME');
    nPAR2:=TUNING.GET_INCD_BY_SHORTNAME(102,'FUNCTIONAIM');
                    select t.nFUNCODE,t.nFUNAIM into nFUNCODE,nFUNAIM
                      from
                          (select
                                   A_B88.b88mbid as nMBID,
                                   A_B88.b88info as nFUNCODE,
                                   B_B88.b88info as nFUNAIM

                             from
                                 b88 A_B88,
                                 b88 B_B88

                                where
                                A_B88.b88mbid=nOPTP and
                                A_B88.b88mbst=102 and B_B88.b88mbst=102 AND
                                A_B88.b88mbid=B_B88.b88mbid and
                                A_B88.b88incd=nPAR1 and
                                B_B88.b88incd=nPAR2

                            ) t,
                            table(get_list_of_faim (t.nFUNCODE)) t1
                        where t.nFUNAIM=t1.CODE;
       EXCEPTION  WHEN OTHERS THEN nFUNCODE:=0;nFUNAIM:=0;
    END;
      CASE nVAR WHEN 1 THEN nREZ:=nFUNCODE;
                       ELSE nREZ:=nFUNAIM;
      END CASE;
    RETURN nREZ;
END;

FUNCTION RET_CODE_FR(vREPNAME VARCHAR2,vPARAM VARCHAR2)
RETURN VARCHAR2
IS
--������� ������������� ��� ������ �������� �������
--��������������, ��� ��������� ���������� ������ ������������ ��������, ������������� ��������� ���������� ������
--� ������ ��������������� - �������� ��������� ��������
--������ ������� 1.0 (12.08.2015)
vREZ VARCHAR2(256):='0';
BEGIN
    BEGIN
        FOR  REZ in  ( select T.SN as CODE from
                                   table (REPORT_MANAGER.GenerateReport
                                         (vREPNAME,   -- ������� ������������ ������
                                          vPARAM   -- ��������� ������ � ���� ���1=��������1;���2=��������2
                                          )
                                          ) T
                      )
        LOOP
        vREZ:=REZ.CODE;
        END LOOP;
            EXCEPTION  WHEN OTHERS THEN vREZ:='0';
    END;
RETURN nvl(vREZ,0);
END;


FUNCTION RETREZOBJECT(idob varchar2,obtype number) RETURN NUMBER
IS
--
-- �����: ���� �.�.
-- ������: 1.1 �� 17.11.2011
--
--������� ���������� ������������� �������
--���������� 1 ��� ���������, 0-�� ��������, -1 �� ����������
--idob ������ ��� ��� ���,obtype ��� �������
--��� ������: ���� obtype=105 - �� ���������, ��� idob - ��� ACNC �����, ���� obtype=106, �� ���������, ��� idob - ��� ACCN
--��� ���������� ���� obtype=300, �� idob ������������� ��� ������
--��� ���������� ���� obtype=301, �� idob ������������� ��� ������, �� ������� ������ ���� �������� ��������
--���� ��� ������, �� ������� ���������� 0
Rez number:=-1;
retacnc number:=0;
accn varchar2(256);
naccn number;--����� ����� ������ �������
val varchar2(20);
ctyp number;
xDESC varchar2(256);--���������� ��� ������ � ����������� �������� ���������
xDESC_STR varchar2(256);--���������� ��� ������ � ����������� �������� ���������
BEGIN
--NULL;
     case obtype
         when 8
         then
           select  decode (substr(n31clfl,3,1),'R',0,1) into Rez from n31 where n31clid=to_number(idob);
           return Rez;
         when 105
         then
            select  n67accn into ACCN from n67 where n67acnc=to_number(idob);
              if  (substr(ACCN,1,5)='40807' OR substr(ACCN,1,5)='40809' OR substr(ACCN,1,5)='40820' OR substr(ACCN,1,5)='42601' OR substr(ACCN,1,5)='42501')
                 then return 0;
              else
                     if (substr(ACCN,1,3)='426' OR substr(ACCN,1,3)='457' OR substr(ACCN,1,3)='425')
                       then return 0;
                       else return 1;
                     end if;
              end if;
         when 106
         then
              ACCN:=idob;
              if  (substr(ACCN,1,5)='40807' OR substr(ACCN,1,5)='40809' OR substr(ACCN,1,5)='40820'
               OR substr(ACCN,1,5)='30111' OR substr(ACCN,1,5)='30114' OR substr(ACCN,1,5)='30231'  OR substr(ACCN,1,5)='30122' OR substr(ACCN,1,5)='30123'
               OR substr(ACCN,1,5)='40803' OR substr(ACCN,1,5)='40804' OR substr(ACCN,1,5)='40805' OR substr(ACCN,1,5)='40806' OR substr(ACCN,1,5)='40812'
               OR substr(ACCN,1,5)='40813' OR substr(ACCN,1,5)='40814'  OR substr(ACCN,1,5)='40815' OR substr(ACCN,1,5)='40818' OR substr(ACCN,1,5)='30230')
                then return 0;
                else
                     if (substr(ACCN,1,3)='426' OR substr(ACCN,1,3)='316' OR substr(ACCN,1,3)='425' OR substr(ACCN,1,3)='440')
                       then return 0;
                       else return 1;
                     end if;
              end if;
         when 300
         then
              xDESC:=idob;
              xDESC:=REPLACE(REPLACE(xDESC,'.'),' ');--�������� ����� � ��������, ������� ����� �������������� � ������� ������ ������������
              xDESC_STR:=xDESC;--���������� ����� ��� �������� � ����� ��� ������������ �������
              xDESC:=(acc_desc(xDESC));--��������� ������������� �������� (����� ����� '^')
              xDESC:='^'||xDESC;    -- ��� �������� ������
             -- if  (instr(upper(idob),'����������')>0 OR instr(idob,'40807')>0 OR instr(idob,'40809')>0 OR instr(idob,'40820')>0
             --  OR instr(idob,'42501')>0 OR instr(idob,'42601')>0)
              if  (instr(upper(xDESC_STR),'����������')>0 OR instr(upper(xDESC_STR),'�����')>0
                    OR instr(upper(xDESC_STR),'����������')>0 OR instr(upper(xDESC_STR),'����������')>0
                    OR instr(xDESC,'^40807')>0 OR instr(xDESC,'^40809')>0 OR instr(xDESC,'^40820')>0
                    OR instr(xDESC,'^30111')>0 OR instr(xDESC,'^30114')>0 OR instr(xDESC,'^30231')>0
                    OR instr(xDESC,'^30122')>0 OR instr(xDESC,'^30123')>0
                    OR instr(xDESC,'^40803')>0 OR instr(xDESC,'^40804')>0 OR instr(xDESC,'^40805')>0
                    OR instr(xDESC,'^40806')>0 OR instr(xDESC,'^40812')>0
                    OR instr(xDESC,'^40813')>0 OR instr(xDESC,'^40814')>0 OR instr(xDESC,'^40815')>0
                    OR instr(xDESC,'^40818')>0 OR instr(xDESC,'^30230')>0
                    OR instr(xDESC,'^426')>0 or instr(xDESC,'^457')>0 or instr(xDESC,'^425')>0
                  )
              then return 0;
              else
                   return -1;
              end if;
         when 301
         then
              if  instr(idob,'{VO')>0
                then return 0;
                else return -1;

              end if;


         else return 1;
     end case;
 return -1;
 exception when others then return -1;
END;

FUNCTION ACC_DESC(xDESC VARCHAR2)
RETURN VARCHAR2
IS
xLen number;--����� ����������
xPos number;--������� ������� � ����������
sym varchar2(1);--������ � ������� �������
xAcc varchar2(21);--20-�� ������� ������������������ �������� ��������
xRet varchar2(256);--������������ ����� 20-�� ������� �������������������, ����������� �������� '^'

BEGIN
xLen:=LENGTH(xDESC);
 FOR xPos IN 1..xLen
    LOOP
       sym:=SUBSTR(xDESC,xPos,1);
          if ((sym='0' or sym='1' or sym='2' or sym='3' or sym='4' or sym='5' or sym='6' or sym='7' or
              sym='8' or sym='9' ) and nvl(LENGTH(xAcc),0)<=20)
              then
                  xAcc:=xAcc||sym;
                 --xRet:='0';
              else
                   xAcc:=null;
          end if;

          if LENGTH(xAcc)=20
             then
                  xRet:=xRet||xAcc||'^';
          end if;

    END LOOP;

    if xRet is not NULL
       then xRet:=RTRIM(xRet, '^');
     --  else xRet:='0'
    end if;
  return xRet;
END;

FUNCTION GET_OPTP_BY_OPID(xINOPID number,xP number default 0)
return number
IS
--������� ���������� ��� �������� ������������ �������� �� ���� �������� n01opid
--���� �������� ������� ��������� 1, �� � �������� ������������ �������� ���������������
--�������� �� ��������� parent_opid
--� ������ ������� - ���������� 0
--������ 1.0 (02.02.2011)
xOPID number;
xOPTP number;
BEGIN

    if (xP=1)
       then
           xOPID:=nvl(rparam.getparamn(xINOPID,'parent_opid'),0);
       else select n01prid into xOPID from n01 where n01opid=xINOPID;
     end if;

   select n01optp into xOPTP from n01 where n01opid=xOPID;
    return xOPTP;
exception when others then return 0;

END;

PROCEDURE CREATELINK_FOR_POT(SS IN out fcScriptState)
IS
OPID1 NUMBER;
ODDT1 DATE;
MBID NUMBER;--��� ������ ���
GRT LINK_T := LINK_T();--������� ������� � ������
DEFTYPELINK LINKDEF_T:= LINKDEF_T();--������� ������� � ������� ������
NEWOBID N20.n20obid%TYPE;--������������� ����� �����

ERR VARCHAR2(1000);
ERRD VARCHAR2(1000);
COMM VARCHAR2(256);--�����������
ACCN VARCHAR2(256);-- ����� �������
FIO VARCHAR2(256);--��� �������
EMID NUMBER;--������������� �������������
TFLAG BOOLEAN:=FALSE;--��������� ��������� �������� ������� �����
LEFT_ROLE NUMBER;
RIGHT_ROLE NUMBER;
BEGIN
OPID1:=SS.m_nOPID; -- �������� ��� ��������
ODDT1:=SS.m_dtODDT;--���� ��������
EMID:=SS.m_nEMID;-- ������������� �������������, ������������ ����

FOR OB1 IN (SELECT N02DCID AS DCID,N02DCTP AS DCTP, N02SDID AS SDID FROM N02 WHERE N02OPID=OPID1)--�������� ������-������ �������� �����
 LOOP

 IF TFLAG=FALSE
   THEN
       --�������� �������� ������� ����� ���� TL_POT ��� ���� ������� OB1.DCTP
        DEFTYPELINK:=OBJECT_LINK.GET_ROLE_BY_LINKTYPE(OB1.DCTP,TL_POT);
        TFLAG:=TRUE;
        --� ���������� ����� ���������, ��� ������� ������� ���� ����� ����������� � ������� ����� ���� ���
        --����� �������,DEFTYPELINK.COUNT ������ ���� 1;
        IF DEFTYPELINK.COUNT=0 OR DEFTYPELINK.COUNT>1
          THEN
          SS.m_sError:='������� ����� ��� ��� ��� �� ���������:��� ����� '||TO_CHAR(TL_POT)||'��� ������� '||TO_CHAR(OB1.DCTP);
          SERV.LOG('ERROR: ������� ����� ��� ��� ����� �� ���������. ��� �����'||TO_CHAR(TL_POT)||'��� ������� '||TO_CHAR(OB1.DCTP),'0','0','E','-999');
          RETURN;
        END IF;
               LEFT_ROLE:=DEFTYPELINK(DEFTYPELINK.FIRST).OWNER_ROLE;
               RIGHT_ROLE:=DEFTYPELINK(DEFTYPELINK.FIRST).MBST_ROLE;

   END IF;--TFLAG=FALSE

 --�������� ������ ������� ��������� ����� (����� ���)
 MBID:=TREE.GetList(TUNING.TREE_POT,OB1.DCID);--3 ��� �������� ������ ������
 IF (MBID IS NOT NULL) AND (MBID>0)
   THEN
    -- �������� �������� ������� ��������� (������� ���)
   GRT:=OBJECT_LINK.Get_Link_Collection(RCONST.STOBJ_ACCOUNT, OB1.DCID, TUNING.TL_POT, NULL, 1 ,ODDT1); -- ������ ����� ��� 1 �������
    --������ ������, ���� ���������� ��������� ����������� ������
     IF GRT.count>1 THEN SS.m_sError:='���������� ��������� ����������� ������ ��� ������� '||TO_CHAR(OB1.DCID); RETURN; END IF;


             SELECT N67ACCN INTO ACCN FROM N67 WHERE N67ACNC=OB1.DCID;
             SELECT REPORT.GetClientName(N30CLID,8) INTO FIO FROM N30 WHERE N30AGID=OB1.SDID;
             COMM:=ACCN||' '||FIO;
      IF GRT.count=1
         THEN
   --���� ������� ����� ������� OB1.DCID �� � �������� MBID, �� ������� ������������ ����� � ������� �����
         IF GRT(GRT.FIRST).MBID!=MBID
            THEN
             OBJECT_LINK.CLOSELINK (GRT(GRT.FIRST).OBID,ODDT1,null,ERR,ERRD);
             OBJECT_LINK.ADD_LINK(
                                  NEWOBID,
                                  DEFTYPELINK(DEFTYPELINK.FIRST).OBID,
                                  OB1.DCID,--������������� ���������
                                  OB1.DCTP,--��� ������� ��������� 105
                                  LEFT_ROLE,--���� ������� ��������� LEFT_ROLE
                                  MBID,--������������� ������� ���������
                                  RCONST.STOBJ_JURIDICAL,--��� ������� ��������� 109
                                  RIGHT_ROLE,--���� ������� ��������� 2
                                  ODDT1,--������ �������� N01ODDT
                                  NULL,--����� �������� NULL
                                  EMID,--������������� �������������
                                  COMM,--�����������
                                  1,--������ 1
                                  ERR,
                                  ERRD
                                  );
         -- SERV.LOG('ERROR: ACNC='||TO_CHAR(OB1.DCID),substr(ERR,1,1000),to_char(MBID),'E','-999');
         END IF;

      END IF;--  GRT.count=1

      IF GRT.count=0 -- �������� ����� �����
         THEN

             OBJECT_LINK.ADD_LINK(
                                  NEWOBID,
                                  DEFTYPELINK(DEFTYPELINK.FIRST).OBID,
                                  OB1.DCID,--������������� ���������
                                  OB1.DCTP,--��� ������� ��������� 105
                                  LEFT_ROLE,--���� ������� ��������� 1
                                  MBID,--������������� ������� ���������
                                  RCONST.STOBJ_JURIDICAL,--��� ������� ��������� 109
                                  RIGHT_ROLE,--���� ������� ��������� 2
                                  ODDT1,--������ �������� N01ODDT
                                  NULL,--����� �������� NULL
                                  EMID,--������������� �������������
                                  COMM,--�����������
                                  1,--������ 1
                                  ERR,
                                  ERRD
                                  );

      -- SERV.LOG('ERROR: ACNC='||TO_CHAR(OB1.DCID),substr(ERR,1,1000),to_char(MBID),'E','-999');
      END IF;
 END IF;--(MBID IS NOT NULL)
 END LOOP;--OB1
END;--CREATELINK

FUNCTION GETSUMREZ(PMBID NUMBER ,POPID NUMBER,PACGN NUMBER ) RETURN NUMBER
IS
RET NUMBER:=0;
PODDT DATE;

BEGIN
/*
SERV.LOG('��� ����� �������� POPID='||TO_CHAR(POPID1),0,0,'E','-999');
*/
 --�������� �� ������������ ��������� ����������
   IF (NVL(PMBID,0)=0 OR NVL(POPID,0)=0 OR NVL(PACGN,0)=0 )
     THEN RETURN 0;
   END IF;
  SELECT N01ODDT INTO PODDT FROM N01 WHERE N01OPID=POPID;
  --�������� ��� �����, ��� ���� �� ���������� ����� ��� 109 � ��� PMBID
  --������ �� ��������� � ����� PMBID �������� � ����� (OWID,OWST,OWRL,OWRL_NAME)
  --������ �� ���������������� ��������� � ����� ( MBID, MBST, MBST_NAME, MBRL,MBRL_NAME)
   SELECT SUM(SUMMA) INTO RET FROM
   (select ROUND(ABS(FIN.ACCREST(A.MBID,'O',PODDT))*COURSE.GETRATECB(N67ACRC,PODDT)*NVL(N69RZPR,FF.QN(N69RGRC))*(0.01),0) as SUMMA
   from n67,N69,
        table (OBJECT_LINK.GET_LINK_COLLECTION (RCONST.STOBJ_JURIDICAL, PMBID,TL_POT, NULL,1,PODDT)) A
        where A.MBST=RCONST.STOBJ_ACCOUNT and n67ACNC=A.MBID and N67ACGN=PACGN AND N69AGID=PMBID
        );

   RETURN NVL(RET,0);
END;--GETSUMREST

--$Author gpolyakov $
--����� ������� ������� �� N20
FUNCTION GetLnkN20(
                    LTYP N20.N20LTYP%TYPE,
                    OWNR N20.N20OWNR%TYPE,
                    OWST N20.N20OWST%TYPE,
                    MBST N20.N20MBST%TYPE
                  ) RETURN N20.N20MBID%TYPE
AS
  LMBID N20.N20MBID%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
          N20.N20MBID INTO LMBID
    FROM
          N20
    WHERE
          N20.N20LTYP=LTYP
          AND
          N20.N20OWNR=OWNR
          AND
          N20.N20OWST=OWST
          AND
          N20.N20MBST=MBST;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN LMBID;
END;
--$Author gpolyakov $
--������� ������ ������� ������� �� N20 �� ����������:
--���� ������� �������
--��������� �������� ��� ������� �������
--������ �������� ������� ������
--��� ������� �������
--��� ������� �������
--������������� ����������� ��������, ��� ������� ������� (� ������� ���� ������������� ����� �������)
FUNCTION GetLnkN20TM(
                    LTYP C01.C01LTYP%TYPE, --������������� ������� �����
                    MBRL N20.N20MBRL%TYPE, --���� ������� ������� � ���� ����������
                    CLID N30.N30CLID%TYPE, --�������� �������� ������� �������
                    CURC N30.N30CURC%TYPE, --������ �������� ������� �������
                    OWST N30.N30MBST%TYPE, --��� ������� �������
                    MBST N30.N30MBST%TYPE, --��� ������� �������
                    OWID N30.N30OWID%TYPE  --�������������
                   ) RETURN N20.N20OWNR%TYPE
AS
 --��������� ������� �������� ����� AND N20.N20STAT=1
  OWNR N20.N20OWNR%TYPE:=NULL;
BEGIN
  BEGIN
      SELECT
            N30.N30AGID INTO OWNR
      FROM
            N30
      WHERE
            N30.N30AGID IN (
                            SELECT
                                  N20.N20MBID AS MB
                            FROM
                                  N30
                                      INNER JOIN N20 ON N30.N30AGID=N20.N20OWNR AND N20.N20OWST=N30.N30MBST AND N20.N20STAT=1
                                      INNER JOIN C02 ON N20.N20LTYP=C02.C02OBID
                            WHERE
                                  N30.N30CURC=CURC
                                  AND
                                  N30.N30CLID=CLID
                                  AND
                                  N20.N20MBRL=MBRL
                                  AND
                                  C02.C02LTYP=LTYP
                                  AND
                                  N30.N30MBST=OWST
                                  AND
                                  (
                                    N30.N30OWID IN (
                                                    SELECT
                                                          T28OWID
                                                    FROM
                                                          T28
                                                    WHERE
                                                          T28PAR1=(SELECT T28PAR1 FROM T28 WHERE T28OWID=OWID)
                                                    )
                                    OR
                                    N30.N30OWID=OWID
                                  )
                            );
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END;
  RETURN OWNR;
END;
/*��������� ��������� �������*/
PROCEDURE SETOBJECTATTR(OBID NUMBER,MBST NUMBER,VAL VARCHAR2)
IS
  BEGIN
      TYPE_MANAGER.ChangeObjectAttributesValue(OBID,MBST,VAL);
  END;


--��������� ����� ��� �������� ������� � ������ � ������ ����������
FUNCTION GET_RATE_STR
  ( AGID IN number,
    RATE IN  number,
    RATE_NUM in number, --����� ������ �� �������� ��� ������������ �������������� ������
    desc1 varchar2 default '��������'
    )
  RETURN  varchar2 IS

    SUM_KRED number; --����� �������
    SUM_TARIFF_ALL number; --����� ������ �� ���� ������

    RATE_MON number;
    SUM_TARIFF_FACT number; -- ����� ������ �� ���� ����� ����� ����������
    SUM_TARIFF_MON number; -- ����� ������ �����������
    KOL_PER number; --���������� ��������
    FIRST_PAY_SUM number;
    FIRST_PAY_RATE number;
    CURC number;
    RATE1 varchar2(3000);
    RATE2 varchar2(3000);
    DTEF date;
    DTEX date;

    first_per_end date;

BEGIN
    SELECT
        n30mind, n30dtex,n30dtef,n30curc     INTO  SUM_KRED,DTEX,DTEF,CURC
    from
        n30
    where
        n30agid=AGID;

    Select
        count(n46fixd) into  KOL_PER
    from
        n46
    where
        n46agid=AGID and n46type=0;
    --KOL_PER:=round(MONTHS_BETWEEN(DTEX,DTEF));
    SUM_KRED:=SUM_KRED*COURSE.GetCRCF(CURC);

    FIRST_PAY_RATE:=0;
    FIRST_PAY_SUM:=0;
    SUM_TARIFF_ALL:=ROUND((SUM_KRED*RATE),2);
    SUM_TARIFF_MON:=ROUND((RATE*SUM_kred)/KOL_PER,2);
    SUM_TARIFF_FACT:=SUM_TARIFF_MON*kol_per;
    --first_per_end:=credit.GET_DEBTSFIX_DATE(agid,dtef+1,0,1)+1;

    select
        (min(n46fixd)+1) into first_per_end
    from
        n46
    where
        n46agid=AGID and n46type=0 and n46scde<1;



    IF SUM_TARIFF_ALL > SUM_TARIFF_FACT THEN
        FIRST_PAY_SUM:=(SUM_TARIFF_ALL-SUM_TARIFF_FACT)+SUM_TARIFF_MON;
    END IF ;
    if SUM_TARIFF_ALL < SUM_TARIFF_FACT THEN
        FIRST_PAY_SUM:=SUM_TARIFF_MON-(SUM_TARIFF_FACT-SUM_TARIFF_ALL);
    END IF;

    FIRST_PAY_SUM:=FIRST_PAY_SUM*100;

    SUM_TARIFF_MON:=SUM_TARIFF_MON*100;
    IF SUM_TARIFF_ALL = SUM_TARIFF_FACT and RATE_NUM=1 THEN
        RATE1:=to_char(dtef,'ddmmyyyy')|| '^0^'|| SUM_TARIFF_MON ||'^0^181^0^0^0^0^0^0^0^'|| to_char(dtex+1,'ddmmyyyy') ||'^'|| desc1 ;
    return RATE1;
    end if;
    IF SUM_TARIFF_ALL = SUM_TARIFF_FACT and RATE_NUM=2
        THEN return '';
    end if;

    IF RATE_NUM=1 and FIRST_PAY_SUM!=0 then
        RATE1:=to_char(dtef,'ddmmyyyy')|| '^0^'|| ABS(FIRST_PAY_SUM) ||'^0^181^0^0^0^0^0^0^0^'|| to_char(first_per_end,'ddmmyyyy') ||'^'|| desc1 ;
        return RATE1;
    end if;

    IF RATE_NUM=2 and FIRST_PAY_SUM!=0 then
        RATE2:=to_char(first_per_end+1,'ddmmyyyy')|| '^0^'|| SUM_TARIFF_MON ||'^0^181^0^0^0^0^0^0^0^'|| to_char(dtex+1,'ddmmyyyy') ||'^'|| desc1 ;
        return rate2;
    end if;



EXCEPTION
   WHEN others THEN
       return '' ;
END;

--������� ��������� ���� ������� �� id ����� � ���� �������
FUNCTION GetMbidByAcnc (nACNC n67.n67acnc%TYPE, nMBST n67.n67mbst%TYPE) RETURN NUMBER
IS
nResult   NUMBER;
BEGIN
   SELECT n67mbid INTO nResult
   FROM   n67
   WHERE  n67acnc=nACNC and
          n67mbst=nMBST;
RETURN nResult;
EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0;
END;

--$Author gpolyakov $
--��������� ��� �� ���� BNCD �� T70
FUNCTION fncGetBIK_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BBIK%TYPE
AS
  BBIK T70.T70BBIK%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
         T70.T70BBIK INTO BBIK
    FROM
          T70
    WHERE
         T70.T70BNCD=BNCD;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN BBIK;
END;
--$Author gpolyakov $
--��������� ������������ ����� �� ���� BNCD �� T70
FUNCTION fncGetBNNM_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BNNM%TYPE
AS
  BNNM T70.T70BNNM%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
         T70.T70BNNM INTO BNNM
    FROM
          T70
    WHERE
         T70.T70BNCD=BNCD;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN BNNM;
END;
--$Author gpolyakov $
--��������� �������� ����� �� ���� BNCD �� T70
FUNCTION fncGetBKAC_T70(BNCD T70.T70BNCD%TYPE) RETURN T70.T70BKAC%TYPE
AS
  BKAC T70.T70BKAC%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
         T70.T70BKAC INTO BKAC
    FROM
          T70
    WHERE
         T70.T70BNCD=BNCD;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN BKAC;
END;

/*��������� ������� ���� N30APNX ����� ���������� �� ��������� ����� ��������, �� ������ ������������� ������.*/
PROCEDURE plsql_upd_apnx(p_SS IN OUT fcScriptState,
    nTREE_ID  IN NUMBER,
    sREPORT_NAME IN VARCHAR2,
    nMODE in NUMBER default 0
    )
    IS
-- v2.0.3 (23.01.2012)
--23.01.2012
--���� ��������� �������� "����� �� ��������" (nTypicalKVOID=1),
--� � ��������, �� ������ �����������, ���������� ������� "��������", ��
--�������� "��������" (n30apnx) �� ������������� � 0.
--����� ���������� ��������, �����������, ���� �� ������ �������� ��������
--��� �������������� ��������� ��������, �� ����� � ������� �������� �������� "�����������" �� "��������"
--21.04.2011
-- ���������� ��������� � ������� (AGREE.DETECTPROLONGDATEEXP (nAPNX,dDTEF,NULL, dPDATE)
--�� (AGREE.DETECTPROLONGDATEEXP (nAPNX,dDTEF,dDTEX, dPDATE)
--25.04.2011
--����� agree ������ ���� ������ "2.08.0128 (01.04.2011)"
--������� ����� ������� AGREE.DETECTPROLONGDATEEXP(nAPNX,dDTEF,dDTEX, dPDATE)
--�� AGREE.DETECTPROLONGDATEEXP(nAPNX,dDTEF,dDTEX, dPDATE,null,1)
--1 ��������, ��� ���� ����� ������ ����� ����� �� ��� � � ��������������� ��������

RepCLOB CLOB;
--ClassOrder TYPICAL_BANK_ORDER_REC;
p_sReportParams VARCHAR2(2000);
ReportParameters REPORT_MANAGER.PARAMETERS_ROW_TABLE;
RowResult REPORT_MANAGER.RESULT_ROW;
sErr VARCHAR2(32000);
sErrParams VARCHAR2(32000);
sIndex VARCHAR2(200);
sInputParamString VARCHAR2(4000);
sNameAP VARCHAR2(32);
sValueAP VARCHAR2(2000);
sMANP VARCHAR2(32000);
sMANV VARCHAR2(32000);
PRP REPORT_MANAGER.PARSING_REPORT_PROCESS;
nRes NUMBER;
ReportParametersListT LIST_T := LIST_T();
nTypicalKVOID NUMBER;
sStrParam   SERV.STR_ARRAY;
nParamCount NUMBER;
sStrValue   SERV.STR_ARRAY;
nValueCount NUMBER;
nAPNX NUMBER;
nSEID NUMBER; -- �� ������������� ���������
nAGID NUMBER; --�� ��������
nAGTP NUMBER;-- �� �������� �� ��������
nRAGC NUMBER;-- �� ����������� �������� ��� ����������
dDTEF DATE; -- ���� ������ �������� (��������� �����������) ��������
dDTEX DATE; -- ���� ����� ��������
dPDATE DATE; -- ���� �����������

nRewCount NUMBER:=0;--����� ������������ ��������������

FUNCTION GetInputParamString(
    p_ReportParameters REPORT_MANAGER.PARAMETERS_ROW_TABLE
)
RETURN VARCHAR2
IS
    sRet VARCHAR2(4000);
    sVal VARCHAR2(4000);
    sIndex VARCHAR2(200);
BEGIN
    sRet := NULL;
    sIndex := p_ReportParameters.FIRST;
    LOOP
        EXIT WHEN sIndex IS NULL;
        sRet := sRet || p_ReportParameters(sIndex).NAME || '=';
        sVal := NULL;
        FOR nInd IN 0..p_ReportParameters(sIndex).Vals.COUNT - 1 LOOP
            IF sVal IS NULL THEN
                sVal := p_ReportParameters(sIndex).Vals(nInd);
            ELSE
                sVal := sVal || ',' || p_ReportParameters(sIndex).Vals(nInd);
            END IF;
        END LOOP;
        sRet := sRet || sVal || '^';
        sIndex := p_ReportParameters.NEXT(sIndex);
    END LOOP;
    RETURN sRet;
END;

    BEGIN

 p_sReportParams:='OPID='||to_char(p_SS.m_nOPID);

/*serv.log('OPID= '||to_char(p_SS.m_nOPID)||' OPTP= '||to_char(p_SS.m_nOPTP)||' ����� ����������= '||to_char(p_SS.m_nGRFL)||' start= '||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'),
'��������� �����: nTREE_ID='||to_char(nTREE_ID)||' sREPORT_NAME='||sREPORT_NAME||' nMODE= '||nMODE,'','0',-777777);*/
--�����, ���� ��� ��������������
IF p_SS.m_nGRFL=0
  THEN RETURN;
END IF;
RepCLOB := REPORT_MANAGER.GenerateReport2XML(sREPORT_NAME, p_sReportParams).GetClobVal();

   -- ������������� ������� ������
    REPORT_MANAGER.InitReportResult(sREPORT_NAME, RepCLOB, ReportParameters, PRP);

    -- �������� ������������ ������� ������� ������

    sInputParamString := GetInputParamString(ReportParameters);

    ReportParametersListT := REPORT_MANAGER.GetParsedReportParams(PRP.ReportParameters, 1);
     -- ������ ����������� ������ ������
     LOOP
        nRes := REPORT_MANAGER.GetReportResultRow(PRP, RowResult);

        EXIT WHEN nRes = 0;

        sMANP := NULL;
        sMANV := NULL;
        sNameAP := RowResult.FIRST;

        LOOP
            EXIT WHEN sNameAP IS NULL;
            -- ���� ����� �������� ������������� ��������� ��� ������ �� ������
            sValueAP := RowResult(sNameAP).Value;

            sMANP := sMANP || sNameAP || '^';
            sMANV := sMANV || sValueAP || '^';
            -- ����� ������
            sNameAP := RowResult.NEXT(sNameAP);

        END LOOP;
             -- ����� �������
        nTypicalKVOID := TREE.GetList(nTREE_ID, sMANP, sMANV);
--        serv.log('REPORT_NAME= '||sREPORT_NAME,' nTypicalKVOID= '|| nTypicalKVOID,'','9',-777777);
        IF NVL(nTypicalKVOID,-1) != -1
        THEN   -- �� NULL ��� -1(�� ����������)
  --      serv.log(sMANP,sMANV||'���= '||to_char(nTypicalKVOID),'1','7',-777777);
         nParamCount:=serv.TOKENIZE(sMANP,'^',sStrParam);
         nValueCount:=serv.TOKENIZE(sMANV,'^',sStrValue);

         FOR N IN 0 .. nParamCount-1
            LOOP

                IF sStrParam(N)='SEID'
                  THEN nSEID:=TO_NUMBER(sStrValue(N));
                END IF;

                IF sStrParam(N)='AGID'
                  THEN nAGID:=TO_NUMBER(sStrValue(N));
                END IF;

                IF sStrParam(N)='AGTP'
                  THEN nAGTP:=TO_NUMBER(sStrValue(N));
                END IF;

            END LOOP;

--       serv.log('nSEID='||nSEID||' nAGID='||nAGID||' nAGTP='||nAGTP,'','1','7',-777777);
         --������� ���-�� ������������ �������
         nRewCount:=nRewCount+1;

          --������ ���������� �������� � ���������� ��������� n30apnx ��� ������
          BEGIN
          -- ���������� ������� ��� �����������, ��������� � ��������
          nRAGC:=AGREE.GET_PARAM_DEPOSIT(nAGTP).t32ragc;
          -- ���� ������ �������� (��������� �����������) ��������
          dDTEF:=AGREE.GET_AGREE_BY_AGID(nAGID).n30DTEF;
          -- ���� ����� ��������
          dDTEX:=AGREE.GET_AGREE_BY_AGID(nAGID).n30DTEX;
          -- ���� �����������
          dPDATE:=p_SS.m_dtODDT;

          nAPNX:=AGREE.GET_AGREE_BY_AGID(nAGID).n30apnx;

              IF nAPNX is NULL THEN nAPNX:=-8; END IF;-- �������� -8 ������� ��������� ������, ��� ����� ������� NULL
                 RPARAM.SetParamExN( p_SS.m_nOPID,nSEID, p_SS.m_nPHID ,'prev_apnx' ,nAPNX );
         serv.log('nTypicalKVOID='||nTypicalKVOID||'nRAGC= '||nRAGC,'','1','7',-777777);
         serv.log(AGREE.DETECTPROLONGDATEEXP (nRAGC,dDTEF,dDTEX, dPDATE,null,1),dPDATE,'1','7',-777777);
          CASE nTypicalKVOID
           WHEN 1 --�� ��������
           THEN
              -- serv.log('PROLONG='||RPARAM.getparams(nSEID,'PROLONGDATE_N02')||'nRAGC= '||nRAGC,'','1','7',-777777);
              -- serv.log('DETECT='||AGREE.DETECTPROLONGDATEEXP (nRAGC,dDTEF,dDTEX, dPDATE,null,1)||'nRAGC= '||nRAGC,'','1','7',-777777);
              -- serv.log('DATE='||dPDATE||'nRAGC= '||nRAGC,'','1','7',-777777);
               IF (nRAGC IS NOT NULL AND nRAGC!=0)--���� �� ��������
                 THEN --����������� ��� �������������� �� �������

                     IF (AGREE.DETECTPROLONGDATEEXP (nRAGC,dDTEF,dDTEX, dPDATE,null,1)=dPDATE
                     and RPARAM.getparams(nSEID,'PROLONGDATE_N02') is null)  --����������� �� ��������

                        THEN --��������
                             UPDATE N30 SET N30APNX=0 WHERE N30AGID=nAGID;
                         ELSE --����������� ��� ��������������
                              UPDATE N30 SET N30APNX=nRAGC WHERE N30AGID=nAGID;
                      END IF;
               ELSE
                     IF (nRAGC IS NOT NULL AND nRAGC=0) -- ���� � �������� �������� ����� ��������
                        THEN
                             UPDATE N30 SET N30APNX=nRAGC WHERE N30AGID=nAGID;
                     END IF;
               END IF;

           WHEN 2 --�� ��������
           THEN
               IF (nAPNX IS NOT NULL AND nAPNX!=0)--���� �� �� �������� � �� ��������
                 THEN --����������� ��� �������������� �� �������
                     IF (AGREE.DETECTPROLONGDATEEXP (nAPNX,dDTEF,dDTEX, dPDATE,null,1)=dPDATE
                     and RPARAM.getparams(nSEID,'PROLONGDATE_N02') is null) --����������� �� ��������
                        THEN --��������
                             UPDATE N30 SET N30APNX=0 WHERE N30AGID=nAGID;
                         ELSE --����������� ��� ��������������
                              UPDATE N30 SET N30APNX=n30APNX WHERE N30AGID=nAGID;
                      END IF;
               END IF;

               IF (nAPNX IS NULL)--���� �� ��������
                 THEN --����������� ��� �������������� �� �������
                     IF (AGREE.DETECTPROLONGDATEEXP (nRAGC,dDTEF,dDTEX, dPDATE,null,1)=dPDATE
                     and RPARAM.getparams(nSEID,'PROLONGDATE_N02') is null ) --����������� �� ��������
                        THEN --��������
                             UPDATE N30 SET N30APNX=0 WHERE N30AGID=nAGID;
                         ELSE --����������� ��� ��������������
                              UPDATE N30 SET N30APNX=n30APNX WHERE N30AGID=nAGID;
                      END IF;
               END IF;
               IF (nAPNX=0) THEN null; END IF;

           WHEN 3 --��������
           THEN
               UPDATE N30 SET N30APNX=0 WHERE N30AGID=nAGID;
           WHEN 4 -- �����������
           THEN
                IF (AGREE.DETECTPROLONGDATEEXP (nAGTP,dDTEF,dDTEX, dPDATE,null,1)=dPDATE
                and RPARAM.getparams(nSEID,'PROLONGDATE_N02') is null) --����������� �� ��������
                        THEN --��������
                             UPDATE N30 SET N30APNX=0 WHERE N30AGID=nAGID;
                         ELSE --����������� ��� ��������������
                              UPDATE N30 SET N30APNX=N30AGTP WHERE N30AGID=nAGID;

               END IF;

           ELSE NULL;
           END CASE;

            COMMIT;
         EXCEPTION WHEN OTHERS THEN serv.log('ERR='||nAPNX,'','1','7',-777777); NULL;
          END;
       END IF;
     END LOOP;

/*serv.log('OPID= '||to_char(p_SS.m_nOPID)||' OPTP= '||to_char(p_SS.m_nOPTP)||' ����� ������������ ����������= '||to_char(nRewCount)||' finish= '||to_char(sysdate,'dd-mm-yyyy hh24:mi:ss'),
'��������� �����: nTREE_ID='||to_char(nTREE_ID)||' sREPORT_NAME='||sREPORT_NAME||' nMODE= '||nMODE,'','0',-777777);*/
exception when others then
                           begin
                                rollback;
                                p_SS.m_sErrorParams :=
'OPID= '||to_char(p_SS.m_nOPID)||' OPTP= '||to_char(p_SS.m_nOPTP)
||' ����� ������������ ����������= '
||to_char(nRewCount)||'��������� �����: nTREE_ID='
||to_char(nTREE_ID)
||' sREPORT_NAME='
||sREPORT_NAME
||' nMODE= '
||nMODE;
                                p_SS.m_sError := 'ERORR';
                           end;
END;

/*����� ��������� plsql_upd_apnx*/
PROCEDURE plsql_rolb_upd_apnx(p_SS IN OUT fcScriptState)
    IS
    --
nAPNX number;
BEGIN
    FOR D IN (SELECT N02SEID,N02DCID FROM N02 WHERE N02OPID=p_SS.m_nOPID)
       loop
       nAPNX:=RPARAM.GetParamExN(D.N02SEID,p_SS.m_nPHID,'prev_apnx');
        IF nAPNX IS NOT NULL
          THEN
              IF nAPNX = -8 THEN nAPNX:=NULL; END IF;
               update n30 set n30apnx=nAPNX where n30agid=D.N02DCID;
       END IF;
       end loop;
END;

/*������� ������ ���� �������� ���������� �����*/
FUNCTION GetLinkAgid (
  nAGID n67.n67mbid%TYPE,
  nACGN n67.n67acgn%TYPE)
RETURN NUMBER
IS
nResult   NUMBER;
BEGIN
      SELECT N67MBID INTO nResult
        FROM
        (SELECT * FROM N32 WHERE N32AGID=nAGID AND N32ACGN=nACGN)
          JOIN N67 ON N67ACNC=N32ACNC AND N67ACRC=N32ACRC;
RETURN nResult;
EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0;
END;

/*������� ��� ������������� � ���������������� ������������� ��������� ��� ���������� ��������������� ������
������������� ��������.*/
FUNCTION GET_MF_ACNC
(
nSEID N02.N02SEID%TYPE, --��� ������������� ���������
nCURC N30.N30CURC%TYPE, --��� ������ ��������
sACCT VARCHAR2,         --�������� ����������� ����� ��� ����� ��������. ����� ������� �� ��������� �� �������������
                        --����������� ��������� sACCT
                        --������ �������� ������ ��������� ����� ���� ��������  2- 30302 - �������� ����
                        --                                                      1- 30301 - ��������� ����
                        --������ ������ ��������� ������ ��� �������� ����������� F - ������
                        --                                                        G - ������
                        --������ ������ ��������� �� �������� ���� ��� ������    D - �� ��������� �������
                        --                                                       S - ���. ������
nPACGN NUMBER DEFAULT 178,--��� ���������� ����� ���������� �����
nAACGN NUMBER DEFAULT 179--��� ���������� ����� ��������� �����

)
 RETURN NUMBER
 IS
 nResult   NUMBER;
 BEGIN
 SELECT DISTINCT
         CASE  WHEN sACCT='2FD' THEN REPORT.GetAgreementAccountID(JD.N30AGID,nAACGN,JD.N30CURC)
              WHEN sACCT='1FD' THEN REPORT.GetAgreementAccountID(JD.N30AGID,nPACGN,JD.N30CURC)
              WHEN sACCT='2GD' THEN REPORT.GetAgreementAccountID(JGD.N30AGID,nAACGN,JGD.N30CURC)
              WHEN sACCT='1GD' THEN REPORT.GetAgreementAccountID(JGD.N30AGID,nPACGN,JGD.N30CURC)
              WHEN sACCT='2GS' THEN REPORT.GetAgreementAccountID(JGS.N30AGID,nAACGN,JGS.N30CURC)
              WHEN sACCT='1GS' THEN REPORT.GetAgreementAccountID(JGS.N30AGID,nPACGN,JGS.N30CURC)
              WHEN sACCT='2FS' THEN REPORT.GetAgreementAccountID(JS.N30AGID,nAACGN,JS.N30CURC)
              WHEN sACCT='1FS' THEN REPORT.GetAgreementAccountID(JS.N30AGID,nPACGN,JS.N30CURC)
              ELSE 0
        END ACC INTO nResult
  FROM
    (SELECT *
      FROM N02 WHERE N02SEID=nSEID)
        /*LEFT JOIN N30 FD ON FD.N30AGID=N02DCID AND FD.N30MBST=N02DCTP AND FD.N30MBST=101
        LEFT JOIN N30 FS ON FS.N30AGID=N02SDID AND FS.N30MBST=N02SDTP AND FS.N30MBST=101*/

        LEFT JOIN (SELECT N30.*
                      FROM N30,T31
                        WHERE N30AGTP=T31AGRC AND T31BACP=7 AND T31MBST=109 AND N30MBST=109
                  ) JD ON JD.N30OWID=N02DWID AND JD.N30MBST=109 AND JD.N30CURC=nCURC

        LEFT JOIN (SELECT N30.*
                      FROM N30,T31
                        WHERE N30AGTP=T31AGRC AND T31BACP=7 AND T31MBST=109 AND N30MBST=109
                  ) JS ON JS.N30OWID=N02SWID AND JS.N30MBST=109 AND JS.N30CURC=nCURC

        LEFT JOIN (SELECT D.T28OWID AS T28OWID,
                          R.T28JPID AS T28JPID
                      FROM T28 D, T28 R
                        WHERE D.T28PAR1=R.T28OWID AND R.T28OWST<=131
                  ) PD ON PD.T28OWID=N02DWID

        LEFT JOIN (SELECT D.T28OWID AS T28OWID,
                          R.T28JPID AS T28JPID
                      FROM T28 D, T28 R
                        WHERE D.T28PAR1=R.T28OWID AND R.T28OWST<=131
                  ) PS ON PS.T28OWID=N02SWID

        LEFT JOIN (SELECT N30.*
                      FROM N30,T31
                        WHERE N30AGTP=T31AGRC AND T31BACP=7 AND T31MBST=109 AND N30MBST=109
                  ) JGD ON JGD.N30CLID=PD.T28JPID AND JGD.N30MBST=109 AND JGD.N30CURC=nCURC

        LEFT JOIN (SELECT N30.*
                      FROM N30,T31
                        WHERE N30AGTP=T31AGRC AND T31BACP=7 AND T31MBST=109 AND N30MBST=109
                  ) JGS ON JGS.N30CLID=PS.T28JPID AND JGS.N30MBST=109 AND JGS.N30CURC=nCURC;
RETURN nResult;
EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0;
END;
/*������� ����������� ������� � ������� ��������� � ������ ��������� �������� ����
  ����� ������� ����� ������������ � �������� ��������� 1 - ����� ����; 0 - ������ ���*/
FUNCTION EXIST_FREE_LINK_AGID (
  nAGID N30.N30AGID%TYPE, --��� �������� ��� �������� ���������� ������� ��������� ��������� ������
  nPAGT T31.T31PAGT%TYPE  --��� �������� �������� � ������ �������� ��������� ���������� ������� ��������� ��������� ������
                              ) RETURN NUMBER
  IS
  nResult NUMBER;

BEGIN
  SELECT CASE WHEN NVL(CNT,0) > 0 THEN 1 ELSE 0 END INTO nResult
    FROM(
          SELECT COUNT(*) CNT
            FROM
              ((SELECT * FROM N30
                  WHERE N30AGID = nAGID
                        AND N30MBST=101
              ) D
                INNER JOIN (SELECT *
                              FROM N30,T31
                                WHERE T31PAGT=nPAGT
                                      AND T31AGRC=N30AGTP
                                      AND N30MBST=101
                                      AND N30SCDE=1
                                  ) S ON  S.N30CLID=D.N30CLID
                                          AND S.N30CURC=D.N30CURC
                                          AND S.N30AGID<>D.N30AGID
                                          AND S.N30OWID=D.N30OWID
                INNER JOIN N67 ON N67MBID=S.N30AGID AND N67MBST=101 AND N67ACGN=1 AND N67ACST=1
                LEFT JOIN N32 ON N67ACNC=N32ACNC AND N32AGID <> S.N30AGID
              )WHERE N32ACNC IS NULL
            );
RETURN nResult;
EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0;
END;

/* ����������� ���� ������ �������� ������ */

PROCEDURE update_n38tssd(p_SS IN OUT fcScriptState)
    IS

BEGIN
   FOR D IN (SELECT N02DCID FROM N02 WHERE N02OPID=p_SS.m_nOPID)
       loop
             update n38 set n38tssd=p_SS.m_dtODDT  where n38agid=D.N02DCID and n38tspc=2;
       end loop;


END;
/*������� ���������� ������������ ����������� �������� �� ���� ��������*/
FUNCTION GET_T31BPRN(nAGRC T31.T31AGRC%TYPE)
RETURN VARCHAR2
IS
sResult VARCHAR2(250);
BEGIN
  IF NVL(nAGRC,0) > 0
    THEN sResult := SUBSTR(UPPER(AGREE.GETPRODUCT(nAGRC).T31BPRN),1,250);
  ELSE sResult := ' ';
  END IF;
RETURN sResult;
END;

/*������� ���������� ��� �������� �������� ���� ���� �� ���� ��������*/
FUNCTION GET_T31PAGT(nAGRC T31.T31AGRC%TYPE)
RETURN NUMBER
IS
nResult NUMBER;
BEGIN
  IF NVL(nAGRC,0) > 0
    THEN nResult := NVL((AGREE.GETPRODUCT(nAGRC).T31PAGT),0);
  ELSE nResult := 0;
  END IF;
RETURN nResult;
END;

/*������� ������������� ��� ������������� � ���������� ��������� �������� � ��������� ��� �������� �� ���������
���������� ���������� ������ �� �������� � ��������� ����*/
FUNCTION GET_RATE_DESC
(
 P_AGTP N30.N30AGTP%TYPE,                 -- ������������� ����������� ��������
 P_ACGN N67.N67ACGN%TYPE,                 -- ������������� ���������� ����� �ר��
 P_CURC N67.N67ACRC%TYPE DEFAULT NULL,    -- ��� ������ �ר��
 P_DTEF IN DATE DEFAULT NULL,             -- ���� ������ �������� ��������
 P_DTEX IN DATE DEFAULT NULL,             -- ���� ��������� �������� ��������
 P_FOR_DATE DATE DEFAULT DIVISION.OperDate+1,  -- ���� �� ������� ����� ���������� ������
 P_AGREE_SUM NUMBER DEFAULT 0,            -- ����� ��������������� ������
 P_EARL_TEREM NUMBER DEFAULT 0,           -- ������� ���������� ����������� ��������
 P_EARL_TEREM_DATE DATE DEFAULT DIVISION.OperDate+1, --���� � ������� �������������� ����������� �������
 P_SPEC_RATE_FLAG NUMBER DEFAULT 0,       -- ������� ���������� ������ ��� ��������� ����������� ����� - SpecialReducedInterestRate
 P_SPEC_RATE_TREE NUMBER DEFAULT 0,       -- ��� ������ � ������� ������ ���������� ������ ��� ��������� �����������
 P_OPTIONS VARCHAR2 DEFAULT NULL          -- ����� ����������� �������� � ��������������� ���� <BANKPRODUCT_OPTIONS><��� �����1>�������� �����1</��� �����1><��� �����2>�������� �����2</��� �����2>...</BANKPRODUCT_OPTIONS>
)
RETURN VARCHAR2
IS
 RET VARCHAR2(254);
 nINSC NUMBER:=NULL;
 nEXPC NUMBER:=0;
 nTSPC NUMBER:=1;
BEGIN
  BEGIN
    IF  P_EARL_TEREM = 1
      THEN nEXPC := 1;
        IF P_SPEC_RATE_FLAG = 0
          THEN  RET := INTEREST.RATE_AGTP_ACGN_DESC(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_OPTIONS);
        ELSE  nINSC := TREE.GETLIST(P_SPEC_RATE_TREE,'CURC',P_CURC);
              RET := INTEREST.RATE_AGTP_ACGN_DESC(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_OPTIONS);
        END IF;
    ELSE  RET := INTEREST.RATE_AGTP_ACGN_DESC(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_OPTIONS);
    END IF;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
 END;
 RETURN RET;
END;

/*������� ������������� ��� ������������� � ���������� ��������� �������� � ��������� ��� �������� �� ���������
���������� ���������� ������ �� ��������*/
FUNCTION GET_RATE
(
 P_AGTP N30.N30AGTP%TYPE,                 -- ������������� ����������� ��������
 P_ACGN N67.N67ACGN%TYPE,                 -- ������������� ���������� ����� �ר��
 P_CURC N67.N67ACRC%TYPE DEFAULT NULL,    -- ��� ������ �ר��
 P_DTEF IN DATE DEFAULT NULL,             -- ���� ������ �������� ��������
 P_DTEX IN DATE DEFAULT NULL,             -- ���� ��������� �������� ��������
 P_FOR_DATE DATE DEFAULT DIVISION.OperDate+1,  -- ���� �� ������� ����� ���������� ������
 P_AGREE_SUM NUMBER DEFAULT 0,            -- ����� ��������������� ������
 P_EARL_TEREM NUMBER DEFAULT 0,           -- ������� ���������� ����������� ��������
 P_EARL_TEREM_DATE DATE DEFAULT DIVISION.OperDate+1, --���� � ������� �������������� ����������� �������
 P_SPEC_RATE_FLAG NUMBER DEFAULT 0,       -- ������� ���������� ������ ��� ��������� ����������� ����� - SpecialReducedInterestRate
 P_SPEC_RATE_TREE NUMBER DEFAULT 0,       -- ��� ������ � ������� ������ ���������� ������ ��� ��������� �����������
 P_FLAG NUMBER DEFAULT 0,                 -- 0 - ������� ���������� ������, 1 - ������� ����������� �����, 2 - ������� ���������� ������, ��� ��������� �������, 3 - ������� ��������
 P_OPTIONS VARCHAR2 DEFAULT NULL          -- ����� ����������� �������� � ��������������� ���� <BANKPRODUCT_OPTIONS><��� �����1>�������� �����1</��� �����1><��� �����2>�������� �����2</��� �����2>...</BANKPRODUCT_OPTIONS>
)
RETURN NUMBER
IS
 RET NUMBER;
 nINSC NUMBER:=NULL;
 nEXPC NUMBER:=0;
 nTSPC NUMBER:=1;
BEGIN
  BEGIN
    IF  P_EARL_TEREM = 1
      THEN nEXPC := 1;
        IF P_SPEC_RATE_FLAG = 0
          THEN  RET := INTEREST.RATE_AGTP_ACGN(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_FLAG,P_OPTIONS);
        ELSE  nINSC := TREE.GETLIST(P_SPEC_RATE_TREE,'CURC',P_CURC);
              RET := INTEREST.RATE_AGTP_ACGN(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_FLAG,P_OPTIONS);
        END IF;
    ELSE  RET := INTEREST.RATE_AGTP_ACGN(P_AGTP,P_ACGN,P_CURC,P_DTEF,P_DTEX,P_FOR_DATE,P_AGREE_SUM,nINSC,nEXPC,nTSPC,P_FLAG,P_OPTIONS);
    END IF;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
 END;
 RETURN RET;
END;
/*������� ������������ ���� ������� � �������� ������ �����*/
FUNCTION IS_OPTIONS (nAGID N30.N30AGID%TYPE)
RETURN NUMBER
IS
nResult NUMBER;
BEGIN
  BEGIN
     SELECT NVL2(P02TPID,1,0) INTO nResult
      FROM
       (SELECT * FROM N30 WHERE N30AGID=nAGID AND N30MBST=101)
          INNER JOIN T31 ON T31AGRC=N30AGTP AND T31MBST=101
          LEFT JOIN P02 ON P02TPID=T31TPID AND P02EXPR='BANKPRODUCT_OPTIONS';
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
  END;
RETURN nResult;
END;

/*���������� ��� �������� ��.���� �� ���������� �����������*/
FUNCTION GetN44agid(CMPC N30.N30CMPC%TYPE)
RETURN
N44.N44AGID%TYPE
IS
    p_N44agid N44.N44AGID%TYPE;
BEGIN
        Select n44agid into p_N44agid from n44 where n44mbid=CMPC;
        return p_N44agid;
    EXCEPTION WHEN others THEN RETURN 0;
END;

/*���������� ����� ������� �� �������� (PAGID) ��� �������� ������������� (PCODE) � ������ ������ �������������� (PROZ)*/
FUNCTION GetRezForDebt(PAGID NUMBER,POPID NUMBER,ADT DATE,PCODE NUMBER) RETURN NUMBER
IS
RET NUMBER:=0;
DT DATE;
PROZ NUMBER:=0;
BEGIN
    DT:=TRIM(ADT);
    IF PCODE IS NULL THEN RETURN 0; END IF;
    IF DT IS NULL THEN DT:=FF.GODDT; END IF;
    /*�������� �� ����� ������� �������� ������ �������������� �� ����*/
    --select N69RZPR*0.01 INTO PROZ from h_n69 where n69htid=object_history.Get_HTID_On_Date(PAGID,101,DT);
    SELECT N69RZPR*0.01 INTO PROZ from n69 where N69AGID=PAGID;
    SELECT SUM(SUMMA) INTO RET FROM (
    SELECT L.BALANS*COURSE.GETRATECB(N30CURC,DT)*PROZ AS SUMMA
    FROM N30,TABLE(AGREE.get_eldebtcollection(NULL,N30AGID,NULL,PCODE,DT,1)) L
    WHERE  n30agid=PAGID
    );
    RETURN RET;
    EXCEPTION WHEN others THEN RETURN 0;
END;

/*������� ��� ��������� ������ � �������� ���������� �������� ���.�������������� ����� MIND � ������ �� ����� ��������*/
FUNCTION DESC_PROD_PARAM
(
nAGRC T31.T31AGRC%TYPE,--��� ����������� ��������
nTERM NUMBER, -- ���� ��������
FOR_DATE DATE DEFAULT DIVISION.OPERDATE+1 --���� �� ������� ���������� �������� ������
)
RETURN VARCHAR2
IS
 RET VARCHAR2(254);
BEGIN
  BEGIN
  SELECT
    '����������� �������������� �����: '||REPORT.SummaInMinUnitsToWords(T32MIND,T31ACUR,0,'RUS',0,' ')||
    '. ������� ���������� ������: '||INTEREST.RATE_AGTP_ACGN(T31AGRC,1,T31ACUR,NVL(DIVISION.OPERDATE,TRUNC(SYSDATE)),NVL(DIVISION.OPERDATE,TRUNC(SYSDATE))+nTERM,NVL(FOR_DATE,TRUNC(SYSDATE)+1),T32MIND,NULL,0,1,0,NULL)||' % �������.'
  INTO RET
  FROM T31,T32
  WHERE T31AGRC=nAGRC AND T32AGRC=T31AGRC;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
 END;
 RETURN RET;
END;

/*������� ���������� ������������ ����� �� �������� ����� ������ �� ��������� �������
����������� ����� ���������� ������ ��������� �� ������� ������ ��������*/
FUNCTION CLIENT_MAX_BALANCE
(nAGID N30.N30AGID%TYPE, --��� �������� �� �������� ���� ������ �������� �������
sBPGI VARCHAR2 DEFAULT NULL, --������ �� ������� ����� ���������� ��������� ����� ������� ����� ������� ���� ��������
sPAGT VARCHAR2 DEFAULT NULL, --������ �� ������� ������� ���������� ��������� ����� ������� ����� ������� ���� ��������
sAGRC VARCHAR2 DEFAULT NULL --������ �� ������� ���������� ��������� ����� ������� ����� ������� ���� ��������
)
RETURN NUMBER
IS
nRET NUMBER;
BEGIN
SELECT NVL(MAX(RATE),0) INTO nRET
FROM
((SELECT 1 X FROM DUAL)
  LEFT JOIN
        (SELECT FIN.ACCREST(N32ACNC,'O',SYSDATE) RATE FROM
        (SELECT * FROM N30 WHERE N30AGID=nAGID) D
          JOIN N30 S ON D.N30CLID=S.N30CLID AND S.N30SCDE=1 AND S.N30MBST=101
          JOIN T31 ON T31AGRC=S.N30AGTP
                      AND
                      (T31BPGI IN (SELECT * FROM TABLE (SERV.TOKENIZE(sBPGI,','))) OR sBPGI IS NULL)
                      AND
                      (T31PAGT IN (SELECT * FROM TABLE (SERV.TOKENIZE(sPAGT,','))) OR sPAGT IS NULL)
                      AND
                      (T31AGRC IN (SELECT * FROM TABLE (SERV.TOKENIZE(sAGRC,','))) OR sAGRC IS NULL)
         JOIN N32 ON N32AGID=S.N30AGID AND N32ACGN=REPORT2.GETACGNBYNAME('_MainAgreeAcc')) ON 1=1);
 RETURN nRET;
 EXCEPTION
   WHEN OTHERS THEN RETURN 0;
END;

/*���������� ����� ������� �������� �� �������*/
FUNCTION RETCOUNTOPERSTART
(nOBJ NUMBER, --������������� �������
 nTYPE NUMBER,--������������� ���� �������
 nOPT NUMBER --������������� ��������

)
RETURN NUMBER
IS
nRET NUMBER;
BEGIN

SELECT COUNT(*) INTO nRET
FROM N01,N02
WHERE N01OPID=N02OPID
      AND N01OPTP=nOPT
      AND ((N02DCID=nOBJ AND N02DCTP=nTYPE) OR (N02SDID=nOBJ AND N02SDTP=nTYPE));
RETURN nRET;
EXCEPTION
   WHEN OTHERS THEN RETURN 0;
END;

FUNCTION my_to_num(val   IN  varchar)
    RETURN NUMBER
    IS
    --�������������� ������ � ����� ���� ��������
begin
    --�������������� ������ � ����� ���� ��������
   RETURN to_number(nvl(regexp_replace(REPLACE(val,',','.'),'[^0-9\.]',''),0));
   EXCEPTION WHEN OTHERS THEN RETURN NULL;
END;--function

function Get_interest(Agid NUMBER)
RETURN number
IS
--������� ���������� ������ �� ��������
interest NUMBER;
BEGIN
SELECT my_to_num(T40INSD) INTO interest FROM T40,n32 WHERE T40INSC=N32.n32insc AND N32AGID=Agid;
RETURN interest;
EXCEPTION
 WHEN others THEN
 RETURN null ;
END;

FUNCTION DecodeKRKCBarcode(
    p_sOriginalCode IN  VARCHAR2
)
RETURN VARCHAR2
IS
-- ��������� �����-��� � ������������ �������� � ������ ���
    TYPE DECODE_ARRAY IS TABLE OF INTEGER INDEX BY VARCHAR(1);
    sOriginalCode   VARCHAR2(2000);
    sResult     VARCHAR2(2000);
    sPart           VARCHAR2(2000);
    sType           VARCHAR2(2000);
    nNumber     NUMBER;
    nSumma      NUMBER;
    nA1     NUMBER;
    nA2     NUMBER;
    nA3     NUMBER;
    nA4     NUMBER;
    nA5     NUMBER;
    nA6     NUMBER;
    nA7     NUMBER;
    decodeArray DECODE_ARRAY;
BEGIN
    -- 0 .. 9
    FOR i in 48 .. 57 LOOP
        decodeARRAY(chr(i)) := i - 48;
    END LOOP;

    -- A .. Z
    FOR i in 65 .. 90 LOOP
        decodeARRAY(chr(i)) := i - 55;
    END LOOP;

    -- � .. �
/*  FOR i in 192 .. 217 LOOP
        decodeARRAY(chr(i)) := i - 182;
    END LOOP;*/

    decodeARRAY('$') := 36;
    decodeARRAY('%') := 37;
    decodeARRAY(' ') := 38;
    decodeARRAY('-') := 39;
    decodeARRAY('+') := 40;
    decodeARRAY('.') := 41;
    decodeARRAY('/') := 42;

    sOriginalCode := UPPER(p_sOriginalCode);

    IF (substr(sOriginalCode, 1, 1) = '�') or (substr(sOriginalCode, 1, 1) = '�') THEN
        sOriginalCode := replace(sOriginalCode,'�','Q');
        sOriginalCode := replace(sOriginalCode,'�','W');
        sOriginalCode := replace(sOriginalCode,'�','E');
        sOriginalCode := replace(sOriginalCode,'�','R');
        sOriginalCode := replace(sOriginalCode,'�','T');
        sOriginalCode := replace(sOriginalCode,'�','Y');
        sOriginalCode := replace(sOriginalCode,'�','U');
        sOriginalCode := replace(sOriginalCode,'�','I');
        sOriginalCode := replace(sOriginalCode,'�','O');
        sOriginalCode := replace(sOriginalCode,'�','P');

        sOriginalCode := replace(sOriginalCode,'�','A');
        sOriginalCode := replace(sOriginalCode,'�','S');
        sOriginalCode := replace(sOriginalCode,'�','D');
        sOriginalCode := replace(sOriginalCode,'�','F');
        sOriginalCode := replace(sOriginalCode,'�','G');
        sOriginalCode := replace(sOriginalCode,'�','H');
        sOriginalCode := replace(sOriginalCode,'�','J');
        sOriginalCode := replace(sOriginalCode,'�','K');
        sOriginalCode := replace(sOriginalCode,'�','L');

        sOriginalCode := replace(sOriginalCode,'�','Z');
        sOriginalCode := replace(sOriginalCode,'�','X');
        sOriginalCode := replace(sOriginalCode,'�','C');
        sOriginalCode := replace(sOriginalCode,'�','V');
        sOriginalCode := replace(sOriginalCode,'�','B');
        sOriginalCode := replace(sOriginalCode,'�','N');
        sOriginalCode := replace(sOriginalCode,'�','M');

        sOriginalCode := replace(sOriginalCode,';','$');
        sOriginalCode := replace(sOriginalCode,'.','/');
        sOriginalCode := replace(sOriginalCode,'�','.');
    END IF;

    -- ��� �����������
    sPart := substr(sOriginalCode, 1, 1);
    sType := sPart;
    sResult := sResult || sPart;

    -- ��� ����������� ��������
    sPart := substr(sOriginalCode, 2, 2);
    nA1 := decodeARRAY(substr(sPart, 1, 1));
    nA2 := decodeARRAY(substr(sPart, 2, 1));
    nNumber := nA1 * 43 + nA2;
    sResult := sResult || '*' || LPAD(to_number(nNumber), 4,' ');

    -- ������� ����
    sPart := substr(sOriginalCode, 4, 5);
    nA1 := decodeARRAY(substr(sPart, 1, 1));
    nA2 := decodeARRAY(substr(sPart, 2, 1));
    nA3 := decodeARRAY(substr(sPart, 3, 1));
    nA4 := decodeARRAY(substr(sPart, 4, 1));
    nA5 := decodeARRAY(substr(sPart, 5, 1));
    nNumber := (((nA1 * 43 + nA2) * 43 + nA3) * 43 + nA4) * 43 + nA5;
    sResult := sResult || '*' || LPAD(to_number(nNumber), 9,' ');

    -- ����� 1
    sPart := substr(sOriginalCode, 9, 7);
    nA1 := decodeARRAY(substr(sPart, 1, 1));
    nA2 := decodeARRAY(substr(sPart, 2, 1));
    nA3 := decodeARRAY(substr(sPart, 3, 1));
    nA4 := decodeARRAY(substr(sPart, 4, 1));
    nA5 := decodeARRAY(substr(sPart, 5, 1));
    nA6 := decodeARRAY(substr(sPart, 6, 1));
    nA7 := decodeARRAY(substr(sPart, 7, 1));
    nSumma := (((((nA1 * 43 + nA2) * 43 + nA3) * 43 + nA4) * 43 + nA5) * 43 + nA6) * 43 + nA7;

    IF sType = 'T' or sType = '�' THEN
        nNumber := nSumma;
    ELSE
        nNumber := 0;
    END IF;

    -- ����� ��� ������������� �����������
    sResult := sResult || '*' || LPAD(to_number(nNumber), 12,' ');
--  sResult := sResult || '*' || replace(to_char(to_number(nNumber) / 100, '9,999,999,990.99'), ',', ' ');

    -- ����
    sPart := substr(sOriginalCode, 16, 4);
    nA1 := decodeARRAY(substr(sPart, 1, 1));
    nA2 := decodeARRAY(substr(sPart, 2, 1));
    nA3 := decodeARRAY(substr(sPart, 3, 1));
    nA4 := decodeARRAY(substr(sPart, 4, 1));
    nNumber := ((nA1 * 43 + nA2) * 43 + nA3) * 43 + nA4;
    sResult := sResult || '*' || LPAD(to_number(nNumber), 7,' ');
--  sResult := sResult || '*' || replace(to_char(to_number(nNumber) / 100, '999,990.99'), ',', ' ');

    IF sType = 'S' or sType = '�' THEN
        nNumber := nSumma;
    ELSE
        nNumber := 0;
    END IF;

    -- ����� � ������������ ������������
    sResult := sResult || '*' || LPAD(to_number(nNumber), 12,' ');
--  sResult := sResult || '*' || replace(to_char(to_number(nNumber) / 100, '9,999,999,990.99'), ',', ' ');

    RETURN sResult;
END;

FUNCTION GET_FUNCNAME_BY_OTYPE (nOTYP NUMBER,nCODE NUMBER) RETURN VARCHAR2
IS
RET_TEXT VARCHAR2(256);
BEGIN
    SELECT
       T.TEXT as TEXT
    INTO RET_TEXT
    FROM table(TYPE_MANAGER. Attribute_GetPossibleValues(NVL(nOTYP,0),'FunctionName')) T
    WHERE T.CODE=nCODE;

RETURN RET_TEXT;
EXCEPTION  WHEN OTHERS THEN RETURN NULL;

END;

PROCEDURE AUTOCREATEACCEPT(SS IN out fcscriptstate)--�������������� �������� �������� � ������������ � ����������� �����
IS
ERROR_CODE      N02.N02ERRS%TYPE;     -- ���� ������
ERROR_PARAM     N02.N02ERRP%TYPE;     -- ��������� ������
nRecordCount    NUMBER := 0;
RemitErr        EXCEPTION;

EXIST_ACCEPT NUMBER:=0;
OPID NUMBER:=0;
PHID NUMBER:=0;
ACID NUMBER:=0;
STAT NUMBER:=1;
PRIO NUMBER:=0;
EMID NUMBER:=0;
ZSTAT NUMBER:=0;--��������� ������
BEGIN
OPID:=SS.m_nOPID;
PHID:=SS.m_nPHID;
EMID:=SS.m_nEMID;
--    nFDocType := nvl(serv.GetParentIDTP(p_SS.m_nIDTP),0);
--��������� ������� �� n02
    FOR  MBID in OPERDOC.FORWARD_N02(SS.m_nOPID, SS.m_nPHID)
      LOOP
        nRecordCount := nRecordCount + 1;
        ERROR_CODE := NULL;
        ERROR_PARAM := NULL;
--�������� ����� ����������
        SAVEPOINT SET_STATE_SV;
--//----������ �������� �����

        BEGIN
             ZSTAT:=STATE_MACHINE.GetObjectState(MBID.N02DCID,MBID.N02DCTP);
              --SERV.LOG('zayavka= '||MBID.N02DCID||' '||nRecordCount,1);

             FOR ACCEPT_TYPE IN (SELECT T81CNMK,T81CSTK FROM T81 WHERE T81CTYP = 273 AND T81CSDS=ZSTAT)
                LOOP
--                 SERV.LOG('MES: T81CNMK:='||to_char(ACCEPT_TYPE.T81CNMK)||' T81CSTK:='||to_char(ACCEPT_TYPE.T81CSTK),'0','2','W','-999');
                    SELECT COUNT(*) INTO EXIST_ACCEPT FROM N79 WHERE N79MBID=MBID.N02DCID AND N79MBST=MBID.N02DCTP AND N79TYPE=ACCEPT_TYPE.T81CNMK AND N79STAT=STAT;

                    IF EXIST_ACCEPT=0
                       THEN
                            PRIO:=ACCEPT_TYPE.T81CSTK;
                            ACCEPT.Accept_Insert(
                                                                 ACID,  -- ������������� �������
                                                  ACCEPT_TYPE.T81CNMK,       -- ��� �������
                                                                 STAT,       -- ��������� �������
                                                                 PRIO,       -- ��������� �������
                                                         MBID.N02DCID,       -- ��� ���������
                                                         MBID.N02DCTP,       -- ��� ���������
                                                                 EMID,       -- �����������
                                                                    0,       -- ��� ������
                                                                 null,     -- �����������
                                                                    0,       -- ��� �������
                                                                 OPID,       -- ������������� ��������, ��������� ������
                                                                 PHID,       -- ����� �����, �� ������� ��� ������ ������
                                                                 null,       -- ���� �������� �������
                                                                 894,        -- ��� ������� �� ����������
                                                            ERROR_CODE,   -- ������ ������
                                                            ERROR_PARAM    -- ��������� ������
                                               );
                            ACID:=null;
                    END IF;
               END LOOP;-- ACCEPT_TYPE

               EXCEPTION WHEN OTHERS THEN ERROR_CODE:='EEEEE';
                                          ERROR_PARAM:=TO_CHAR(MBID.N02SEID);
        END;
--//----����� �������� �����
--//��������� ������������ � ����������
--//ERROR_CODE - ��� ������ (������:L1502)
--//ERROR_PARAM - ��������� ������


        IF ERROR_CODE IS NOT NULL THEN
            ROLLBACK TO SET_STATE_SV;
            SS.m_sError := ERROR_CODE;
            SS.m_sErrorParams := ERROR_PARAM;
        END IF;
        OPERDOC.CompleteElement(MBID.N02SEID, SS.m_nPHID, ERROR_CODE, ERROR_PARAM);

    END LOOP;--MBID
END;--AUTOCREATEAKCEPT
FUNCTION get_comiss_za_otkr_Main_num(agid n30.n30agid%TYPE)
--���������� ����� �������� �� �������� �������� ����� �� ��������
RETURN number
IS
    acnc n67.n67acnc%TYPE;  --��� ��������� ����� �����
    summa n30.n30mind%TYPE; --����� ��������
    dtst n30.n30dtst%TYPE;  --���� ���������� ��������
    insc n38.n38insc%TYPE;  --��� ����� ����������
    crcf b74.b74crcf%TYPE;  --���������� ��������� ��� ������
    valuta b74.b74curc%TYPE; --������ �����
    out_1 number;   --����� �����������
    out_2 NUMBER;   --����� ���������� (�����, ���������� �� ���������� ������)
BEGIN
    SELECT
        n67acnc,
        n30dtst,
        n30mind,
        a.n38insc,
        b74crcf,
        b74curc
    INTO
        acnc, dtst, summa, insc, crcf, valuta
    FROM n30, n38 a, n67, b74
    WHERE
        n30agid = agid AND
        n67mbid = n30agid AND
        n67acgn = 1 AND
        a.n38acnc = n67acnc AND
        a.n38tspc = 2 AND
        b74curc = n67acrc AND
        a.n38tssd=(select max(b.n38tssd) from n38 b where b.n38agid=a.n38agid
                                                          and b.n38acnc=a.n38acnc);
    out_1 := Interest.rate(acnc,dtst,summa,insc,0,1,1);
    out_2 := summa * Interest.rate(acnc,dtst,summa,insc,0,1,0)/ 100;
    RETURN (out_1 + out_2);
END;
FUNCTION FIND_ACNC_BY_ACGN(AGID N32.n32agid%TYPE,ACGN N32.n32acgn%TYPE,ACRC N32.n32acrc%TYPE) RETURN N32.N32ACNC%TYPE
IS
RET N32.N32ACNC%TYPE;
BEGIN
    BEGIN
        SELECT N32ACNC INTO RET FROM N32 WHERE N32AGID=AGID AND N32ACGN=ACGN AND N32ACRC=ACRC;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RET:=NULL;
    END;
    RETURN RET;
END;
FUNCTION Get200_CURC(SEID NUMBER)
         RETURN NUMBER
    IS
      nCURC NUMBER;
    BEGIN
      SELECT RPARAM.GETPARAMN(n02opid,'CURC') INTO nCURC
        FROM N02
        WHERE N02SEID=SEID;
      RETURN nCURC;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN NULL;
    END;
    --$Author gpolyakov $
--����� ������� ������� �� N20
--����������� �������: ���������� -1 ���� ������� ��������� ������ ��������
FUNCTION GetLnkN20SE(
                      LTYP C01.C01LTYP%TYPE, --������������� ������� �����
                      OWNR N20.N20OWNR%TYPE, --������������� ������� ���������
                      OWST N20.N20OWST%TYPE, --������������� ������� ���������
                      OWRL N20.N20OWRL%TYPE, --�� ���� ������� ��������� �����
                      MBST N20.N20MBST%TYPE, --��� ������� ���������
                      MBRL N20.N20MBRL%TYPE  --�� ���� ������� ���������
                    ) RETURN N20.N20MBID%TYPE
AS
  LMBID N20.N20MBID%TYPE:=NULL;
BEGIN
  BEGIN
        SELECT
              N20.N20MBID INTO LMBID
        FROM
              N20
        WHERE
              N20.N20LTYP IN (SELECT C02OBID FROM C02 WHERE C02.C02LTYP=LTYP)
              AND
              N20.N20STAT=1
              AND
              N20.N20OWNR=OWNR
              AND
              N20.N20OWST=OWST
              AND
              N20.N20MBST=MBST
              AND
              N20.N20OWRL=OWRL
              AND
              N20.N20MBRL=MBRL;
    EXCEPTION
      WHEN  TOO_MANY_ROWS THEN LMBID:=-1;
      WHEN OTHERS THEN NULL;
  END;
  RETURN LMBID;
END;
FUNCTION tostring0(pSum in number) return varchar2
is
--
-- ��������: �������������� �������� ����� � ������ � ������������ ����������� 0, ���� �������� ������ 1.

    xStr varchar2(50);
begin

xStr := TO_CHAR(pSum);

-- ���� ������ ������ �� 0, ��������� ���
IF substr(xStr,1,1) IN (',','.')
THEN
    xStr := '0' || xStr;
END IF;

RETURN xStr;

END;
FUNCTION get_distantion_agid(param number)
  RETURN VARCHAR2
    IS
    xResult varchar2(2000);
    xSEID number:=0;
    xAGCD varchar2(200);
    xFIO varchar2(2000);
    xSDID number:=0;
    xSDTP number:=0;
    xACCN varchar2(21);
    begin
--������� ���������� ��������� ��������
--� ����������� �� �������� ��������� param
--param=1 ����� �������� ����������
--param=2 ��� ��������� �������� ����������
--param=3 ��� ��������� �������� ��������� ��������
--param=4 ����� ����� ����������
--param=5 ����� ����� ���������� �� ���������� ��������

    xResult:=' ';
    xSEID:=to_number(SH.VarGetIndX('SEID'));
    xSDID:=OPERDOC.Get_By_Seid(xSEID).n02sdid;
    xSDTP:=OPERDOC.Get_By_Seid(xSEID).n02sdtp;
        if  param=1
            THEN
                if nvl(xSDID,0)>0
                  then
                       select n30agcd into xAGCD from n30 where n30agid=xSDID;
                  else
                       select n30agcd into xAGCD from n30,TABLE(VIRTUAL_TABLES.VGETN52) n52
                                                 where n30agid=n52caid and n52seid=xSEID;
                end if;

          xResult:=xAGCD;
        elsif param=2
            then
                if nvl(xSDID,0)>0  and nvl(xSDTP,0)=101
                  then
                      select n31namf||' '||n31nami||' '||n31namo into xFIO
                                    from n30,n31
                                    where n30clid=n31clid and n30agid=xSDID;
                  elsif nvl(xSDID,0)>0  and nvl(xSDTP,0)=109
                   then
                     /*select n31namf||' '||n31nami||' '||n31namo into xFIO
                                    from n30,n31,TABLE(VIRTUAL_TABLES.VGETN52) n52
                                    where n30clid=n31clid and n30agid=n52caid and n52seid=xSEID;
                       */
                       select T84JPNM into xFIO
                                    from n30,t84
                                    where n30clid=t84jpid and n30agid=xSDID;

                  else
                       select n52cnam into xFIO
                                    from TABLE(VIRTUAL_TABLES.VGETN52) n52
                                    where n52seid=xSEID;

                end if;
          xResult:=xFIO;
          elsif param=4
             then
                  select n52cacn into xACCN from TABLE(VIRTUAL_TABLES.VGETN52) n52
                                                 where n52seid=xSEID;
          xResult:=xACCN;
          elsif param=5
             then
                if nvl(xSDID,0)>0
                  then
                       select n67accn into xACCN
                        from n67
                        where n67mbid=xSDID and n67acst=1 AND n67acgn IN (1,887,888);
                end if;
          xResult:=xACCN;
        END if;

         return xResult;
    exception when others THEN return ' ';

--      NULL;
    end;
--����� �������������� ������� ����� �� ������������ �����
--� ������ ������������� ������ ����������� ������� NULL
FUNCTION GET_LTYP_NAME(
                        LNAME C01.C01NAME%TYPE
                      ) RETURN C01.C01LTYP%TYPE
AS
  LTYP C01.C01LTYP%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
          C01.C01LTYP INTO LTYP
    FROM
          C01
    WHERE
          C01.C01NAME=LNAME;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN LTYP;
END;
--����� �������������� ���� �� ������������ ���� � ���� ������� �����
--� ������ ������������� ������ ����������� ������� NULL
FUNCTION GET_ROBID_NAME(
                        LNAME C07.C07NAME%TYPE,
                        LTYP C01.C01LTYP%TYPE
                      ) RETURN C01.C01LTYP%TYPE
AS
  OBID C07.C07OBID%TYPE:=NULL;
BEGIN
  BEGIN
    SELECT
          C07.C07OBID INTO OBID
    FROM
          C07
    WHERE
          C07.C07NAME=LNAME;
    EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  RETURN OBID;
END;
--$Author aafonina $
--��������� ����������� �������� �� ����������
FUNCTION get_agid_by_clid_bacp_curc(pCLID in number, pBACP in number, pCURC in number)
RETURN number
as
   xResult number;
begin
SELECT N30AGID
  into xResult
  from N30, T31
  where N30CLID = pCLID
    and n30curc = pCURC
    AND T31AGRC = N30AGTP
    AND T31BACP = pBACP
    AND N30SCDE = 1
    AND ROWNUM = 1;
RETURN xResult;
exception when others then
  return null;
END;
FUNCTION Get_INSC(ACCOUNT in NUMBER, OPENDATE in DATE default NULL)
         RETURN NUMBER
    as
     INSCID NUMBER;
    BEGIN
      SELECT 200 INTO INSCID
        FROM dual;
   RETURN INSCID;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN NULL;
    END;

END TUNING;
/