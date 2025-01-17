﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
							|ИспользоватьПослеКомпоновкиМакета,
							|ИспользоватьПослеВыводаРезультата,
							|ИспользоватьДанныеРасшифровки,
							|ИспользоватьПриВыводеЗаголовка,
							|ИспользоватьПриВыводеПодвала",
							Истина, Ложь, Истина, Истина, Истина, Истина);
							
КонецФункции

Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина, ВыводитьПериод = Истина) Экспорт
	
	Если ПараметрыОтчета.ВидРегистраОтчета = "АмортизацияФАиДр" Тогда 
		ЗаголовокОтчета = НСтр("ru = 'Амортизационные отчисления и другие вычеты по фиксированным активам %1'");
	ИначеЕсли ПараметрыОтчета.ВидРегистраОтчета = "РасшифровкаАмортизационныхОтчислений" Тогда 
		ЗаголовокОтчета = НСтр("ru = 'Расшифровка амортизационных отчислении  и других вычетов по фиксированным активам %1'");
	ИначеЕсли ПараметрыОтчета.ВидРегистраОтчета = "ДвойнаяНормаАмортизацииФА" Тогда 
		ЗаголовокОтчета = НСтр("ru = 'Амортизационные отчисления по фиксированным активам, впервые введенным в эксплуатацию на территории Республики Казахстан %1'");
	КонецЕсли;
	
	Если ВыводитьПериод Тогда
	
		ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
			
	Иначе
		
		ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ЗаголовокОтчета, "");		
		ЗаголовокОтчета = СокрЛП(ЗаголовокОтчета);
		
	КонецЕсли;
		
	Возврат ЗаголовокОтчета;
	
КонецФункции

Процедура ПриВыводеЗаголовка(ПараметрыОтчета,Результат) Экспорт
	
	Макет = ПолучитьОбщийМакет("ЗаголовокРегистраНалоговогоУчета");
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок_388");
	
	ОбластьЗаголовок.Параметры.НомерПриложения  = "2";
	ОбластьЗаголовок.Параметры.ЗаголовокОтчета  = "Налоговый регистр" + Символы.ПС + "по определению стоимостных балансов групп (подгрупп)"
	                                            + Символы.ПС + "фиксированных активов и последующим расходам по"
	                                            + Символы.ПС + "фиксированным активам";
	ОбластьЗаголовок.Параметры.ЗаголовокТаблицы = ПолучитьТекстЗаголовка(ПараметрыОтчета, , Ложь);

	СведенияОНалогоплательщике = ОбщегоНазначенияБКВызовСервера.СведенияОЮрФизЛице(ПараметрыОтчета.Налогоплательщик, ПараметрыОтчета.КонецПериода);
	Если СведенияОНалогоплательщике <> Неопределено Тогда 
		ОбластьЗаголовок.Параметры.Заполнить(СведенияОНалогоплательщике);
		ОбластьЗаголовок.Параметры.НалоговыйПериод = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(НачалоДня(ПараметрыОтчета.НачалоПериода), КонецДня(ПараметрыОтчета.КонецПериода), Истина);
	КонецЕсли;
	
	ОбластьЗаголовок.Параметры.ДопПоле  = "(тенге)";
	
	Результат.Вывести(ОбластьЗаголовок);	
	
КонецПроцедуры

Процедура ПриВыводеПодвала(ПараметрыОтчета, Результат) Экспорт
	
	Макет = ПолучитьОбщийМакет("ЗаголовокРегистраНалоговогоУчета");
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал_388");
	
	Если ПараметрыОтчета.Налогоплательщик <> Неопределено Тогда 
		ОтветЛица = ОбщегоНазначенияБКВызовСервера.ОтветственныеЛицаОрганизаций(ПараметрыОтчета.Налогоплательщик, ПараметрыОтчета.КонецПериода);
		ОбластьПодвал.Параметры.ФИОРуководителя = ОтветЛица.Руководитель;
		ОбластьПодвал.Параметры.ФИОглБухгалтера = ОтветЛица.ГлавныйБухгалтер;
		ОбластьПодвал.Параметры.ФИОИсполнителя 	= ОтветЛица.ОтветственныйЗаРегистры;
		ОбластьПодвал.Параметры.ДатаСоставления = Формат(ОбщегоНазначения.ТекущаяДатаПользователя(), "ДФ=""дд ММММ гггг 'г.'""");
	КонецЕсли;
	
	Результат.Вывести(ОбластьПодвал);

	ОбластьПодвал = Макет.ПолучитьОбласть("Примечание_388ГК");
	Результат.Вывести(ОбластьПодвал);
	
