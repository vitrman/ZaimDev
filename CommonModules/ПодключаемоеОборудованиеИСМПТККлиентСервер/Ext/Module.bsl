﻿
#Область ПрограммныйИнтерфейс

#Область ФункцииРаботыGS1

// Разобрать строку штрихкода в соответствии со стандартом GS1.
//
Функция РазобратьСтрокуШтрихкодаGS1(Знач Штрихкод) Экспорт;
	
	РезультатРазбора = Новый Структура;
	РезультатРазбора.Вставить("Разобран"      , Ложь);
	РезультатРазбора.Вставить("ОписаниеОшибки");
	РезультатРазбора.Вставить("ПредставлениеШтрихкода", "");
	РезультатРазбора.Вставить("ДанныеШтрихкода", Новый Соответствие);
	
	КодыGS1 = ПодключаемоеОборудованиеИСМПТККлиентСерверПовтИсп.КодыGS1();
	
	Если СтрНачинаетсяС(Штрихкод, "(") Тогда
		РазобратьСтрокуШтрихкодаGS1СоСкобками(Штрихкод, РезультатРазбора, КодыGS1);
	Иначе
		Разделитель = РазделительGS1();
		ЧастиШтрихкода = СтрРазделить(Штрихкод, Разделитель, Ложь);
		Для Каждого ЧастьБезРазделителей Из ЧастиШтрихкода Цикл
			РазобратьСтрокуШтрихкодаGS1Служебный(ЧастьБезРазделителей, РезультатРазбора, КодыGS1);
		КонецЦикла;
	КонецЕсли;
	
	Возврат РезультатРазбора;
	
КонецФункции

#КонецОбласти

#Область ФункцииМаркировкиПродукции

// Функция возвращает разделитель GS1.
//
Функция РазделительGS1() Экспорт;
	
	Возврат Символ(29); // Dec 29
	
КонецФункции

