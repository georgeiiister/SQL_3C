SET sqlterminator #
/*���������� ���-�� � TEH2*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	:TEH2 := :TEH2 +1;
	EXCEPTION
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� ���������� ���-�� � TEH2';
END;]',
		'#��:���������� ���-�� � TEH2',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:���������� ���-�� � TEH2')#
/*���������� SUMM � TEH1*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	:TEH1 := :TEH1 + :SUMM;
	EXCEPTION
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� ���������� SUMM � TEH1';
END;]',
		'#��:���������� SUMM � TEH1',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:���������� SUMM � TEH1')#
/*���� (NULL) TEH1 � TEH2*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	:TEH1 := 0;
	:TEH2 := 0;
	EXCEPTION
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� ���㫥��� ���稪�� TEH1 � TEH2';
END;]',
		'#��:���� (0) TEH1 � TEH2',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:���� (NULL) TEH1 � TEH2')#
/*�㬬� ���⥦� � ���������� �������� ������ �� ���� ������ */
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	SELECT :SUMM / B74CRCF INTO :SUMM FROM B74 WHERE B74CURC = :CURC ;
	EXCEPTION
		WHEN
			NO_DATA_FOUND THEN
				:sError := '�� ������ �����樥�� ��� ��।������ ���������� �������� ������ �� ���� ������';
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� �������樨 �㬬� ���⥦� � ��������� �������';
END;]',
		'#��:�㬬� ���⥦� � MIN �������',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:�㬬� ���⥦� � MIN �������')#
/*�㬬� �⮣���� � ���������� �������� ������� �� ���� ������*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	SELECT :SUM1 / B74CRCF INTO :SUM1 FROM B74 WHERE B74CURC = :CURC ;
	EXCEPTION
		WHEN
			NO_DATA_FOUND THEN
				:sError := '�� ������ �����樥�� ��� ��।������ ���������� �������� ������ �� ���� ������';
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� �������樨 �⮣���� �㬬� � ��������� �������';
END;]',
		'#��:�㬬� �⮣���� � MIN �������',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:�㬬� �⮣���� � MIN �������')#
/*����஫� ���४⭮�� �����*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[DECLARE
	sCRCF number;
	BEGIN
	SELECT B74CRCF INTO sCRCF FROM B74 WHERE B74CURC = :CURC ;
	:sParam := '�⮣ �����⠭��: '||TO_CHAR(NVL( :TEH1 ,'0'))||' �⮣ 㪠����� � 䠩��: '||TO_CHAR(NVL( :SUM1 ,'0'));
	IF (NVL( :TEH1 ,0) !=NVL( :SUM1 ,0)) THEN
		:sError :='�訡�� ����஫� �⮣���� �㬬�';
	END IF;
	EXCEPTION
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� ����஫� ����⭮�� �⮣���� �㬬�';
END;]',
		'#��:����஫� ���४⭮�� ����� (SUM1)',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:����஫� ���४⭮�� ����� (SUM1)')#
/*�㬬� �।�� � ���������� �������� ������ �� ���� ������ */
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	SELECT :CSUM / B74CRCF INTO :CSUM FROM B74 WHERE B74CURC = :CURC ;
	EXCEPTION
		WHEN
			NO_DATA_FOUND THEN
				:sError := '�� ������ �����樥�� ��� ��।������ ���������� �������� ������ �� ���� ������';
		WHEN 
			OTHERS THEN
				:sError := '�������⭠� �訡�� �� �������樨 �㬬� �।�� � ��������� �������';
END;]',
		'#��:�㬬� �।�� � MIN �������',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:�㬬� �।�� � MIN �������')#
/*�஢�ઠ ᮮ⢥��⢨� ��� �� ���譥� ��⥬� � 3Card-R*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[DECLARE 
	chF varchar2(50); chI varchar2(50); chO varchar2(50);
BEGIN
	:sParam := nvl( :P002 ,'����� ���������!');
	SELECT N31NAMF, N31NAMI, N31NAMO INTO chF, chI, chO FROM N31, B31 WHERE B31CLID=N31CLID AND B31P002= :P002;
	IF (UPPER(chF)<>UPPER( :NAMF)) OR (UPPER(chI)<>UPPER( :NAMI)) OR (UPPER(chO)<>UPPER( :NAMO)) THEN
		:sError :='��� �� ���譥� ��⥬� � ��⥬� Card-R �⫨�����! � 3Card-R: '||chF||' '||chI||' '||chO||' �� ���譥� ��⥬�: '|| :NAMF || :NAMI || :NAMO;
	END IF;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sError :='�� ������� ���� c ����஬';
		WHEN
			OTHERS THEN 
				:sError :='�������⭠� �訡�� �� ����஫� ��� �� ���� � ����஬';
END;]',
		'#��:��� �� out ��⥬� � 3Card-R',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:_��� �� out ��⥬� � 3Card-R')#
/*��� ������� �� ������ �����*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	:sParam := nvl( :P002 ,'����� ���������!');
	SELECT B31AGID,B31AGID INTO :AGID , :DCID FROM B31 WHERE B31P002= :P002;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sError :='�� ������ ������� �� ���� � ����஬';
		WHEN
			OTHERS THEN 
				:sError :='�������⭠� �訡�� �� ���᪥ ���� ������� �� ���� � ����஬';
END;]',
		'#��:��� ������� �� ������ �����',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:��� ������� �� ������ �����')#	
/*��� ������ ������� �� ���� �������*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	IF ( :AGID IS NOT NULL ) THEN
		SELECT N30CURC INTO :CURC FROM N30 WHERE N30AGID= :AGID;
	ELSE
		:sError := '�� 㪠��� ��� �������';
	END IF;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sParam := to_char( :AGID );
				:sError :='�� ������� ����� ������� � ��';
		WHEN
			OTHERS THEN 
				:sError :='�������⭠� �訡�� �� ���᪥ ������ �������';
END;]',
		'#��:����� ������� �� ���� ���-�',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:����� ������� �� ���� ���-�')#
/*����-�� �����祭�� ���-�� ���㬥��*/
INSERT INTO Y04 (
                 Y04SAFN,
 				 Y04SAFT,
 				 Y04STXT, 
				 Y04SAFD,
				 Y04SERR,
				 Y04SERP,
				 Y04_ARH
				)
SELECT (
		SELECT MAX(Y04SAFN)+1 FROM Y04
	    ),
		0,
		q'[BEGIN
	:sParam := nvl( :DESC ,'�����祭�� ���������!');
	:DESC :=REPLACE( :DESC ,'|','/');
	EXCEPTION 
		WHEN
			OTHERS THEN 
				:sError :='�������⭠� �訡�� �� ���४�஢�� �����祭��';
END;]',
		'#��:����-�� �����祭�� ���-�� ���㬥��',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#��:����-�� �����祭�� ���-�� ���㬥��')#	  
SET sqlterminator ;
COMMIT;
