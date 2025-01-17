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

Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
	
	ЗаголовокОтчета = НСтр("ru = 'Вычеты по инвестиционным налоговым преференциям %1'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
	
	Возврат ЗаголовокОтчета;
	
КонецФункции

Процедура ПриВыводеЗаголовка(ПараметрыОтчета,Результат) Экспорт
	
	//////////////////////////////////////////////////////////////////////////////
	// Вывести заголовок 1.
	
	МакетЗаголовок   = ПолучитьОбщийМакет("ЗаголовокРегистраНалоговогоУчета");
	ОбластьЗаголовок = МакетЗаголовок.ПолучитьОбласть("Заголовок_388");
	
	ОбластьЗаголовок.Параметры.НомерПриложения  = "1";
	ОбластьЗаголовок.Параметры.ЗаголовокОтчета  = "Налоговый регистр" + Символы.ПС + "по применению инвестиционных налоговых преференций";
	ОбластьЗаголовок.Параметры.ЗаголовокТаблицы = "Вычеты по инвестиционным налоговым преференциям";
	
	ОбластьЗаголовок.Параметры.ДопПоле = "(тенге)";	
	
	СведенияОНалогоплательщике = ОбщегоНазначенияБКВызовСервера.СведенияОЮрФизЛице(ПараметрыОтчета.Налогоплательщик, ПараметрыОтчета.КонецПериода);
	
	Если СведенияОНалогоплательщике <> Неопределено Тогда 
		ОбластьЗаголовок.Параметры.Заполнить(СведенияОНалогоплательщике);
		ОбластьЗаголовок.Параметры.НалоговыйПериод = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(НачалоДня(ПараметрыОтчета.НачалоПериода), КонецДня(ПараметрыОтчета.КонецПериода), Истина);
	КонецЕсли;
		
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
	
КонецПроцедуры

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
	КонецЕсли;
	Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", КонецДня(ПараметрыОтчета.КонецПериода));
	КонецЕсли;
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидУчетаНУ"  , Справочники.ВидыУчетаНУ.НУ);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидЛьготыФА" , Перечисления.ВидыФАУчитываемыхОтдельно.ОбъектыПреференций);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВидРемонтаОС", Перечисления.ВидыРемонтаВА.Преференции);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Событие"     , Перечисления.СобытияФАУчитываемыхОтдельно.ПринятиеКУчету);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетовН312"  , ПланыСчетов.Налоговый.ВАНеВключенныеВСтоимостнойБаланс);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетовН340"  , ПланыСчетов.Налоговый.ПреренцииДоВводаВЭксплуатацию);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "СчетовН860"  , ПланыСчетов.Налоговый.РасходыНаРемонтВА);
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.СписокСтруктурныхЕдиниц) Тогда
		БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(КомпоновщикНастроек, "СписокОрганизаций", ПараметрыОтчета.СписокСтруктурныхЕдиниц, ВидСравненияКомпоновкиДанных.ВСписке);			
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);

КонецПроцедуры

Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	
	Схема = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
	Для Каждого Вариант из Схема.ВариантыНастроек Цикл
		НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, Вариант.Имя);
	КонецЦикла;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ


#КонецЕсли