КонецПроцедуры

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	СостоянияФА = Новый СписокЗначений();	
	СостоянияФА.Добавить(Перечисления.ВидыСостоянийФА.ПринятКУчету);
	СостоянияФА.Добавить(Перечисления.ВидыСостоянийФА.Выбыл);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода"    , ПараметрыОтчета.НачалоПериода);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода"     , КонецДня(ПараметрыОтчета.КонецПериода));
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаНачала"       , ПараметрыОтчета.НачалоПериода);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания"    , КонецДня(ПараметрыОтчета.КонецПериода));
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПустаяГруппаНУ"   , Справочники.ГруппыНалоговогоУчетаФА.ПустаяСсылка());	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПустаяОрганизация", Справочники.Организации.ПустаяСсылка());	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокОрганизаций", ПараметрыОтчета.СписокСтруктурныхЕдиниц);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СостоянияФА"      , СостоянияФА);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчетПоОбъектам"   , Перечисления.ВидыНалоговогоУчетаВГруппахФА.ПоОбъектам);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидУчетаНУ"       , Справочники.ВидыУчетаНУ.НУ);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеПоступления", Перечисления.ВидыДвиженияСтоимостиФА.Поступление);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеВыбытия"    , Перечисления.ВидыДвиженияСтоимостиФА.Выбытие);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеАмортизации", Перечисления.ВидыДвиженияСтоимостиФА.Амортизация);
	
	СписокСубконтоСчетаРемонта =  Новый СписокЗначений();
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
	СписокСубконтоСчетаРемонта.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", СписокСубконтоСчетаРемонта);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА", ПланыСчетов.Налоговый.РасходыНаРемонтВА);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА", ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);

	
	Если ПараметрыОтчета.ВидРегистраОтчета = "АмортизацияФАиДр" Тогда 
		
		МассивСубконтоЗатратНаРемонт = Новый СписокЗначений();
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЛьготыФА"  , Перечисления.ВидыФАУчитываемыхОтдельно.ОбъектыПреференций);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"               , ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);		//Счет Н311
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА"             , ПланыСчетов.Налоговый.РасходыНаРемонтВА);	    //Счет Н860
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Капитальный"  , Перечисления.ВидыРемонтаВА.Капитальный);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Текущий"      , Перечисления.ВидыРемонтаВА.Текущий);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", МассивСубконтоЗатратНаРемонт);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчитываетсяОтдельноОтСтоимостногоБаланса", Перечисления.СобытияФАУчитываемыхОтдельно.ПринятиеКУчету);	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаМенееМинимума"    , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеСтоимостногоБалансаГруппыМенееМинимума);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаВыбывших"         , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеПриВыбытииВсехАктивовГруппы);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеУвеличениеСтоимостиЗаСчетРемонта", Перечисления.ВидыДвиженияСтоимостиФА.УвеличениеСтоимостиЗаСчетРемонта);
	
	ИначеЕсли ПараметрыОтчета.ВидРегистраОтчета = "РасшифровкаАмортизационныхОтчислений" Тогда 
		
		МассивСубконтоЗатратНаРемонт = Новый СписокЗначений();
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВнеоборотныеАктивы);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.ВидыРемонтаВА);
		МассивСубконтоЗатратНаРемонт.Добавить(ПланыВидовХарактеристик.ВидыСубконтоТиповые.СтатьиЗатрат);
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЛьготыФА", Перечисления.ВидыФАУчитываемыхОтдельно.ОбъектыПреференций);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"               , ПланыСчетов.Налоговый.ВАВключенныеВСтоимостнойБаланс);		//Счет Н311
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетРемонтаВА"             , ПланыСчетов.Налоговый.РасходыНаРемонтВА);	    //Счет Н860
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Капитальный"  , Перечисления.ВидыРемонтаВА.Капитальный);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаВА_Текущий"      , Перечисления.ВидыРемонтаВА.Текущий);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СписокСубконтоСчетаРемонта", МассивСубконтоЗатратНаРемонт);
	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "УчитываетсяОтдельноОтСтоимостногоБаланса", Перечисления.СобытияФАУчитываемыхОтдельно.ПринятиеКУчету);	
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаМенееМинимума"    , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеСтоимостногоБалансаГруппыМенееМинимума);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеСписаниеБалансаВыбывших"         , Перечисления.ВидыДвиженияСтоимостиФА.СписаниеПриВыбытииВсехАктивовГруппы);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДвижениеУвеличениеСтоимостиЗаСчетРемонта", Перечисления.ВидыДвиженияСтоимостиФА.УвеличениеСтоимостиЗаСчетРемонта);

	ИначеЕсли ПараметрыОтчета.ВидРегистраОтчета = "ДвойнаяНормаАмортизацииФА" Тогда 
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Период"                 , КонецДня(ПараметрыОтчета.КонецПериода));
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания1ГодНазад" , ДобавитьМесяц(КонецДня(ПараметрыОтчета.КонецПериода), -12));
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ДатаОкончания2ГодаНазад", ДобавитьМесяц(КонецДня(ПараметрыОтчета.КонецПериода), -24));
		
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетУчетаВА"            , ПланыСчетов.Налоговый.ВнеоборотныеАктивы);		//Счет Н300
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВключенВСоставГруппы"   , Перечисления.СобытияФАУчитываемыхОтдельно.ВключениеВСоставГруппы);	    
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Выбыл"                  , Перечисления.ВидыСостоянийФА.Выбыл);
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПринятКУчету"           , Перечисления.ВидыСостоянийФА.ПринятКУчету);
		
	КонецЕсли;
	
	Если ПараметрыОтчета.ОбщиеИтоги Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметрВывода(КомпоновщикНастроек, "ВертикальноеРасположениеОбщихИтогов", РасположениеИтоговКомпоновкиДанных.Конец);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);

