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
	
	ТекстОрганизации = БухгалтерскиеОтчетыКлиентСервер.ВыгрузитьСписокВСтроку(ПараметрыОтчета.СписокСтруктурныхЕдиниц,,,Истина);
	
	ЗаголовокОтчета = НСтр("ru = 'Регистр налогового учета по счетам-фактурам %1 %2'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, ?(ПараметрыОтчета.ВидСчетаФактуры = "СчетФактураПолученный", НСтр("ru = 'полученным'"), НСтр("ru = 'выданным'")),
		БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
		
	ЗаголовокОтчета = ТекстОрганизации + Символы.ПС + ЗаголовокОтчета;
	
	Возврат ЗаголовокОтчета;
	
КонецФункции

Процедура ПриВыводеЗаголовка(ПараметрыОтчета,Результат) Экспорт
	
	СведенияОНалогоплательщике = ОбщегоНазначенияБКВызовСервера.СведенияОЮрФизЛице(ПараметрыОтчета.Налогоплательщик, ПараметрыОтчета.КонецПериода);
	
	Макет = ПолучитьОбщийМакет("ЗаголовокРегистраНалоговогоУчета");
	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	ОбластьЗаголовок.Параметры.ЗаголовокОтчета = ПолучитьТекстЗаголовка(ПараметрыОтчета);

	Если СведенияОНалогоплательщике <> Неопределено Тогда 
		ОбластьЗаголовок.Параметры.Заполнить(СведенияОНалогоплательщике);
		ОбластьЗаголовок.Параметры.НалоговыйПериод = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(НачалоДня(ПараметрыОтчета.НачалоПериода), КонецДня(ПараметрыОтчета.КонецПериода));
	КонецЕсли;
	
	Результат.Вывести(ОбластьЗаголовок);
	
КонецПроцедуры

Процедура ПриВыводеПодвала(ПараметрыОтчета, Результат) Экспорт
	
	Макет = ПолучитьОбщийМакет("ЗаголовокРегистраНалоговогоУчета");
	ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
	
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

	КомпоновщикНастроек.Настройки.Структура.ИдентификаторПользовательскойНастройки = "";
	Для Каждого ЭлементСтруктуры Из КомпоновщикНастроек.Настройки.Структура Цикл
		ЭлементСтруктуры.ИдентификаторПользовательскойНастройки = "";
		ОтчетыВызовСервераБК.ОбработатьСтруктуруНастроек(ЭлементСтруктуры);
	КонецЦикла;
	КомпоновщикНастроек.Настройки.Выбор.ИдентификаторПользовательскойНастройки = "";

	Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
	КонецЕсли;
	Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", КонецДня(ПараметрыОтчета.КонецПериода));
	КонецЕсли;
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ПредставлениеНомераДокумента"  , ПараметрыОтчета.ПредставлениеНомераДокумента);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ФормированиеПоДатеВыписки"     , ПараметрыОтчета.ФормированиеПоДатеВыписки);
	
	СписокПрефиксовУзлов = Новый СписокЗначений;
	СписокПрефиксовУзлов.ЗагрузитьЗначения(ПрефиксацияОбъектовБКВызовСервера.СписокПрефиксовУзлов());
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "глСписокПрефиксовУзлов"        , СписокПрефиксовУзлов);
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Налогоплательщик"              , ПараметрыОтчета.Налогоплательщик);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ОтветственноеЛицоРуководитель" , Перечисления.ОтветственныеЛицаОрганизаций.Руководитель);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ОтветственноеЛицоГлБухгалтер"  , Перечисления.ОтветственныеЛицаОрганизаций.ГлавныйБухгалтер);
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.СписокСтруктурныхЕдиниц) Тогда
		БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(КомпоновщикНастроек, "Организация", ПараметрыОтчета.СписокСтруктурныхЕдиниц, ВидСравненияКомпоновкиДанных.ВСписке);			
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
	
	Массив.Добавить(Новый Структура("Имя, Представление", "СчетФактураВыданный",   НСтр("ru = 'Регистр налогового учета по счетам-фактурам выданным'")));
	Массив.Добавить(Новый Структура("Имя, Представление", "СчетФактураПолученный", НСтр("ru = 'Регистр налогового учета по счетам-фактурам полученным'")));
	
	Возврат Массив;
	
КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ


#КонецЕсли