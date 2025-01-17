﻿
////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Запись.ИсходныйКлючЗаписи.Пустой() Тогда
		ПодготовитьФормуНаСервере();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.ДатыЗапретаИзменения
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.ДатыЗапретаИзменения
	
	ПодготовитьФормуНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// Изменение ключевых реквизитов, возможно только в монопольном режиме.
	
	Если НЕ СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации() 
		И МодифицированностьКлючевыхРеквизитов(ЭтотОбъект) Тогда
		
		Попытка
			УстановитьМонопольныйРежим(Истина);
		Исключение
			
			ТекстСообщения = НСтр(
				"ru = 'Изменение реквизитов ""Период"", ""Организация"", ""Учет временных разниц по налогу на прибыль"" возможно только в монопольном режиме.
				|Не удалось установить монопольный режим для изменения параметров учетной политики! Запись изменений невозможна по причине:
				|%1'"
			);
			
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			КраткоеПредставлениеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, КраткоеПредставлениеОшибки);
			
			ОбщегоНазначения.СообщитьПользователю(
				ТекстСообщения,
				,
				,
				"Запись",
				Отказ
			);
			
		КонецПопытки
			
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

	Если НЕ СтандартныеПодсистемыСервер.ЭтоБазоваяВерсияКонфигурации() Тогда
		УстановитьМонопольныйРежим(Ложь);
	КонецЕсли;
	
	ПодготовитьФормуНаСервере();
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ИзменениеУчетнойПолитикиБухгалтерскийУчет");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;

	ОбновитьИнтерфейс();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	ПроверитьПризнакПлательщикаКПН();
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	ПроверитьПризнакПлательщикаКПН();
КонецПроцедуры

&НаКлиенте
Процедура УчетВременныхРазницПоНалогуНаПрибыльПриИзменении(Элемент)
	
	ПроверитьПризнакПлательщикаКПН();
	
	Запись.ВедениеУчетаВременныхРазницБалансовымМетодом = Запись.УчетВременныхРазницПоНалогуНаПрибыль;

	ВедениеУчетаВременныхРазницБалансовымМетодомПриИзмененииНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ВедениеУчетаВременныхРазницБалансовымМетодомПриИзменении(Элемент)
	
	ВедениеУчетаВременныхРазницБалансовымМетодомПриИзмененииНаКлиенте();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура ПодготовитьФормуНаСервере()
	
	Если Запись.ИсходныйКлючЗаписи.Пустой() И НЕ ЗначениеЗаполнено(Запись.Организация) Тогда 
		Запись.Организация = Справочники.Организации.ОрганизацияПоУмолчанию(Запись.Организация);
	КонецЕсли;
	
	ПредыдущийПериод = Запись.Период;
	ПредыдущаяОрганизация = Запись.Организация;
	ПредыдущийПризнакУчетаВременныхРазниц = Запись.УчетВременныхРазницПоНалогуНаПрибыль;
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Запись   = Форма.Запись;
	Элементы = Форма.Элементы;
	
	Элементы.ВедениеУчетаВременныхРазницБалансовымМетодом.Доступность = Запись.УчетВременныхРазницПоНалогуНаПрибыль;
	Элементы.НадписьПомощникПерехода.Доступность = Запись.ВедениеУчетаВременныхРазницБалансовымМетодом И Запись.УчетВременныхРазницПоНалогуНаПрибыль;
	
	#Если НаКлиенте Тогда
		ВедетсяУчетОсновныхСредств = Вычислить("ПолучитьФункциональнуюОпциюИнтерфейса(""ВедетсяУчетОсновныхСредств"")");
	#Иначе	
		ВедетсяУчетОсновныхСредств = Вычислить("ПолучитьФункциональнуюОпцию(""ВедетсяУчетОсновныхСредств"")");
	#КонецЕсли
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы, "ГруппаПараметрыНачисленияАмортизации", "Видимость", ВедетсяУчетОсновныхСредств);
	
КонецПроцедуры

&НаКлиенте
Процедура ВедениеУчетаВременныхРазницБалансовымМетодомПриИзмененииНаКлиенте()
	
	УправлениеФормой(ЭтотОбъект);
	
	Если Запись.УчетВременныхРазницПоНалогуНаПрибыль И НЕ Запись.ВедениеУчетаВременныхРазницБалансовымМетодом Тогда 
		
			
		ТекстСообщения = НСтр("ru = 'Внимание! Снимать признак ""Ведение учета временных разниц балансовым методом"" при включенном признаке "" Учет временных разниц по налогу на прибыль"" нельзя. В конфигурации поддерживается учет временных разниц только балансовым методом.'");
							 
		ОбщегоНазначенияКлиент.СообщитьПользователю(
			ТекстСообщения,
			,
			,
			"Запись",
			);
		
		Запись.ВедениеУчетаВременныхРазницБалансовымМетодом = Истина;
		
		Возврат;
		
	КонецЕсли;
	
	
	ТекстСообщения = НСтр("ru = 'Внимание! После установки признака ""Ведение учета временных разниц балансовым методом"", для дальнейшей корректной работы с данными по налоговому учета необходимо выполнить следующие действия:
							 |		1. Сформировать документ ""Закрытие месяца"" с регламентной операцией ""Закрытие счетов НУ"" на дату введения новых настроек в учетной политике по бухгалтерскому учету.
							 |		2. Ввести начальные остатки налогового учета по данным бухгалтерского учета, используя документ ""Ввод начальных остатков по прочим разделам""'");
							 
	ОбщегоНазначенияКлиент.СообщитьПользователю(
		ТекстСообщения,
		,
		,
		"Запись",
		);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьПризнакПлательщикаКПН()
	
	Если Запись.УчетВременныхРазницПоНалогуНаПрибыль Тогда
		// если предприятие не является плательщиком КПН
		// учет временных разниц не возможен
		Если НЕ ПроцедурыНалоговогоУчета.ПолучитьПризнакПлательщикаНалогаНаПрибыль(Запись.Организация, Запись.Период) Тогда
			ОбщегоНазначения.СообщитьПользователю(
				НСтр("ru='Для организации, не являющейся плательщиком налога на прибыль, учет временных разниц не возможен.'"),
				,
				"УчетВременныхРазницПоНалогуНаПрибыль",
				"Запись",
				);
			Запись.УчетВременныхРазницПоНалогуНаПрибыль = Ложь;
			Запись.ВедениеУчетаВременныхРазницБалансовымМетодом = Запись.УчетВременныхРазницПоНалогуНаПрибыль;
			
			УправлениеФормой(ЭтотОбъект);
			
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция МодифицированностьКлючевыхРеквизитов(Форма)
	
	Запись = Форма.Запись;
	
	Если Запись.Период <> Форма.ПредыдущийПериод ИЛИ
		Запись.Организация <> Форма.ПредыдущаяОрганизация ИЛИ
		Запись.УчетВременныхРазницПоНалогуНаПрибыль <> Форма.ПредыдущийПризнакУчетаВременныхРазниц Тогда
		
		Возврат Истина;
	КонецЕсли;
		
	Возврат Ложь;
	
КонецФункции	