// Функция возвращает экранированный символ GS1.
//
Функция ЭкранированныйСимволGS1() Экспорт;
	
	Возврат "\x1d"; // Используется для экранирования символа GS1.
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КодыGS1Служебный() Экспорт;
	
	Коды = Новый Соответствие;
	
	ДобавитьКодGS1(Коды, "00"  , "SSCC"                      , 18);
	ДобавитьКодGS1(Коды, "01"  , "GTIN"                      , 14);
	ДобавитьКодGS1(Коды, "02"  , "CONTENT"                   , 14);
	ДобавитьКодGS1(Коды, "10"  , "BATCH_LOT"                 ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "11"  , "PROD_DATE"                 ,  6);
	ДобавитьКодGS1(Коды, "12"  , "DUE_DATE"                  ,  6);
	ДобавитьКодGS1(Коды, "13"  , "PACK_DATE"                 ,  6);
	ДобавитьКодGS1(Коды, "15"  , "BEST_BEFORE"               ,  6);
	ДобавитьКодGS1(Коды, "16"  , "SELL_BY"                   ,  6);
	ДобавитьКодGS1(Коды, "17"  , "EXPIRE"                    ,  6);
	ДобавитьКодGS1(Коды, "20"  , "VARIANT"                   ,  2);
	ДобавитьКодGS1(Коды, "21"  , "SERIAL"                    ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "22"  , "CPV"                       ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "240" , "ADDITIONAL_ID"             ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "241" , "CUSTOMER_PART_NO"          ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "242" , "MTO_VARIANT"               ,   ,  6);
	ДобавитьКодGS1(Коды, "243" , "PCN"                       ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "250" , "SECONDARY_SERIAL"          ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "251" , "REF_TO_SOURCE"             ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "253" , "GDTI"                      , 13, 17,  ТипGS1Число(), ТипGS1Строка());
	ДобавитьКодGS1(Коды, "254" , "GLN_EXTENSION_COMPONENT"   ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "255" , "GСТ"                       , 13, 12);
	ДобавитьКодGS1(Коды, "30"  , "VAR_COUNT"                 ,   , 8);
	ДобавитьКодGS1(Коды, "310n", "NET_WEIGHT_kg"             ,  6);
	ДобавитьКодGS1(Коды, "311n", "LENGTH_m"                  ,  6);
	ДобавитьКодGS1(Коды, "312n", "WIDTH_m"                   ,  6);
	ДобавитьКодGS1(Коды, "313n", "HEIGHT_m"                  ,  6);
	ДобавитьКодGS1(Коды, "314n", "AREA_m2"                   ,  6);
	ДобавитьКодGS1(Коды, "315n", "NET_VOLUME_l"              ,  6);
	ДобавитьКодGS1(Коды, "316n", "NET_VOLUME_m3"             ,  6);
	ДобавитьКодGS1(Коды, "320n", "NET_WEIGHT_lb"             ,  6);
	ДобавитьКодGS1(Коды, "321n", "LENGTH_i"                  ,  6);
	ДобавитьКодGS1(Коды, "322n", "LENGTH_f"                  ,  6);
	ДобавитьКодGS1(Коды, "323n", "LENGTH_y"                  ,  6);
	ДобавитьКодGS1(Коды, "324n", "WIDTH_i"                   ,  6);
	ДобавитьКодGS1(Коды, "325n", "WIDTH_f"                   ,  6);
	ДобавитьКодGS1(Коды, "326n", "WIDTH_y"                   ,  6);
	ДобавитьКодGS1(Коды, "327n", "HEIGHT_i"                  ,  6);
	ДобавитьКодGS1(Коды, "328n", "HEIGHT_f"                  ,  6);
	ДобавитьКодGS1(Коды, "329n", "HEIGHT_y"                  ,  6);
	ДобавитьКодGS1(Коды, "330n", "GROSS_WEIGHT_kg"           ,  6);
	ДобавитьКодGS1(Коды, "331n", "LENGTH_m_log"              ,  6);
	ДобавитьКодGS1(Коды, "332n", "WIDTH_m_log"               ,  6);
	ДобавитьКодGS1(Коды, "333n", "HEIGHT_m_log"              ,  6);
	ДобавитьКодGS1(Коды, "334n", "AREA_m2_log"               ,  6);
	ДобавитьКодGS1(Коды, "335n", "VOLUME_l_log"              ,  6);
	ДобавитьКодGS1(Коды, "336n", "VOLUME_m3_log"             ,  6);
	ДобавитьКодGS1(Коды, "337n", "KG_PER_m2"                 ,  6);
	ДобавитьКодGS1(Коды, "340n", "GROSS_WEIGHT_lb"           ,  6);
	ДобавитьКодGS1(Коды, "341n", "LENGTH_i_log"              ,  6);
	ДобавитьКодGS1(Коды, "342n", "LENGTH_f_log"              ,  6);
	ДобавитьКодGS1(Коды, "343n", "LENGTH_y_log"              ,  6);
	ДобавитьКодGS1(Коды, "344n", "WIDTH_i_log"               ,  6);
	ДобавитьКодGS1(Коды, "345n", "WIDTH_f_log"               ,  6);
	ДобавитьКодGS1(Коды, "346n", "WIDTH_y_log"               ,  6);
	ДобавитьКодGS1(Коды, "347n", "HEIGHT_i_log"              ,  6);
	ДобавитьКодGS1(Коды, "348n", "HEIGHT_f_log"              ,  6);
	ДобавитьКодGS1(Коды, "349n", "HEIGHT_y_log"              ,  6);
	ДобавитьКодGS1(Коды, "350n", "AREA_i2"                   ,  6);
	ДобавитьКодGS1(Коды, "351n", "AREA_f2"                   ,  6);
	ДобавитьКодGS1(Коды, "352n", "AREA_y2"                   ,  6);
	ДобавитьКодGS1(Коды, "353n", "AREA_i2_log"               ,  6);
	ДобавитьКодGS1(Коды, "354n", "AREA_f2_log"               ,  6);
	ДобавитьКодGS1(Коды, "355n", "AREA_y2_log"               ,  6);
	ДобавитьКодGS1(Коды, "356n", "NET_WEIGHT_t"              ,  6);
	ДобавитьКодGS1(Коды, "357n", "NET_VOLUME_oz"             ,  6);
	ДобавитьКодGS1(Коды, "360n", "NET_VOLUME_q"              ,  6);
	ДобавитьКодGS1(Коды, "361n", "NET_VOLUME_g"              ,  6);
	ДобавитьКодGS1(Коды, "362n", "VOLUME_q"                  ,  6);
	ДобавитьКодGS1(Коды, "363n", "VOLUME_g"                  ,  6);
	ДобавитьКодGS1(Коды, "364n", "VOLUME_i3"                 ,  6);
	ДобавитьКодGS1(Коды, "365n", "VOLUME_f3"                 ,  6);
	ДобавитьКодGS1(Коды, "366n", "VOLUME_y3"                 ,  6);
	ДобавитьКодGS1(Коды, "367n", "VOLUME_i3_log"             ,  6);
	ДобавитьКодGS1(Коды, "368n", "VOLUME_f3_log"             ,  6);
	ДобавитьКодGS1(Коды, "369n", "VOLUME_y3_log"             ,  6);
	ДобавитьКодGS1(Коды, "37"  , "COUNT"                     ,   ,  8);
	ДобавитьКодGS1(Коды, "390n", "AMOUNT"                    ,   , 15);
	ДобавитьКодGS1(Коды, "391n", "AMOUNT_ISO"                ,  3, 15);
	ДобавитьКодGS1(Коды, "392n", "PRICE"                     ,   , 15);
	ДобавитьКодGS1(Коды, "393n", "PRICE_ISO"                 ,  3, 15);
	ДобавитьКодGS1(Коды, "394n", "PRCNT_OFF"                 ,  4,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "400" , "ORDER_NUMBER"              ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "401" , "GINC"                      ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "402" , "GSIN"                      , 17,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "403" , "ROUTE"                     ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "410" , "SHIP_TO_LOC"               , 13);
	ДобавитьКодGS1(Коды, "411" , "BILL_TO"                   , 13);
	ДобавитьКодGS1(Коды, "412" , "PURCHASE_FROM"             , 13);
	ДобавитьКодGS1(Коды, "413" , "SHIP_FOR_LOC"              , 13);
	ДобавитьКодGS1(Коды, "414" , "LOC_No"                    , 13);
	ДобавитьКодGS1(Коды, "415" , "PAY_TO"                    , 13);
	ДобавитьКодGS1(Коды, "416" , "PROD_SERV_LOC"             , 13);
	ДобавитьКодGS1(Коды, "420" , "SHIP_TO_POST"              ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "421" , "SHIP_TO_POST_ISO"          ,  3,  9,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "422" , "ORIGIN"                    ,  3,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "423" , "CONTRY_INITIAL_PROCESS"    ,  3, 12);
	ДобавитьКодGS1(Коды, "424" , "CONTRY_PROCESS"            ,  3,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "425" , "CONTRY_DISASSEMBLY"        ,  3, 12);
	ДобавитьКодGS1(Коды, "426" , "CONTRY_FULL_PROCESS"       ,  3,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "427" , "ORIGIN_SUBDIVISION"        ,   ,  3,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7001", "NSN"                       , 13,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "7002", "MEAT_CUT"                  ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7003", "EXPIRY_TIME"               , 10,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "7004", "ACTIVE_POTENCY"            ,   ,  4);
	ДобавитьКодGS1(Коды, "7005", "CATCH_AREA"                ,   , 12,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7006", "FIRST_FREEZE_DATE"         ,  6,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "7007", "HARVEST_DATE"              ,  6,  6);
	ДобавитьКодGS1(Коды, "7008", "AQUATIC_SPECIES"           ,   ,  3,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7009", "FISHING_GEAR_TYPE"         ,   , 10,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7010", "PROD_METHOD"               ,   ,  2,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7020", "REFURB_LOT"                ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7021", "FUNC_STAT"                 ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7022", "REV_STAT"                  ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "7023", "GIAI_ASSEMBLY"             ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "703s", "PROCESSOR_s"               ,  3, 27,  ТипGS1Число(), ТипGS1Строка());
	ДобавитьКодGS1(Коды, "710" , "NHRN_PZN"                  ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "711" , "NHRN_CIP"                  ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "712" , "NHRN_CN"                   ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "713" , "NHRN_DRN"                  ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8001", "DIMENSIONS"                , 14,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8002", "CMT_No"                    ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8003", "GRAI"                      , 14, 16,  ТипGS1Число(), ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8004", "GIAI"                      ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8005", "PRICE_PER_UNIT"            ,  6,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8006", "ITIP_or_GCTIN"             , 18,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8007", "IBAN"                      ,   , 34,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8008", "PROD_TIME"                 ,  8, 4,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8010", "CPID"                      ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8011", "CPID_SERIAL"               ,   , 12);
	ДобавитьКодGS1(Коды, "8012", "VERSION"                   ,   , 20,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8017", "GSRN_PROVIDER"             , 18,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8018", "GSRN_RECIPIENT"            , 18,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8019", "SRIN"                      ,   , 10);
	ДобавитьКодGS1(Коды, "8020", "REF_No"                    ,   , 25,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8110", "COUPON_CODE_ID"            ,   , 70,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8111", "POINTS"                    ,  4,   ,               ,               , Истина);
	ДобавитьКодGS1(Коды, "8112", "PAPPERLESS_COUPON_CODE_ID" ,   , 70,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "8200", "PRODUCT_URL"               ,   , 70,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "90"  , "INTERNAL"                  ,   , 30,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "91"  , "INTERNAL1"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "92"  , "INTERNAL2"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "93"  , "INTERNAL3"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "94"  , "INTERNAL4"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "95"  , "INTERNAL5"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "96"  , "INTERNAL6"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "97"  , "INTERNAL7"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "98"  , "INTERNAL8"                 ,   , 90,               , ТипGS1Строка());
	ДобавитьКодGS1(Коды, "99"  , "INTERNAL9"                 ,   , 90,               , ТипGS1Строка());
	
	Возврат Коды
	
КонецФункции

Процедура РазобратьСтрокуШтрихкодаGS1СоСкобками(Штрихкод, РезультатРазбора, КодыGS1);
	
	РезультатРазбора.ПредставлениеШтрихкода = Штрихкод;
	
	ДлинаШтрихкода = СтрДлина(Штрихкод);
	МинимальнаяДлинаИдентификатораПрименения  = 2;
	МаксимальнаяДлинаИдентификатораПрименения = 4;
	
	НомерСимвола = 1;
	Пока НомерСимвола <= ДлинаШтрихкода Цикл
		
		Если Сред(Штрихкод, НомерСимвола, 1) <> "(" Тогда
			РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Номер символа %1%. Отсутствует ""("".';
					|en = 'Symbol number %1%. Missing ""("".'"), НомерСимвола);
			Возврат;
		КонецЕсли;
		
		НомерСимвола = НомерСимвола + 1;
		
		Позиция = СтрНайти(Штрихкод, ")",, НомерСимвола);
		Если Позиция = 0 Тогда
			РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Номер символа %1. Отсутствует "")"".';
					|en = 'Symbol number %1. Missing "")"".'"), НомерСимвола);
			Возврат;
		КонецЕсли;
		
		ИдентификаторПрименения = Сред(Штрихкод, НомерСимвола, Позиция - НомерСимвола);
		ДлинаИдентификатора = СтрДлина(ИдентификаторПрименения);
		Если ДлинаИдентификатора < МинимальнаяДлинаИдентификатораПрименения Или ДлинаИдентификатора > МаксимальнаяДлинаИдентификатораПрименения Тогда
			РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Номер символа %1. Неизвестный идентификатор применения(AI) %2.';
					|en = 'Symbol number %1. Unknown usage ID (AI) %2.'"), НомерСимвола, ИдентификаторПрименения);
			Возврат;
		КонецЕсли;
		
		ПоложениеДесятичнойТочкиСтрокой = "";
		ОписаниеКода = КодыGS1[ИдентификаторПрименения];
		Если ОписаниеКода = Неопределено Тогда
			Если ДлинаИдентификатора = МаксимальнаяДлинаИдентификатораПрименения Тогда
				ОписаниеКода = КодыGS1[Лев(ИдентификаторПрименения, МаксимальнаяДлинаИдентификатораПрименения - 1)];
				ПоложениеДесятичнойТочкиСтрокой = Прав(ИдентификаторПрименения, 1);
			КонецЕсли;
		КонецЕсли;
		
		Если ОписаниеКода = Неопределено Тогда
			РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
				НСтр("ru = 'Номер символа %1. Неизвестный идентификатор применения(AI) %2.';
					|en = 'Symbol number %1. Unknown usage ID (AI) %2.'"), НомерСимвола, ИдентификаторПрименения);
			Возврат;
		КонецЕсли;
		
		НомерСимвола = Позиция + 1;
		
		Значение = "";
		Если ОписаниеКода.ФиксированнаяДлина > 0 Тогда
			Значение = Сред(ШтрихКод, НомерСимвола, ОписаниеКода.ФиксированнаяДлина);
			Если СтрДлина(Значение) <> ОписаниеКода.ФиксированнаяДлина Тогда
				РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Номер символа %5. Длина значения (%3) для идентификатора применения(AI) ""%1 %2"" меньше требуемой (%4)';
						|en = 'Symbol number %5. Value length (%3) for usage ID (AI) ""%1 %2"" is less than required (%4)'"),
						ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(Значение), ОписаниеКода.ФиксированнаяДлина, НомерСимвола);
				Возврат;
			КонецЕсли;
			
			Если ОписаниеКода.ТипФиксированногоЗначения = ТипGS1Число() Тогда
				Если Не ТолькоЦифрыВСтроке(Значение) Тогда
					РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Номер символа %4. Значение (%3) для идентификатора применения(AI) ""%1 %2"" должно содержать только цифры';
							|en = 'Symbol number %4. Value (%3) for usage ID (AI) ""%1 %2"" must contain only digits'"),
							ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(Значение), НомерСимвола);
					Возврат;
				КонецЕсли;
			КонецЕсли;
			НомерСимвола = НомерСимвола + ОписаниеКода.ФиксированнаяДлина;
		КонецЕсли;
		
		Если ОписаниеКода.ПеременнаяДлина > 0 И Позиция < ДлинаШтрихкода Тогда
			ПозицияСледующегоИдентификатора = СтрНайти(Штрихкод, "(",, НомерСимвола);
			
			ПравильныйИдентификатор = Ложь;
			Пока ПозицияСледующегоИдентификатора > 0 И Не ПравильныйИдентификатор Цикл
				ПозицияЗакрывающегоИдентификатора = СтрНайти(Штрихкод, ")", , ПозицияСледующегоИдентификатора);
				ПредполагаемыйИдентификатор = Сред(Штрихкод, ПозицияСледующегоИдентификатора + 1,ПозицияЗакрывающегоИдентификатора - ПозицияСледующегоИдентификатора - 1);
				ПравильныйИдентификатор = СтрДлина(ПредполагаемыйИдентификатор) > 1 И СтрДлина(ПредполагаемыйИдентификатор) < 5 И ТолькоЦифрыВСтроке(ПредполагаемыйИдентификатор);
				Если ПозицияСледующегоИдентификатора >= ДлинаШтрихкода Тогда
					ПозицияСледующегоИдентификатора = 0
				ИначеЕсли Не ПравильныйИдентификатор Тогда
					ПозицияСледующегоИдентификатора = СтрНайти(Штрихкод, "(",, ПозицияСледующегоИдентификатора  + 1);
				КонецЕсли;
			КонецЦикла;
			
			Если ПозицияСледующегоИдентификатора > 0 Тогда
				ЗначениеПеременное = Сред(Штрихкод, НомерСимвола, ПозицияСледующегоИдентификатора - НомерСимвола);
			Иначе
				ЗначениеПеременное = Сред(Штрихкод, НомерСимвола);
			КонецЕсли;
			
			Если СтрДлина(ЗначениеПеременное) > ОписаниеКода.ПеременнаяДлина Тогда
				РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Номер символа %5. Длина значения (%3) переменной части для идентификатора применения(AI) ""%1 %2"" больше требуемой (%4)';
						|en = 'Symbol number %5. Value length (%3) of the variable part for usage ID (AI) ""%1 %2"" is more than required (%4)'"),
						ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(ЗначениеПеременное), ОписаниеКода.ПеременнаяДлина, НомерСимвола);
				Возврат;
			КонецЕсли;
			Если ОписаниеКода.ТипПеременногоЗначения = ТипGS1Число() Тогда
				Если Не ТолькоЦифрыВСтроке(ЗначениеПеременное) Тогда
					РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Номер символа %4. Значение (%3) для идентификатора применения(AI) ""%1 %2"" должно содержать только цифры';
							|en = 'Symbol number %4. Value (%3) for usage ID (AI) ""%1 %2"" must contain only digits'"),
							ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(ЗначениеПеременное), НомерСимвола);
					Возврат;
				КонецЕсли;
			КонецЕсли;
			НомерСимвола = НомерСимвола + СтрДлина(ЗначениеПеременное);
			Значение = Значение + ЗначениеПеременное;
		КонецЕсли;
		
		ПоложениеДесятичнойТочки = 0;
		Если Не ПустаяСтрока(ПоложениеДесятичнойТочкиСтрокой) Тогда
			ПоложениеДесятичнойТочки = Число(ПоложениеДесятичнойТочкиСтрокой);
			Если ПоложениеДесятичнойТочки > 0 Тогда
				Для Индекс = 0 По ПоложениеДесятичнойТочки - СтрДлина(Значение) Цикл
					Значение = "0" + Значение;
				КонецЦикла;
				Значение = Лев(Значение, СтрДлина(Значение) - ПоложениеДесятичнойТочки) + "." + Прав(Значение, ПоложениеДесятичнойТочки);
			КонецЕсли;
		КонецЕсли;
		
		ОписаниеДанных = Новый Структура;
		ОписаниеДанных.Вставить("ПоложениеДесятичнойТочки", ПоложениеДесятичнойТочки);
		ОписаниеДанных.Вставить("Значение", Значение);
		РезультатРазбора.ДанныеШтрихкода.Вставить(ОписаниеКода.Код, ОписаниеДанных);
		
	КонецЦикла;
	
	РезультатРазбора.Разобран = Истина;
	