КонецПроцедуры

Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	ВариантыНастроек = ВариантыНастроек();
	Для Каждого Вариант Из ВариантыНастроек Цикл
		НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, Вариант.Имя);
	КонецЦикла;	
	
КонецПроцедуры

//Процедура используется подсистемой варианты отчетов
//
Процедура НастройкиОтчета(Настройки) Экспорт
	
	ВариантыНастроек = ВариантыНастроек();
	Для Каждого Вариант Из ВариантыНастроек Цикл
		Настройки.ОписаниеВариантов.Вставить(Вариант.Имя, Вариант.Представление);
	КонецЦикла;
	
КонецПроцедуры

Функция ВариантыНастроек() Экспорт
	                                                                                 
	Массив = Новый Массив;
	
	Массив.Добавить(Новый Структура("Имя, Представление", "АмортизацияФАиДр",   НСтр("ru = 'Амортизационные отчисления и другие вычеты по фиксированным активам'")));
	Массив.Добавить(Новый Структура("Имя, Представление", "РасшифровкаАмортизационныхОтчислений", НСтр("ru = 'Расшифровка амортизационных отчислении  и других вычетов по фиксированным активам'")));
	Массив.Добавить(Новый Структура("Имя, Представление", "ДвойнаяНормаАмортизацииФА", НСтр("ru = 'Амортизационные отчисления по фиксированным активам, впервые введенным в эксплуатацию на территории Республики Казахстан'")));
	
	Возврат Массив;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ


#КонецЕсли