﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПЕРЕМЕННЫЕ МОДУЛЯ

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
КонецПроцедуры 

Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	БухгалтерскиеОтчетыВызовСервера.ПередЗагрузкойНастроекВКомпоновщик(ЭтотОбъект, Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД);
	
КонецПроцедуры

Процедура ЗаполнитьНастройкиОтчетаРассылка(Настройки, ФормаОтчета) Экспорт
	
	ОтчетСтруктура = БухгалтерскиеОтчетыВызовСервера.ОбъектОтчетаВСтруктуру(ЭтотОбъект);
	Для Каждого Настройка Из Настройки Цикл
		Если ОтчетСтруктура.Свойство(Настройка.Реквизит) Тогда
			ОтчетСтруктура[Настройка.Реквизит] = Настройка.Значение;
		КонецЕсли;
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ОтчетСтруктура);
	
	Если ЗначениеЗаполнено(ПериодОтчета) Тогда
		НачалоПериода = ПериодОтчета.ДатаНачала;
		КонецПериода  = КонецДня(ПериодОтчета.ДатаОкончания);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СписокФизическихЛиц) Тогда
		//СписокСотрудниковПоФизлицам = ПолучитьСотрудников(ЭтотОбъект);
		//Если ЗначениеЗаполнено(СписокСотрудниковПоФизлицам) Тогда
		//	СписокСотрудников = Неопределено;
		//	СписокСотрудников = Новый СписокЗначений;
		//	СписокСотрудников.ЗагрузитьЗначения(СписокСотрудниковПоФизлицам.ВыгрузитьЗначения());
		//КонецЕсли;
		СписокСотрудников = Неопределено;
		Если ТипЗнч(СписокФизическихЛиц) = Тип("СписокЗначений") Тогда
			ФормаОтчета.ВидСравненияРаботника = ВидСравнения.ВСпискеПоИерархии;
		Иначе
			ФормаОтчета.ВидСравненияРаботника = ВидСравнения.Равно;
		КонецЕсли;
	Иначе
		Если ТипЗнч(СписокСотрудников) = Тип("СписокЗначений") Тогда
			ФормаОтчета.ВидСравненияРаботника = ВидСравнения.ВСпискеПоИерархии;
		Иначе
			ФормаОтчета.ВидСравненияРаботника = ВидСравнения.Равно;
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗнч(СписокОрганизаций) = Тип("СписокЗначений") Тогда
		ФормаОтчета.ВидСравненияОрганизации = ВидСравнения.ВСписке;
	Иначе
		ФормаОтчета.ВидСравненияОрганизации = ВидСравнения.Равно;
	КонецЕсли;
	
	Если ТипЗнч(СписокПодразделений) = Тип("СписокЗначений") Тогда
		ФормаОтчета.ВидСравненияПодразделения = ВидСравнения.ВСпискеПоИерархии;
	Иначе
		ФормаОтчета.ВидСравненияПодразделения = ВидСравнения.Равно;
	КонецЕсли;
	
	//Если ТипЗнч(СписокСотрудников) = Тип("СписокЗначений") Тогда
	//	ФормаОтчета.ВидСравненияРаботника = ВидСравнения.ВСпискеПоИерархии;
	//Иначе
	//	ФормаОтчета.ВидСравненияРаботника = ВидСравнения.Равно;
	//КонецЕсли;
	
	ДополнительныеСвойства = КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
	ДополнительныеСвойства.Вставить("ПропуститьПроверкуЗаполнения", Истина);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	БухгалтерскиеОтчетыВызовСервера.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, Новый Структура("КорректностьПериода", Истина));
	