КонецПроцедуры

Процедура РазобратьСтрокуШтрихкодаGS1Служебный(Штрихкод, РезультатРазбора, КодыGS1);
	
	ДлинаШтрихкода = СтрДлина(Штрихкод);
	ПредставлениеШтрихкода = "";
	
	НомерСимвола = 1;
	Пока НомерСимвола <= ДлинаШтрихкода Цикл
		
		ИдентификаторПрименения = Сред(Штрихкод, НомерСимвола, 2);
		ОписаниеКода = КодыGS1[ИдентификаторПрименения];
		Если ОписаниеКода = Неопределено Тогда
			ИдентификаторПрименения = Сред(Штрихкод, НомерСимвола, 3);
			ОписаниеКода = КодыGS1[ИдентификаторПрименения];
			Если ОписаниеКода = Неопределено Тогда
				ИдентификаторПрименения = Сред(Штрихкод, НомерСимвола, 4);
				ОписаниеКода = КодыGS1[ИдентификаторПрименения];
				Если ОписаниеКода = Неопределено Тогда
					РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Неизвестный идентификатор применения(AI) %1.';
							|en = 'Unknown usage ID (AI) %1.'"), ИдентификаторПрименения);
					Возврат;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		НомерСимвола = НомерСимвола + СтрДлина(ИдентификаторПрименения);
		
		ПоложениеДесятичнойТочкиСтрокой = "";
		Если ОписаниеКода.ЕстьПоложениеДесятичнойТочки Тогда
			ПоложениеДесятичнойТочкиСтрокой = Сред(Штрихкод, НомерСимвола, 1);
			НомерСимвола = НомерСимвола + 1;
		КонецЕсли;
		
		Значение = "";
		Если ОписаниеКода.ФиксированнаяДлина > 0 Тогда
			Значение = Сред(ШтрихКод, НомерСимвола, ОписаниеКода.ФиксированнаяДлина);
			Если СтрДлина(Значение) <> ОписаниеКода.ФиксированнаяДлина Тогда
				РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Длина значения (%3) для идентификатора применения(AI) ""%1 %2"" меньше требуемой (%4)';
						|en = 'Value length (%3) for usage ID (AI) ""%1 %2"" is less than required (%4)'"),
						ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(Значение), ОписаниеКода.ФиксированнаяДлина);
				Возврат;
			КонецЕсли;
			Если ОписаниеКода.ТипФиксированногоЗначения = ТипGS1Число() Тогда
				Если Не ТолькоЦифрыВСтроке(Значение) Тогда
					РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Значение (%3) для идентификатора применения(AI) ""%1 %2"" должно содержать только цифры';
							|en = 'Value (%3) for usage ID (AI) ""%1 %2"" must contain only digits'"),
							ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(Значение));
					Возврат;
				КонецЕсли;
			КонецЕсли;
			НомерСимвола = НомерСимвола + ОписаниеКода.ФиксированнаяДлина;
		КонецЕсли;
		Если ОписаниеКода.ПеременнаяДлина > 0 Тогда
			ЗначениеПеременное = Сред(Штрихкод, НомерСимвола);
			Если СтрДлина(ЗначениеПеременное) > ОписаниеКода.ПеременнаяДлина Тогда
				РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Длина значения (%3) переменной части для идентификатора применения(AI) ""%1 %2"" больше требуемой (%4)';
						|en = 'Value length (%3) of the variable part for usage ID (AI) ""%1 %2"" is more than required (%4)'"),
						ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(ЗначениеПеременное), ОписаниеКода.ПеременнаяДлина);
				Возврат;
			КонецЕсли;
			Если ОписаниеКода.ТипПеременногоЗначения = ТипGS1Число() Тогда
				Если Не ТолькоЦифрыВСтроке(ЗначениеПеременное) Тогда
					РезультатРазбора.ОписаниеОшибки = ИнтеграцияИСМПТККлиентСерверПереопределяемый.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Значение (%3) для идентификатора применения(AI) ""%1 %2"" должно содержать только цифры';
							|en = 'Value (%3) for usage ID (AI) ""%1 %2"" must contain only digits'"),
							ИдентификаторПрименения, ОписаниеКода.Имя, СтрДлина(ЗначениеПеременное));
					Возврат;
				КонецЕсли;
			КонецЕсли;
			НомерСимвола = НомерСимвола + СтрДлина(ЗначениеПеременное);
			Значение = Значение + ЗначениеПеременное;
		КонецЕсли;
		
		ПредставлениеШтрихкода = ПредставлениеШтрихкода + "(" + ИдентификаторПрименения + ПоложениеДесятичнойТочкиСтрокой + ")" + Значение;
		
		ПоложениеДесятичнойТочки = 0;
		Если Не ПустаяСтрока(ПоложениеДесятичнойТочкиСтрокой) Тогда
			ПоложениеДесятичнойТочки = Число(ПоложениеДесятичнойТочкиСтрокой);
			Если ПоложениеДесятичнойТочки > 0 Тогда
				Для Индекс = 0 По ПоложениеДесятичнойТочки - СтрДлина(Значение) Цикл
					Значение = "0" + Значение;
				КонецЦикла;
				Значение = Лев(Значение, СтрДлина(Значение) - ПоложениеДесятичнойТочки) + "." + Прав(Значение, ПоложениеДесятичнойТочки);
			КонецЕсли;
		КонецЕсли;
		
		ОписаниеДанных = Новый Структура;
		ОписаниеДанных.Вставить("ПоложениеДесятичнойТочки", ПоложениеДесятичнойТочки);
		ОписаниеДанных.Вставить("Значение", Значение);
		РезультатРазбора.ДанныеШтрихкода.Вставить(ОписаниеКода.Код, ОписаниеДанных);
		
	КонецЦикла;
	
	РезультатРазбора.ПредставлениеШтрихкода = РезультатРазбора.ПредставлениеШтрихкода + ПредставлениеШтрихкода;
	РезультатРазбора.Разобран = Истина;
	
