SET sqlterminator #
/*Накопление кол-ва в TEH2*/
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
				:sError := 'Неизвестная ошибка при накоплении кол-ва в TEH2';
END;]',
		'#ФШ:Накопление кол-ва в TEH2',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Накопление кол-ва в TEH2')#
/*Накопление SUMM в TEH1*/
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
				:sError := 'Неизвестная ошибка при накоплении SUMM в TEH1';
END;]',
		'#ФШ:Накопление SUMM в TEH1',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Накопление SUMM в TEH1')#
/*Сброс (NULL) TEH1 и TEH2*/
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
				:sError := 'Неизвестная ошибка при обнулении счетчиков TEH1 и TEH2';
END;]',
		'#ФШ:Сброс (0) TEH1 и TEH2',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Сброс (NULL) TEH1 и TEH2')#
/*Сумма платежа в минимальных денежных единиц по коду валюты */
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
				:sError := 'Не найден коэффициент для определения минимальных денежных единиц по коду валюты';
		WHEN 
			OTHERS THEN
				:sError := 'Неизвестная ошибка при конвертации суммы платежа в минимальные единицы';
END;]',
		'#ФШ:Сумма платежа в MIN единицах',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Сумма платежа в MIN единицах')#
/*Сумма итоговая в минимальных денежных единицах по коду валюты*/
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
				:sError := 'Не найден коэффициент для определения минимальных денежных единиц по коду валюты';
		WHEN 
			OTHERS THEN
				:sError := 'Неизвестная ошибка при конвертации итоговой суммы в минимальные единицы';
END;]',
		'#ФШ:Сумма итоговая в MIN единицах',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Сумма итоговая в MIN единицах')#
/*Контроль корректности ИТОГа*/
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
	:sParam := 'Итог подсчитанный: '||TO_CHAR(NVL( :TEH1 ,'0'))||' Итог указанный в файле: '||TO_CHAR(NVL( :SUM1 ,'0'));
	IF (NVL( :TEH1 ,0) !=NVL( :SUM1 ,0)) THEN
		:sError :='Ошибка контроля итоговой суммы';
	END IF;
	EXCEPTION
		WHEN 
			OTHERS THEN
				:sError := 'Неизвестная ошибка контроля корретности итоговой суммы';
END;]',
		'#ФШ:Контроль корректности ИТОГа (SUM1)',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Контроль корректности ИТОГа (SUM1)')#
/*Сумма кредита в минимальных денежных единиц по коду валюты */
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
				:sError := 'Не найден коэффициент для определения минимальных денежных единиц по коду валюты';
		WHEN 
			OTHERS THEN
				:sError := 'Неизвестная ошибка при конвертации суммы кредита в минимальные единицы';
END;]',
		'#ФШ:Сумма кредита в MIN единицах',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Сумма кредита в MIN единицах')#
/*Проверка соответствия ФИО из внешней системы и 3Card-R*/
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
	:sParam := nvl( :P002 ,'Номер отсутствует!');
	SELECT N31NAMF, N31NAMI, N31NAMO INTO chF, chI, chO FROM N31, B31 WHERE B31CLID=N31CLID AND B31P002= :P002;
	IF (UPPER(chF)<>UPPER( :NAMF)) OR (UPPER(chI)<>UPPER( :NAMI)) OR (UPPER(chO)<>UPPER( :NAMO)) THEN
		:sError :='ФИО во внешней системе и системе Card-R отличаются! В 3Card-R: '||chF||' '||chI||' '||chO||' во внешней системе: '|| :NAMF || :NAMI || :NAMO;
	END IF;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sError :='Не найдена карта c номером';
		WHEN
			OTHERS THEN 
				:sError :='Неизвестная ошибка при контроле ФИО по карте с номером';
END;]',
		'#ФШ:ФИО из out системы и 3Card-R',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:_ФИО из out системы и 3Card-R')#
/*Код договора по номеру карты*/
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
	:sParam := nvl( :P002 ,'Номер отсутствует!');
	SELECT B31AGID,B31AGID INTO :AGID , :DCID FROM B31 WHERE B31P002= :P002;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sError :='Не найден договор по карте с номером';
		WHEN
			OTHERS THEN 
				:sError :='Неизвестная ошибка при поиске кода договора по карте с номером';
END;]',
		'#ФШ:Код договора по номеру карты',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Код договора по номеру карты')#	
/*Код валюты договора по коду договора*/
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
		:sError := 'Не указан код договора';
	END IF;
	EXCEPTION 
		WHEN 
			NO_DATA_FOUND THEN
				:sParam := to_char( :AGID );
				:sError :='Не найдена валюта договора с ИД';
		WHEN
			OTHERS THEN 
				:sError :='Неизвестная ошибка при поиске валюты договора';
END;]',
		'#ФШ:Валюта договора по коду дог-ра',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Валюта договора по коду дог-ра')#
/*Корр-ка назначения исх-го документа*/
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
	:sParam := nvl( :DESC ,'Назначение отсутствует!');
	:DESC :=REPLACE( :DESC ,'|','/');
	EXCEPTION 
		WHEN
			OTHERS THEN 
				:sError :='Неизвестная ошибка при корректировке назначения';
END;]',
		'#ФШ:Корр-ка назначения исх-го документа',
		NULL,
		NULL,
		0 
FROM 
     dual 
WHERE 
      NOT EXISTS (SELECT * FROM Y04 WHERE Y04SAFD='#ФШ:Корр-ка назначения исх-го документа')#	  
SET sqlterminator ;
COMMIT;
