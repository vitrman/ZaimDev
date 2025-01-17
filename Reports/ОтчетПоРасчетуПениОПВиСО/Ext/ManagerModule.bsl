﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	Возврат Новый Структура("ИспользоватьПередКомпоновкойМакета,
							|ИспользоватьПослеКомпоновкиМакета,
							|ИспользоватьПослеВыводаРезультата,
							|ИспользоватьДанныеРасшифровки",
							Истина, Ложь, Истина, Истина);
							
КонецФункции

Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
	
	ЗаголовокОтчета = НСтр("ru = 'Отчет по расчету пени взносов, отчислений и единого платежа%1'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода));
	
	Возврат ЗаголовокОтчета;
	
КонецФункции

// В процедуре можно доработать компоновщик перед выводом в отчет
// Изменения сохранены не будут
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	Если ПараметрыОтчета.Свойство("ОткрытИзРассылки") И ПараметрыОтчета.ОткрытИзРассылки Тогда
		
		КомпоновщикНастроек.Настройки.Структура.ИдентификаторПользовательскойНастройки = "";
		Для Каждого ЭлементСтруктуры Из КомпоновщикНастроек.Настройки.Структура Цикл
			ЭлементСтруктуры.ИдентификаторПользовательскойНастройки = "";
			ОтчетыВызовСервераБК.ОбработатьСтруктуруНастроек(ЭлементСтруктуры);
		КонецЦикла;
		
		КомпоновщикНастроек.Настройки.Выбор.ИдентификаторПользовательскойНастройки = "";
		
	КонецЕсли;
	
	КомпоновщикНастроек.Настройки.Структура.Очистить();
	КомпоновщикНастроек.Настройки.Выбор.Элементы.Очистить();
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидОПВ",   Справочники.НалогиСборыОтчисления.ОбязательныеПенсионныеВзносы);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидСО",    Справочники.НалогиСборыОтчисления.ОбязательныеСоциальныеОтчисления);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидВОСМС", Справочники.НалогиСборыОтчисления.ВзносыОбязательноеСоциальноеМедицинскоеСтрахование);
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидООСМС", Справочники.НалогиСборыОтчисления.ОтчисленияОбязательноеСоциальноеМедицинскоеСтрахование);	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидЕП", 	 Справочники.НалогиСборыОтчисления.ЕдиныйПлатеж);	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "парамВидОПВР",  Справочники.НалогиСборыОтчисления.ОбязательныеПенсионныеВзносыРаботодателя);

	Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", НачалоДня(ПараметрыОтчета.НачалоПериода));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачалоПериода", Дата(1, 1, 1));
	КонецЕсли;
	Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", КонецДня(ПараметрыОтчета.КонецПериода));
	Иначе
		БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонецПериода", Дата(3999, 11, 1));
	КонецЕсли;
	
	БухгалтерскиеОтчеты.ДобавитьОтборПоОрганизациямИПодразделениям(КомпоновщикНастроек, ПараметрыОтчета);
	
	Структура = КомпоновщикНастроек.Настройки;
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметрВывода(КомпоновщикНастроек, "РасположениеРеквизитов", РасположениеРеквизитовКомпоновкиДанных.Отдельно); 
	ЕстьДополнительныеПоля = Ложь;		
	Для Каждого ДополнительноеПоле Из ПараметрыОтчета.ДополнительныеПоля Цикл 
		Если ДополнительноеПоле.Использование Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(КомпоновщикНастроек, ДополнительноеПоле.Поле);			
			ЕстьДополнительныеПоля = Истина;
		КонецЕсли;
	КонецЦикла;
	
	// определим какие показатели и в каком порядке показывать
	Для Каждого Показатель Из ПараметрыОтчета.Показатели Цикл
		Если Показатель.Использование Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьВыбранноеПоле(КомпоновщикНастроек, Показатель.Поле);
		КонецЕсли;
	КонецЦикла;
	
	Структура = КомпоновщикНастроек.Настройки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	Первый = Истина;
	Для Каждого ПолеВыбраннойГруппировки Из ПараметрыОтчета.Группировка Цикл 
		Если ПолеВыбраннойГруппировки.Использование Тогда
			Если Не Первый Тогда 
				Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
			КонецЕсли;
			Первый = Ложь;
						
			ПолеГруппировки = Структура.ПоляГруппировки.Элементы.Добавить(Тип("ПолеГруппировкиКомпоновкиДанных"));
			ПолеГруппировки.Использование  = Истина;
			ПолеГруппировки.Поле           = Новый ПолеКомпоновкиДанных(ПолеВыбраннойГруппировки.Поле);
			
			Если ТипЗнч(ПолеВыбраннойГруппировки.ТипГруппировки) = Тип("ПеречислениеСсылка.ТипДетализацииСтандартныхОтчетов") Тогда
				
				Если ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Иерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Иерархия;
				ИначеЕсли ПолеВыбраннойГруппировки.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.ТолькоИерархия Тогда
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.ТолькоИерархия;
				Иначе
					ПолеГруппировки.ТипГруппировки = ТипГруппировкиКомпоновкиДанных.Элементы;
				КонецЕсли;
								
			КонецЕсли;
			
			Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
			Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных")); 
			
		КонецЕсли;
	КонецЦикла;
	
	// Вывести дополнительные поля, подченив их к последнему элементу группировки.
	Если ЕстьДополнительныеПоля Тогда
		Структура = Структура.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
		Структура.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
		Структура.Порядок.Элементы.Добавить(Тип("АвтоЭлементПорядкаКомпоновкиДанных"));	
	КонецЕсли;

КонецПроцедуры

Процедура ПослеКомпоновкиМакета(ПараметрыОтчета, МакетКомпоновки) Экспорт
		
	
	
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

// Возвращает структуру параметров, наличие которых требуется для успешного формирования отчета.
//
// Возвращаемое значение:
//   Структура - структура параметров для формирования отчета.
//
Функция ПустыеПараметрыКомпоновкиОтчета() Экспорт
	
	ПараметрыОтчета = РассылкаОтчетовБК.НастройкиОтчетаСохраняемыеВРассылке();
	
	Возврат ПараметрыОтчета;
	
КонецФункции


#КонецЕсли