КонецПроцедуры

Функция ТипGS1Число();
	
	Возврат "N";
	
КонецФункции

Функция ТипGS1Строка();
	
	Возврат "X";
	
КонецФункции

// Используемые идентификаторы применения по стандарту GS1.
//
Функция ИдентификаторыGS1()
	
	Результат = Новый Структура();
	Результат.Вставить("GTIN", "01");
	Результат.Вставить("СерийныйНомер", "21");
	Результат.Вставить("КлючПроверки" , "91");
	Результат.Вставить("КодПроверки"  , "92");
	Возврат Результат;
	
КонецФункции

Процедура ДобавитьКодGS1(Коды, Код, Имя, ФиксированнаяДлина = 0, ПеременнаяДлина = 0, ТипФиксированногоЗначения = Неопределено, ТипПеременногоЗначения = Неопределено, ЕстьРазделитель = Неопределено);
	
	ВставляемыеКоды = Новый Массив;
	ПоследнийСимволКода = Прав(Код, 1);
	Если СтрНайти("0123456789", ПоследнийСимволКода) = 0 Тогда
		КодБезПоследнегоСимвола = Лев(Код, СтрДлина(Код) - 1);
		Если ПоследнийСимволКода = "n" Тогда
			Описание = ОписаниеКода(КодБезПоследнегоСимвола, Имя, ФиксированнаяДлина, ПеременнаяДлина, ТипФиксированногоЗначения, ТипПеременногоЗначения, ЕстьРазделитель);
			Описание.ЕстьПоложениеДесятичнойТочки = Истина;
			Коды.Вставить(КодБезПоследнегоСимвола, Описание);
		Иначе
			Для Индекс = 0 По 9 Цикл
				НовыйКод = КодБезПоследнегоСимвола + Строка(Индекс);
				Коды.Вставить(НовыйКод, ОписаниеКода(НовыйКод, Имя, ФиксированнаяДлина, ПеременнаяДлина, ТипФиксированногоЗначения, ТипПеременногоЗначения, ЕстьРазделитель));
			КонецЦикла;
		КонецЕсли;
	Иначе
		Коды.Вставить(Код, ОписаниеКода(Код, Имя, ФиксированнаяДлина, ПеременнаяДлина, ТипФиксированногоЗначения, ТипПеременногоЗначения, ЕстьРазделитель));
	КонецЕсли;
	