КонецПроцедуры

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)

	ПараметрыОтчета = БухгалтерскиеОтчетыВызовСервера.ОбъектОтчетаВСтруктуру(ЭтотОбъект);
	СтандартнаяОбработка = Ложь;
	
	ДокументРезультат.Очистить();
	
	ОтчетМетаданные = Метаданные();
	ИмяОтчета       = ОтчетМетаданные.ПолноеИмя();
	МенеджерОтчета  = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(ИмяОтчета);

	ПараметрПериод = Неопределено;
	ПараметрыОтчета.Свойство("ПериодОтчета", ПараметрПериод);
	Если ЗначениеЗаполнено(ПараметрПериод) Тогда
		ПараметрыОтчета.НачалоПериода = ПараметрПериод.ДатаНачала;
		ПараметрыОтчета.КонецПериода  = КонецДня(ПараметрПериод.ДатаОкончания);
	КонецЕсли;
	
	ПараметрФизЛица = Неопределено;
	ПараметрыОтчета.Свойство("СписокФизическихЛиц", ПараметрФизЛица);
	Если ЗначениеЗаполнено(ПараметрФизЛица) Тогда
		//ПараметрыОтчета.СписокСотрудников = ПолучитьСотрудников(ПараметрыОтчета);
		ПараметрыОтчета.СписокСотрудников = Неопределено;
		ПараметрыОтчета.Вставить("СписокФизЛиц", ПараметрФизЛица);
		Если ТипЗнч(ПараметрФизЛица) = Тип("СписокЗначений") Тогда
			ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.ВСпискеПоИерархии);
		Иначе
			ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.Равно);
		КонецЕсли;
	Иначе
		Если ТипЗнч(ПараметрыОтчета.СписокСотрудников) = Тип("СписокЗначений") Тогда
			ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.ВСпискеПоИерархии);
		Иначе
			ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.Равно);
		КонецЕсли;
	КонецЕсли;
	
	ПараметрыОтчета.Вставить("ИдентификаторОтчета",       СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяОтчета, ".")[1]);
	
	Если ТипЗнч(ПараметрыОтчета.СписокОрганизаций) = Тип("СписокЗначений") Тогда
		ПараметрыОтчета.Вставить("ВидСравненияОрганизации", ВидСравнения.ВСписке);
	Иначе
		ПараметрыОтчета.Вставить("ВидСравненияОрганизации", ВидСравнения.Равно);
	КонецЕсли;
	
	Если ТипЗнч(ПараметрыОтчета.СписокПодразделений) = Тип("СписокЗначений") Тогда
		ПараметрыОтчета.Вставить("ВидСравненияПодразделения", ВидСравнения.ВСпискеПоИерархии);
	Иначе
		ПараметрыОтчета.Вставить("ВидСравненияПодразделения", ВидСравнения.Равно);
	КонецЕсли;
	
	//Если ТипЗнч(ПараметрыОтчета.СписокСотрудников) = Тип("СписокЗначений") Тогда
	//	ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.ВСпискеПоИерархии);
	//Иначе
	//	ПараметрыОтчета.Вставить("ВидСравненияРаботника", ВидСравнения.Равно);
	//КонецЕсли;
	
	// Формирование отчета и помещение результата во временное хранилище.
	АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено);
	МенеджерОтчета.СформироватьОтчет(ПараметрыОтчета, АдресХранилища);
	
	// Получение результатов формирования и копирование результатов в параметр "ДокументРезультат".
	ДанныеОтчета = ПолучитьИзВременногоХранилища(АдресХранилища);
	ДокументРезультат.Вывести(ДанныеОтчета.Результат);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Процедура ЗаполнитьНастройкамиПоУмолчанию(ЗаполняемыеНастройки, ОтчетОбъект) Экспорт
	
	Если ОтчетОбъект.РежимРасшифровки Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗаполняемыеНастройки.Свойство("Группировка") И ЗаполняемыеНастройки.Группировка Тогда
	
		ТаблицаГруппировка = ОтчетОбъект.Группировка;

		ТаблицаГруппировка.Очистить();
		
		Если ПользователиБКВызовСервераПовтИсп.ПолучитьЗначениеПоУмолчанию(
				ПользователиКлиентСервер.ТекущийПользователь(), "УчетПоВсемОрганизациям") Тогда
			НоваяСтрока = ТаблицаГруппировка.Добавить();
			НоваяСтрока.Поле           = "Организация";
			НоваяСтрока.Использование  = Ложь;
			НоваяСтрока.Представление  = НСтр("ru = 'Организация'");
			НоваяСтрока.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Элементы;	
		КонецЕсли;
		
		НоваяСтрока = ТаблицаГруппировка.Добавить();
		НоваяСтрока.Поле           = "ВидРасхода";
		НоваяСтрока.Использование  = Истина;
		НоваяСтрока.Представление  = НСтр("ru = 'Вид расхода'");
		НоваяСтрока.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Элементы;	
		
		НоваяСтрока = ТаблицаГруппировка.Добавить();
		НоваяСтрока.Поле           = "Счет";
		НоваяСтрока.Использование  = Ложь;
		НоваяСтрока.Представление  = НСтр("ru = 'Счет'");
		НоваяСтрока.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Иерархия;
		
		НоваяСтрока = ТаблицаГруппировка.Добавить();
		НоваяСтрока.Поле           = "КорСчет";
		НоваяСтрока.Использование  = Ложь;
		НоваяСтрока.Представление  = НСтр("ru = 'Кор. счет'");
		НоваяСтрока.ТипГруппировки = Перечисления.ТипДетализацииСтандартныхОтчетов.Иерархия;	
		
	КонецЕсли;
	
КонецПроцедуры

//Функция ПолучитьСотрудников(ПараметрыОтчета)
//	
//	Если ЗначениеЗаполнено(ПараметрыОтчета.СписокОрганизаций) Тогда
//		УсловиеОрганизации = " И ОбособленноеПодразделение В(&парамОрганизация)";
//	Иначе
//		УсловиеОрганизации = "";
//	КонецЕсли;
//		
//	Запрос = Новый Запрос;
//	Запрос.Текст = "
//	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
//	|	РаботникиОрганизации.Сотрудник,
//	|	РаботникиОрганизации.Организация,
//	|	РаботникиОрганизации.Период
//	|ИЗ
//	|	РегистрСведений.РаботникиОрганизаций.СрезПоследних(
//	|		&парамДатаАктуальности, 
//	|		Сотрудник.ФизЛицо В(&парамФизЛицо)" + УсловиеОрганизации + ") КАК РаботникиОрганизации
//	|УПОРЯДОЧИТЬ ПО
//	|	РаботникиОрганизации.Период УБЫВ // берем ближайщее к дате отчета назначение
//	|";
//	
//	Запрос.УстановитьПараметр("парамОрганизация",        ПараметрыОтчета.СписокОрганизаций);
//	Запрос.УстановитьПараметр("парамФизЛицо",                    ПараметрыОтчета.СписокФизическихЛиц);
//	Запрос.УстановитьПараметр("парамДатаАктуальности",           ПараметрыОтчета.КонецПериода);
//                  			
//	СписокПолученныхСотрудников = Новый СписокЗначений;
//	
//	Выборка = Запрос.Выполнить().Выбрать();
//	Пока Выборка.Следующий() Цикл
//		СписокПолученныхСотрудников.Добавить(Выборка.Сотрудник);
//	КонецЦикла;
//	
//	Возврат СписокПолученныхСотрудников;
//	
//КонецФункции


////////////////////////////////////////////////////////////////////////////////
// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ

#КонецЕсли