КонецПроцедуры

Функция ОписаниеКода(Код, Имя, ФиксированнаяДлина = 0, ПеременнаяДлина = 0, ТипФиксированногоЗначения = Неопределено, ТипПеременногоЗначения = Неопределено, ЕстьРазделитель = Неопределено);
	
	ОписаниеКода = Новый Структура;
	ОписаниеКода.Вставить("Код", Код);
	ОписаниеКода.Вставить("Имя", Имя);
	ОписаниеКода.Вставить("ФиксированнаяДлина", ФиксированнаяДлина);
	Если ФиксированнаяДлина > 0 Тогда
		ОписаниеКода.Вставить("ТипФиксированногоЗначения", ?(ТипФиксированногоЗначения = Неопределено, ТипGS1Число(), ТипФиксированногоЗначения));
	КонецЕсли;
	ОписаниеКода.Вставить("ПеременнаяДлина", ПеременнаяДлина);
	Если ПеременнаяДлина > 0 Тогда
		ОписаниеКода.Вставить("ТипПеременногоЗначения", ?(ТипПеременногоЗначения = Неопределено, ТипGS1Число(), ТипПеременногоЗначения));
	КонецЕсли;
	ОписаниеКода.Вставить("ЕстьРазделитель", ?(ПеременнаяДлина > 0, Истина, ЗначениеЗаполнено(ЕстьРазделитель)));
	ОписаниеКода.Вставить("ЕстьПоложениеДесятичнойТочки", Ложь);
	
	Возврат ОписаниеКода;
	
КонецФункции

// Проверяет, содержит ли строка только цифры.
//
// Параметры:
//  СтрокаПроверки - Строка - проверяемая строка.
//
// Возвращаемое значение:
//   Булево - Истина - строка содержит только цифры или пустая, Ложь - строка содержит иные символы.
//
Функция ТолькоЦифрыВСтроке(Знач СтрокаПроверки)
	
	Если СтрДлина(СтрокаПроверки) = 0 Тогда
		Возврат Истина;
	КонецЕсли;
	
	Для Индекс = 1 По СтрДлина(СтрокаПроверки) Цикл
		КодСимвола = КодСимвола(Сред(СтрокаПроверки, Индекс, 1));
		Если (КодСимвола < 48) Или (КодСимвола > 57) Тогда 
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

// Проверяет, содержит ли строка символы по условию.
//
// Параметры:
//  СтрокаПроверки - Строка - проверяемая строка.
//  ДопустимыеСимволы - Строка - дополнительные разрешенные символы, кроме латиницы.
//
// Возвращаемое значение:
//  Булево - Истина, если строка содержит только латинские (или допустимые) символы;
//         - Ложь, если строка содержит иные символы.
//
Функция ПроверкаСтроки(Знач СтрокаПроверки, ДопустимыЛатПрописные = Ложь, ДопустимыЛатСтрочные = Ложь, ДопустимыЦифры = Ложь, ДопустимыеСимволы = "")
	
	КодыДопустимыхСимволов = Новый Массив;
	
	Для Индекс = 1 По СтрДлина(ДопустимыеСимволы) Цикл
		КодыДопустимыхСимволов.Добавить(КодСимвола(Сред(ДопустимыеСимволы, Индекс, 1)));
	КонецЦикла;
	
	Для Индекс = 1 По СтрДлина(СтрокаПроверки) Цикл
		КодСимвола = КодСимвола(Сред(СтрокаПроверки, Индекс, 1));
		ЭтоЛатПрописная = ?(ДопустимыЛатПрописные,(КодСимвола > 64) И (КодСимвола < 91), Ложь);
		ЭтоЛатСтрочная  = ?(ДопустимыЛатСтрочные,(КодСимвола > 96) И (КодСимвола < 123), Ложь);
		ЭтоЦифра =   ?(ДопустимыЦифры, (КодСимвола > 47) И (КодСимвола < 58), Ложь);
		Если НЕ (ЭтоЛатПрописная Или ЭтоЛатСтрочная Или ЭтоЦифра Или КодыДопустимыхСимволов.Найти(КодСимвола) <> Неопределено) Тогда 
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

// Вставить вызов в точках изменения видимости команд (групп команд) по документу-основанию
//
// Параметры:
//   Форма  - УправляемаяФорма     - форма-источник вызова.
//
Процедура УправлениеВидимостьюКомандПодключенныхКОбъекту(Форма) Экспорт
	
	КомандыОбъекта = КомандыОбъекта(Форма.ИмяФормы);
	
	ОпределитьКомандыДляУправленияВидимостью(Форма, КомандыОбъекта);
		
КонецПроцедуры

// Управление видимостью команд по документу-основанию по умолчанию:
//   Группы скрываются если документ-основание выбран, отображаются если пуст.
//
// Параметры:
//   Форма - УправляемаяФорма - источник вызова.
// Возвращаемое значение:
//   Булево - обработка безусловно завершена (элементы скрыты).
//
Функция УправлениеВидимостьюПоУмолчанию(Форма) Экспорт
	
	Если ЗначениеЗаполнено(Форма.Объект.ДокументОснование)Тогда
		Форма.Элементы.ГруппаКомандыЗаполненияОснования.Видимость = Ложь;
		Возврат Истина;
	Иначе 
		Форма.Элементы.ГруппаКомандыЗаполненияОснования.Видимость = Истина;
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

Функция КомандыОбъекта(ИмяФормы) Экспорт
	
	Результат = ПустыеГруппыКоманд();
	Возврат Результат;
	
КонецФункции

Функция ВидыПодключаемыхКоманд() Экспорт
	
	Результат = Новый Массив;
	
	ПодключаемаяКоманда = Новый Структура;
	ПодключаемаяКоманда.Вставить("Имя",           "ОформитьИС");
	ПодключаемаяКоманда.Вставить("ИмяПодменю",    "КомандыЗаполненияОснованияНовыеДокументы");
	ПодключаемаяКоманда.Вставить("Заголовок",     НСтр("ru = 'Оформить';
														|en = 'Оформить'"));
	ПодключаемаяКоманда.Вставить("Обработчик",    "ПодключаемоеОборудованиеИСМПТККлиент.ОбработатьДействиеОформленияОснования");
	ПодключаемаяКоманда.Вставить("ТипМетаданных", "Документы");
	
	Результат.Добавить(ПодключаемаяКоманда);
	
	ПодключаемаяКоманда = Новый Структура;
	ПодключаемаяКоманда.Вставить("Имя",           "ВыбратьИС");
	ПодключаемаяКоманда.Вставить("ИмяПодменю",    "КомандыЗаполненияОснованияВыборДокументов");
	ПодключаемаяКоманда.Вставить("Заголовок",     НСтр("ru = 'Выбрать';
														|en = 'Выбрать'"));
	ПодключаемаяКоманда.Вставить("Обработчик",    "ПодключаемоеОборудованиеИСМПТККлиент.ОбработатьДействиеВыбораОснования");
	ПодключаемаяКоманда.Вставить("ТипМетаданных", "Документы");
	
	Результат.Добавить(ПодключаемаяКоманда);
	
	Возврат Результат;
	
КонецФункции

Процедура ОпределитьКомандыДляУправленияВидимостью(Форма, Команды)
	
	//Не добавлять условия видимости штатным способом!
	Если Форма.ВидимостьПодключаемыхКоманд.Количество() = 0 Тогда 
		Для Каждого ИмяГруппИКоманд Из Команды Цикл
			Для Каждого ДанныеКоманды Из ИмяГруппИКоманд.Значение Цикл
				Если Форма.Команды.Найти(ДанныеКоманды.ИмяКомандыФормы) = Неопределено Тогда
					Продолжить;
				ИначеЕсли Форма.Элементы[ДанныеКоманды.ИмяКомандыФормы].Видимость Тогда
					Форма.ВидимостьПодключаемыхКоманд.Вставить(ДанныеКоманды.ИмяКомандыФормы);
					Форма.ВидимостьПодключаемыхКоманд[ДанныеКоманды.ИмяКомандыФормы] = Новый Структура("ГруппаКоманд",ИмяГруппИКоманд.Ключ);
					ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(Форма.ВидимостьПодключаемыхКоманд[ДанныеКоманды.ИмяКомандыФормы],ДанныеКоманды);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
		Если Форма.ВидимостьПодключаемыхКоманд.Количество() = 0 Тогда 
			Форма.ВидимостьПодключаемыхКоманд.Вставить("ЗаполнениеПроведено");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Функция ПустыеГруппыКоманд()
	
	Результат = Новый Структура;
	Для Каждого ВидКоманды Из ВидыПодключаемыхКоманд() Цикл
		Результат.Вставить(ВидКоманды.Имя,Новый Массив);
	КонецЦикла;
	Возврат Результат;
	
КонецФункции